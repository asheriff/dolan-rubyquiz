require File.expand_path('../../lib/bin', __FILE__)

BINPATH = File.expand_path('../../bin/unique_substring_finder', __FILE__)
DICT = "spec/data/test_words"

class String
  def unindent
    self.strip.gsub( /^\s+/, '' )
  end
end

describe 'bin/unique_substring_finder executable command' do
  it "should print unique words" do
    output = `#{BINPATH} #{DICT} | sort`.strip
    output.should == %(
      broo broom
      zoom zoom
    ).unindent
  end
  
  it "should accept size option" do
    output = `#{BINPATH} #{DICT} -s2 | sort`.strip
    output.should == %{
      br broom
      ed zed
      ze zed
    }.unindent
  end
  
  it "should accept output field separator option" do
    output = `#{BINPATH} #{DICT} -F: | sort`.strip
    output.should == %(
      broo:broom
      zoom:zoom
    ).unindent
  end
  
  it "should accept ignore case flag" do
    pending "TODO..."
  end
  
  it "should accept ignore non word chars flag" do
    pending "TODO..."
  end
  
  it "should have correct answer to dolan example words" do
    output = `#{BINPATH} spec/data/dolan_words | sort`.strip
    output.should == %(
      carr carrots
      give give
      rots carrots
      rows arrows
      rrot carrots
      rrow arrows
    ).unindent
  end
end