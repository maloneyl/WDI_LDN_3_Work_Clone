class Sorting

    # Do first to have test_array available for all functions
    # require 'benchmark'
  def self.initialize
    $test_array_large = Array.new(100_000){ rand() }
    $test_array_small = Array.new(10_000){ rand() }
  end

  # default Ruby sort
  def self.quick_sort()
    Benchmark.bm do |t|
      t.report("Large:") {$test_array_large.sort}
      t.report("Small:") {$test_array_small.sort}
    end
  end

  def self.bubble_sort()
    Benchmark.bm do |t|
      # t.report("Large:") {
      #   $test_array_large.each_index do |i|
      #     ($test_array_large.length - i - 1).times do |job|
      #       if $test_array_large[job] > $test_array_large[job + 1]
      #         $test_array_large[job], $test_array_large[job + 1] = $test_array_large[job + 1], $test_array_large[job]
      #       end
      #     end
      # end}
      t.report("Small:") {
        $test_array_small.each_index do |i|
          ($test_array_small.length - i - 1).times do |job|
            if $test_array_small[job] > $test_array_small[job + 1]
              $test_array_small[job], $test_array_small[job + 1] = $test_array_small[job + 1], $test_array_large[job]
            end
          end
      end}
    end
  end

  def self.insertion_sort()
    Benchmark.bm do |t|
      # t.report("Large:"){
      #   (1..$test_array_large.length - 1).each do |i|
      #     value = $test_array_large[i]
      #     j = i - 1
      #     while j >= 0 && $test_array_large[j] > value do
      #       $test_array_large[j + 1] = $test_array_large[j]
      #       j -= 1
      #     end
      #     $test_array_large[j + 1] = value
      #   end}
      t.report("Small:"){
        (1..$test_array_small.length - 1).each do |i|
          value = $test_array_small[i]
          j = i - 1
          while j >= 0 && $test_array_small[j] > value do
            $test_array_small[j + 1] = $test_array_small[j]
            j -= 1
          end
          $test_array_small[j + 1] = value
        end}
    end
  end

  def self.merge_sort()
    Benchmark.bm do |t|
      t.report("Large:"){merge_sort_controller($test_array_large)}
      t.report("Small:"){merge_sort_controller($test_array_small)}
    end
  end

  def self.merge_sort_controller(list)
      return list if list.size < 2
        left = list[0, list.length/2]
        right = list[list.length/2, list.length]
      merge(merge_sort_controller(left), merge_sort_controller(right))
  end

  def self.merge(left, right)
    sorted_list = []
    until left.empty? || right.empty?
      sorted_list << (left[0] <= right[0] ? left.shift : right.shift)
    end
    sorted_list.concat(left).concat(right)
  end


end
