# encoding: utf-8
require 'spec_helper'

describe Permalink do
  before(:each) do
    SAMPLES = { 'This IS a Tripped out title!!.!1  (well/ not really)' => 'this-is-a-tripped-out-title-1-well-not-really',
                '////// meph1sto r0x ! \\\\\\' => 'meph1sto-r0x',
                'āčēģīķļņū' => 'acegiklnu',
                '中文測試 chinese text' => 'chinese-text',
                'some-)()()-ExtRa!/// .data==?>    to \/\/test' => 'some-extra-data-to-test',
                'http://simplesideias.com.br/tags/' => 'http-simplesideias-com-br-tags',
                "Don't Repeat Yourself (DRY)" => 'don-t-repeat-yourself-dry',
                "Text\nwith\nline\n\n\tbreaks" => 'text-with-line-breaks' }
  end

  it "should create permalink using to_permalink" do
    SAMPLES.each do |from, to|
      to.should == from.to_permalink
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
    beer = Beer.new
    beer.permalink.should be_nil
    beer.update_attribute(:name, 'Duff Premium')
    beer.reload
    beer.permalink.should == 'duff-premium'
  end

  it "should create unique permalinks" do
    post1 = create_post(:title => 'Ruby is a beautiful language')
    post1.permalink.should == "ruby-is-a-beautiful-language"

    post2 = create_post(:title => 'Ruby is a beautiful language')
    post2.permalink.should == "ruby-is-a-beautiful-language-2"

    post3 = create_post(:title => 'Ruby is a beautiful language')
    post3.permalink.should == "ruby-is-a-beautiful-language-3"
  end

  it "return to_param for unique permalink" do
    post1 = create_post(:title => 'Ruby')
    post1.to_param.should == "ruby"

    post2 = create_post(:title => 'Ruby')
    post2.to_param.should == "ruby-2"
  end

  it "should override to_param method" do
    beer = create_beer
    beer.to_param.should == "#{beer.id}-#{beer.permalink}"
  end

  it "should override to_param with custom fields" do
    donut = create_donut
    donut.to_param.should == "#{donut.slug}-#{donut.id}-permalink"
  end

  it "should ignore blank attributes from to_param" do
    user = create_user
    user.to_param.should == "1-john-doe"
  end

  it "should set permalink if permalink is blank" do
    user = create_user(:permalink => " ")
    user.reload
    user.permalink.should == "john-doe"
  end

  it "should keep defined permalink" do
    user = create_beer(:permalink => "jdoe")
    user.reload
    user.permalink.should == "jdoe"
  end

  it "should create unique permalinks for number-ended titles" do
    post1 = create_post(:title => "Rails 3")
    post1.permalink.should == "rails-3"

    post2 = create_post(:title => "Rails 3")
    post2.permalink.should == "rails-3-2"
  end

  private
  def create_beer(options={})
    Beer.create({:name => 'Duff'}.merge(options))
  end

  def create_donut(options={})
    Donut.create({:flavor => 'Cream'}.merge(options))
  end

  def create_user(options={})
    User.create({:name => 'John Doe'}.merge(options))
  end

  def create_post(options={})
    Post.create({:title => 'Some nice post!'}.merge(options))
  end
end
