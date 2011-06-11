class UniqueSubstringFinder
  
  DEFAULT_SIZE = 4
  
  DEFAULT_OPTIONS = {
    :ignore_case => false,
    :ignore_non_word_chars => false
  }
  
  attr_accessor :dictionary
  attr_accessor :ignore_case, :ignore_non_word_chars
  
  def initialize( options={} )
    options = DEFAULT_OPTIONS.merge( options )
    
    options.each{ |k,v| self.send( "#{k}=", v ) }
    
    @dictionary = []
  end
  
  # Finds unique substrings of length +size+. Returns a Hash with the unique
  # substrings as keys and the unique wording containing the substring as the
  # value.
  #
  def find_unique_by_size(size=DEFAULT_SIZE)
    matches = {}
    
    @dictionary.rewind if @dictionary.respond_to?(:rewind)
    
    @dictionary.each do |w|
      target_word = w.chomp
      word = w.chomp
      word.gsub!( /\W/, '' ) if ignore_non_word_chars
      
      next if word.length < size
      
      index = 0
      while (substring = word[index,size]) && substring.length == size
        substring.downcase! if ignore_case
          
        if matches.key? substring
          # There's already a word. We'll set it to nil and filter out nils later.
          matches[substring] = nil
        else
          matches[substring] = target_word
        end
        index += 1
      end 
      
    end
    
    matches.delete_if{ |k,v| v.nil? }
  end
  
end



