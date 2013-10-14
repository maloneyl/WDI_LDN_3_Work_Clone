# Ask user for the "from" and the "to" and store them
# Calculate the distance in terms of the number of stops

# As all lines intersect at Union Square, distance between anything cross-lines should be
# number of stops from Union Sq on its own line + number of stops from Union Sq on the other line

# If to-from are on the same line, then the distance is just their index differences

# # For section readability
# require 'rainbow'

# Our 3 lines



# n = [ "station1", "station2", … ]
# l = [ "stationA", "stationB", … ]
# mta[:n] = n
# mta[:l] = l

class MtaController < ApplicationController

    LINE_N = [ "Times Square", "34th", "28th", "23rd", "Union Square", "8th" ]
    LINE_L = [ "8th", "6th", "Union Square", "3rd", "1st" ]
    LINE_6 = [ "Grand Central", "33rd", "28th", "23rd", "Union Square", "Astor Place" ]

  def index
    @line_n = LINE_N
    @line_l = LINE_L
    @line_6 = LINE_6
  end

  def result
    case params[:from_line]
    when "line_n" then origin_line = LINE_N;
    when "line_l" then origin_line = LINE_L;
    when "line_6" then origin_line = LINE_6;
    end
    case params[:to_line]
    when "line_n" then destination_line = LINE_N;
    when "line_l" then destination_line = LINE_L;
    when "line_6" then destination_line = LINE_6;
    end      
    origin_stop = origin_line.index(params[:from_stop])
    destination_stop = destination_line.index(params[:to_stop])
    if origin_line == destination_line
      @distance = (origin_stop - destination_stop).abs
    else 
      origin_distance_from_union_square = origin_stop - origin_line.index("Union Square")
      destination_distance_from_union_square = destination_stop - destination_line.index("Union Square")
      @distance = origin_distance_from_union_square.abs + destination_distance_from_union_square.abs
    end
  end

end
