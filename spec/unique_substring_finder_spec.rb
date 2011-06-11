require File.expand_path('../../lib/unique_substring_finder', __FILE__)

describe UniqueSubstringFinder do
  
  describe "#initialize" do
    describe " +options+ argument" do
      before :each do
        @finder = UniqueSubstringFinder.new({
          :ignore_case => true,
          :ignore_non_word_chars => true,
        })
      end
      
      it "should set @ignore_case to true" do
        @finder.ignore_case.should be_true
      end
      
      it "should set @ignore_non_word_chars to true" do
        @finder.ignore_non_word_chars.should be_true
      end
    end
  end
  
  describe "#find_unique_by_size" do
    before :each do
      @finder = UniqueSubstringFinder.new
    end
    
    it "have a default size of 4" do
      @finder.dictionary = %w( zoo zoom broom room zed )
      
      @finder.find_unique_by_size.should == {
        "zoom" => "zoom",
        "broo" => "broom",
      }
    end
    
    it "should only find unique substrings" do
      @finder.dictionary = %w( zoo zoom broom room zed )
      
      @finder.find_unique_by_size(3).should == {
        "bro" => "broom",
        "zed" => "zed",
      }
    end
    
    describe "when @ignore_case is false" do
      it "should be case sensitive" do
        @finder.dictionary = %w( aaa AAA aAa )
        
        @finder.find_unique_by_size(3).should == {
          "aaa" => "aaa",
          "AAA" => "AAA",
          "aAa" => "aAa",
        }
      end
    end
    
    describe "when @ignore_case is true" do
      it "should not be case sensitive" do
        @finder.ignore_case = true
        @finder.dictionary = %w( Zoo zOOm Broom Room zeD )
        
        @finder.find_unique_by_size(3).should == {
          "bro" => "Broom",
          "zed" => "zeD",
        }
      end
    end
    
    describe "when @ignore_non_word_chars is false" do
      it "should use all chars in match" do
        @finder.dictionary = %w( can't ant )
        
        @finder.find_unique_by_size(3).should == {
          "can" => "can't",
          "an'" => "can't",
          "n't" => "can't",
          "ant" => "ant",
        }
      end
    end
    
    describe "when @ignore_non_word_chars is true" do
      it "should use only word chars in match" do
        @finder.ignore_non_word_chars = true
        @finder.dictionary = %w( can't ant )
        
        @finder.find_unique_by_size(3).should == {
          "can" => "can't",
        }
      end
    end
  end
  
  describe "file dictionary source" do
    it "should find words in files" do
      @finder = UniqueSubstringFinder.new
      @finder.dictionary = File.new("spec/data/test_words")
      
      @finder.find_unique_by_size(3).should == {
        "bro" => "broom",
        "zed" => "zed",
      }
    end
    
    it "should find words in files a second time" do
      @finder = UniqueSubstringFinder.new
      @finder.dictionary = File.new("spec/data/test_words")
      
      @finder.find_unique_by_size(3).should == {
        "bro" => "broom",
        "zed" => "zed",
      }
      
      @finder.find_unique_by_size(3).should == {
        "bro" => "broom",
        "zed" => "zed",
      }
    end
  end
  
  it "should pass dolan test" do
    @finder = UniqueSubstringFinder.new
    @finder.dictionary = %w( arrows carrots give me )
    
    @finder.find_unique_by_size(4).should == {
      "carr" => "carrots",
      "give" => "give",
      "rots" => "carrots",
      "rows" => "arrows",
      "rrot" => "carrots",
      "rrow" => "arrows",
    }
  end
end