require File.expand_path('../unique_substring_finder', __FILE__)
require 'optparse'

class UniqueSubstringFinder
  module Bin
    def self.run(args)
      options, output_options = *parse_opts(args)
      
      find( ARGV[0], options, output_options )
    end
    
    def self.parse_opts(args)
      options = {
        :size => DEFAULT_SIZE,
      }
      
      output_options = {
        :field_separator => " ",
      }
      
      opts = OptionParser.new do |parser|
        parser.banner = <<END_BANNER
USAGE
  unique_substring_finder [OPTIONS] DICTIONARY

DESCRIPTION
  Prints out the words with unique substrings in the DICTIONARY file.  Output 
  contains 2 columns, the first the substring and the second the word containing
  the substring.

  Output is unsorted.

OPTIONS
END_BANNER
        
        parser.on("-s", "--size SIZE", Integer, "Size of unique subsrings") do |size|
          options[:size] = size.to_i
        end
        
        parser.on("-i", "--ignore-case", "Case insensitive") do |i|
          options[:ignore_case] = i
        end
        
        parser.on("-W", "--ignore-non-word-chars", "Ignore non-word chars") do |w|
          options[:ignore_non_word_chars] = w
        end
        
        parser.on("-F", "--field-separator SEP", "Output separator between substing and word") do |s|
          output_options[:field_separator] = s
        end
        
      end
      
      opts.parse!
      
      if( ARGV.length == 0 )
        puts opts.help
        exit
      end
      
      [options, output_options]
    end
  
    def self.find(dictionary, options={}, output_options={})
      size = options.delete(:size)
      
      finder = UniqueSubstringFinder.new(options)
      finder.dictionary = File.new(dictionary)
      
      finder.find_unique_by_size(size).each do |k,v|
        puts "%s%s%s" % [k, output_options[:field_separator], v]
      end
    end
  
  end
end