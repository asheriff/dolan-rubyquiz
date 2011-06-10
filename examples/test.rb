require File.expand_path('../../lib/unique_substring_finder', __FILE__)

dict = File.expand_path('../../spec/data/words_short', __FILE__)

finder = UniqueSubstringFinder.new
finder.load( dict )

finder.find_unique_by_size(4).each do |m|
  puts "#{m[0]} #{m[1]}"
end

puts
puts '#'*80
puts

finder.find_unique_by_size(6).each do |m|
  puts "#{m[0]} #{m[1]}"
end
