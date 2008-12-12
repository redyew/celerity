require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Dl" do

  before :all do
    @browser = Browser.new
  end

  before :each do
    @browser.goto(TEST_HOST + "/definition_lists.html")
  end


  # Exists method
  describe "#exists?" do
    it "should return true if the element exists" do
      @browser.dl(:id, "experience-list").should exist
      @browser.dl(:class, "list").should exist
      @browser.dl(:xpath, "//dl[@id='experience-list']").should exist
      @browser.dl(:index, 1).should exist
    end

    it "should return false if the element does not exist" do
      @browser.dl(:id, "no_such_id").should_not exist
    end

    it "should raise TypeError when 'what' argument is invalid" do
      lambda { @browser.dl(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "should raise MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.dl(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "should return the class attribute if the element exists" do
      @browser.dl(:id , "experience-list").class_name.should == "list"
    end

    it "should return an empty string if the element exists but the attribute doesn't" do
      @browser.dl(:id , "noop").class_name.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dl(:id, "no_such_id").class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:title, "no_such_title").class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:index, 1337).class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:xpath, "//dl[@id='no_such_id']").class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "should return the id attribute if the element exists" do
      @browser.dl(:class, 'list').id.should == "experience-list"
    end

    it "should return an empty string if the element exists, but the attribute doesn't" do
      @browser.dl(:class, 'personalia').id.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda {@browser.dl(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda {@browser.dl(:title, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda {@browser.dl(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "should return the id attribute if the element exists" do
      @browser.dl(:class, 'list').title.should == "experience"
    end
  end

  describe "#text" do
    it "should return the text of the element" do
      @browser.dl(:id, "experience-list").text.should include("11 years")
    end

    it "should return an empty string if the element exists but contains no text" do
      @browser.dl(:id, 'noop').text.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dl(:id, "no_such_id").text }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:title, "no_such_title").text }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:index, 1337).text }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:xpath, "//dl[@id='no_such_id']").text }.should raise_error(UnknownObjectException)
    end
  end

  describe "#respond_to?" do
    it "should return true for all attribute methods" do
      @browser.dl(:index, 1).should respond_to(:id)
      @browser.dl(:index, 1).should respond_to(:class_name)
      @browser.dl(:index, 1).should respond_to(:style)
      @browser.dl(:index, 1).should respond_to(:text)
      @browser.dl(:index, 1).should respond_to(:title)
    end
  end

  # Manipulation methods
  describe "#click" do
    it "should fire events when clicked" do
      @browser.dl(:id, 'noop').text.should_not == 'noop'
      @browser.dl(:id, 'noop').click
      @browser.dl(:id, 'noop').text.should == 'noop'
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dl(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:title, "no_such_title").click }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:index, 1337).click }.should raise_error(UnknownObjectException)
      lambda { @browser.dl(:xpath, "//dl[@id='no_such_id']").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#html" do
    it "should return the HTML of the element" do
      html = @browser.dl(:id, 'experience-list').html
      html.should include('<dt class="current-industry">')
      html.should_not include('</body>')
    end
  end

  describe "#to_s" do
    it "should return a human readable representation of the element" do
      @browser.dl(:id, 'experience-list').to_s.should ==
%q{tag:          dl
  id:           experience-list
  class:        list
  title:        experience
  text:         Experience11 yearsEducationMasterCurrent industryArchitecturePrevious industry experienceArchitecture}
    end
  end

  after :all do
    @browser.close
  end

end
