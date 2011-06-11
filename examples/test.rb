require File.expand_path('../../lib/unique_substring_finder', __FILE__)

dictionary_path = File.expand_path('../../spec/data/words', __FILE__)

finder = UniqueSubstringFinder.new
finder.dictionary = File.new(dictionary_path)

finder.find_unique_by_size(4).sort.each do |w|
  puts "#{w[0]} #{w[1]}"
end
