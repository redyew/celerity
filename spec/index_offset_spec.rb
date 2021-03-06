require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Celerity.index_offset" do

  before :all do
    @browser = Celerity::Browser.new(BROWSER_OPTIONS)
    @browser.goto(HTML_DIR + "/non_control_elements.html")
    
    Celerity.index_offset = 0
  end
  
  it "returns the correct divs" do
    divs = @browser.divs.to_a
    
    divs.each_with_index do |div, idx|
      @browser.div(:index, idx).id.should == div.id
    end
  end

  after :all do
    @browser.close
    Celerity.index_offset = 1
  end

end

