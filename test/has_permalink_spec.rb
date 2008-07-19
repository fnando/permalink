require "spec_helper"

# unset models used for testing purposes
Object.unset_class('Donut', 'Beer')

class Beer < ActiveRecord::Base
  has_permalink :name
end

class Donut < ActiveRecord::Base
  has_permalink :flavor => :slug, :to_param => [:slug, :id, 'permalink']
end

describe "has_permalink" do
  fixtures :beers
  
  SAMPLES = {
    'This IS a Tripped out title!!.!1  (well/ not really)' => 'this-is-a-tripped-out-title-1-well-not-really',
    '////// meph1sto r0x ! \\\\\\' => 'meph1sto-r0x',
    'āčēģīķļņū' => 'acegiklnu',
    '中文測試 chinese text' => 'chinese-text',
    'some-)()()-ExtRa!/// .data==?>    to \/\/test' => 'some-extra-data-to-test',
    'http://simplesideias.com.br/tags/' => 'http-simplesideias-com-br-tags',
    "Don't Repeat Yourself (DRY)" => 'don-t-repeat-yourself-dry'
  }
  
  it "should create permalink using to_permalink" do
    SAMPLES.each do |from, to|
      from.to_permalink.should == to
    end
  end
  
  it "should create permalink" do
    beer = create_beer
    beer.permalink.should == 'duff'
  end
  
  it "should create permalink for custom field" do
    donut = create_donut
    donut.slug.should == 'cream'
  end
  
  it "should add permalink before_save" do
    beer = beers(:duff)
    beer.permalink.should be_nil
    beer.update_attribute(:name, 'Duff Premium')
    beer.permalink.should == 'duff-premium'
  end
  
  it "should override to_param method" do
    beer = create_beer
    beer.to_param.should == "#{beer.id}-#{beer.permalink}"
  end
  
  it "should override to_param with custom fields" do
    donut = create_donut
    donut.to_param.should == "#{donut.slug}-#{donut.id}-permalink"
  end
  
  private
    def create_beer(options={})
      Beer.create({:name => 'Duff'}.merge(options))
    end
    
    def create_donut(options={})
      Donut.create({:flavor => 'Cream'}.merge(options))
    end
end