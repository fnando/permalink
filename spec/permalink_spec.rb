# encoding: utf-8
require 'spec_helper'

describe Permalink do
  before(:all) do
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

  context "ActiveRecord" do
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
      user = create_user(:permalink => "jdoe")
      user.reload
      user.permalink.should == "jdoe"
    end

    it "should create unique permalinks for number-ended titles" do
      post1 = create_post(:title => "Rails 3")
      post1.permalink.should == "rails-3"

      post2 = create_post(:title => "Rails 3")
      post2.permalink.should == "rails-3-2"
    end
  end

  context "Mongoid" do
    it "should create permalink" do
      refrigerant = create_refrigerant
      refrigerant.permalink.should == 'coke'
    end

    it "should create permalink for custom field" do
      cookie = create_cookie
      cookie.slug.should == 'vanilla'
    end

    it "should add permalink before_save" do
      refrigerant = Refrigerant.new
      refrigerant.permalink.should be_nil
      refrigerant.update_attribute(:name, 'Pepsi')
      refrigerant.reload
      refrigerant.permalink.should == 'pepsi'
    end

    it "should create unique permalinks" do
      article1 = create_article(:title => 'Ruby is a beautiful language')
      article1.permalink.should == "ruby-is-a-beautiful-language"

      article2 = create_article(:title => 'Ruby is a beautiful language')
      article2.permalink.should == "ruby-is-a-beautiful-language-2"

      article3 = create_article(:title => 'Ruby is a beautiful language')
      article3.permalink.should == "ruby-is-a-beautiful-language-3"
    end

    it "return to_param for unique permalink" do
      article1 = create_article(:title => 'Ruby')
      article1.to_param.should == "ruby"

      article2 = create_article(:title => 'Ruby')
      article2.to_param.should == "ruby-2"
    end

    it "should override to_param method" do
      refrigerant = create_refrigerant
      refrigerant.to_param.should == "#{refrigerant.id}-#{refrigerant.permalink}"
    end

    it "should override to_param with custom fields" do
      cookie = create_cookie
      cookie.to_param.should == "#{cookie.slug}-#{cookie.id}-permalink"
    end

    it "should ignore blank attributes from to_param" do
      person = create_person
      person.to_param.should == "john-doe-john-doe"
    end

    it "should set permalink if permalink is blank" do
      person = create_person(:permalink => " ")
      person.reload
      person.permalink.should == "john-doe"
    end

    it "should keep defined permalink" do
      person = create_person(:permalink => "jdoe")
      person.reload
      person.permalink.should == "jdoe"
    end

    it "should create unique permalinks for number-ended titles" do
      article1 = create_article(:title => "Rails 3")
      article1.permalink.should == "rails-3"

      article2 = create_article(:title => "Rails 3")
      article2.permalink.should == "rails-3-2"
    end

    it "should create an id similar to permalink" do
      cookie = create_cookie(:flavor => "Dark Chocolate")
      cookie.id.should == cookie.slug
    end

    it "should generate id as permalink" do
      article = create_article(:title => "Ruby on Rails 3")
      article.id.should == "ruby-on-rails-3"
    end
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

  def create_refrigerant(options={})
    Refrigerant.create({:name => 'Coke'}.merge(options))
  end

  def create_cookie(options={})
    Cookie.create({:flavor => 'Vanilla'}.merge(options))
  end

  def create_article(options={})
    Article.create({:title => 'Some nice article!'}.merge(options))
  end

  def create_person(options={})
    Person.create({:name => 'John Doe'}.merge(options))
  end
end
