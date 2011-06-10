class UniqueSubstringFinder
  
  DEFAULT_OPTIONS = {
    :ignore_case => true,
    :ignore_non_ascii => true
  }
  
  attr_accessor :ignore_case, :ignore_non_ascii
  attr_reader :dictionary
  
  def initialize( options={} )
    options = DEFAULT_OPTIONS.merge( options )
    
    options.each{ |k,v| self.send( "#{k}=", v ) }
    
    @dictionary = []
  end
  
  def load(filepath)
    @dictionary = File.read( filepath )
  end
  
  # Finds unique substrings of length +size+. Returns a 2d array with substrings
  # on left and unique words on right.
  #
  def find_unique_by_size(size)
    matches = Hash.new{ |hash, key| hash[key] = [] }
    
    @dictionary.each do |w|
      word = w.chomp
      
      next if word.length < size
      
      index = 0
      while (substring = word[index,size]) && substring.length == size
        matches[substring] << word
        index += 1
      end 
      
    end
    
    matches.select{ |k,v| v.length == 1 }.to_a.sort_by{ |m| m[0] }
  end
  
end



