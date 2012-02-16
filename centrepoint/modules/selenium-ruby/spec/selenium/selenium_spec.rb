require 'spec_helper'

describe "Centrepoint", :selenium => 1 do

  before(:all) do
    selenium_start "Centrepoint from Ruby"
  end

  it "should display home page" do
    @driver.open( "/" )
    @driver.title.should eq( "Centrepoint :: Project List" )
    @driver.is_text_present( "There are currently no projects." ).should be true
  end

  it "should add project" do
    @driver.open( "/" )
    @driver.click( "//a[span='Add a New Project']" )

    @driver.wait_for_page_to_load( "30000" )
    @driver.title.should eq( "Centrepoint :: Add Project" )
    @driver.type( "groupId", "org.codehaus.plexus" )
    @driver.type( "artifactId", "plexus-utils" )
    @driver.click( "//input[@value='Import']" )
    @driver.wait_for_page_to_load( "30000" )
    @driver.title.should eq( "Centrepoint :: Plexus Common Utilities" )
    @driver.is_text_present( "org.codehaus.plexus" ).should be true
  end

  it "should add project validation" do
    @driver.open( "/project/add-maven" )
    @driver.click( "//input[@value='Import']" )
    @driver.wait_for_page_to_load( "30000" )
    @driver.title.should eq( "Centrepoint :: Add Project" )
    @driver.is_text_present( "Field 'Group ID' is required." ).should be true
    @driver.is_text_present( "Field 'Artifact ID' is required." ).should be true
  end

  it "should view project" do
    @driver.open( "/" )
    @driver.click( "//a[span='Plexus Common Utilities']" )
    @driver.wait_for_page_to_load( "30000" )
    @driver.title.should eq( "Centrepoint :: Plexus Common Utilities" )
  end

  after(:all) do
    selenium_stop
  end
end
