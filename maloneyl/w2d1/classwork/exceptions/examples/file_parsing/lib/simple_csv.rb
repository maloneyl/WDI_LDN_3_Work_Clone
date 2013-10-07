module SimpleCsv
  
  # our custom exception hierarchy
  
  # SimpleCsv::Error will be our most basic error
  # NOTE: we inherit from StandardError not Exception
  class Error < StandardError; end
  
  # The next level of errors inherit from our basic error
  class FileMissingError < Error; end
  class FormatError < Error; end
  
  # Here we define several format error classes
  class InvalidHeadingError < FormatError; end
  class InconsistentColumnsError < FormatError; end
  
  class Reader
    
    attr_reader :filename, :data
    
    def initialize(filename, header_row=true)
      @filename = filename
      @header_row = header_row
      @current_line = 0
      @headings = []
      @data = []
    end
    
    # does the file contain a header row?
    def header_row?
      @header_row
    end
    
    # read the file, ensuring we close the file-handle if anything goes wrong
    def parse_file
      f = open_file
      puts "INFO: opened file-handle to #{filename}"
      begin
        process_file f
      ensure
        puts "INFO: closed file-handle to #{filename}"
        f.close
      end
    end
    
    private
    
    # trap UNIX missing file error and replace with our own
    # NOTE use of rescue without begin/end (def/end plays the same role)
    def open_file
      File.open filename
    rescue Errno::ENOENT => e # ENOENT is a standard error from Unix
      new_e = SimpleCsv::FileMissingError.new "can't find the file: #{filename}"
      new_e.set_backtrace e.backtrace
      raise new_e
    end
    
    # process the file a line at a time
    def process_file(f)
      get_headings(f.gets) if header_row? 
      while str = f.gets
        get_data(str)
      end
    end
    
    # get the column headings from the first row
    def get_headings(heading_row)
      @headings = parse_row heading_row
      validate_headings heading_row
    end
    
    # extract data from a row taken from the CSV file
    def get_data(str)
      data_hash = {}
      data_array = parse_row(str)
      validate_data(data_array)
      data_array.each_with_index do |value, i|
        key = if @headings[i]
          @headings[i]
        else
          "field_#{i}"
        end
        data_hash[key.to_sym] = value
      end
      @data << data_hash
    end
    
    # split the row on each comma and convert each sub-string to a ruby data-type
    # NOTE: this isn't very robust! Use a proper CSV library if you need one
    def parse_row(str)
      @current_line += 1
      str.split(",").map do |val|
        val.chomp!
        val.strip!
        if val.start_with?('"')
          # string starts with a double-quote?, must be a string then
          val[1..-2] # array slice
        elsif val.empty?
          # an empty string? then no value was given
          nil
        elsif val.include?('.')
          # a string without double quotes? we must have a number...
          # and if it has a period, it must be a float
          val.to_f
        else
          # otherwise, it must be an integer
          val.to_i
        end
      end
    end
    
    # ensure that all rows have the same number of columns as the first row
    def validate_data(data_array)
      if @num_columns && @num_columns != data_array.length
        raise SimpleCsv::InconsistentColumnsError, "all rows must have the same number of columns as the first (i.e. #{@num_columns}) but line #{@current_line} has #{data_array.length}"
      else
        @num_columns = data_array.length
      end
    end
    
    # ensure that all headings are double-quote delimited strings
    def validate_headings(heading_row)
      unless @headings.all? { |heading| heading.is_a?(String) } # .all means step through all elements in the array
        raise SimpleCsv::InvalidHeadingError, "expected all headings to be (double-quote delimited) strings but got: #{heading_row}"
      end
    end
    
  end
end