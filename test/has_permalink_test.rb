# encoding: utf-8
require "test_helper"

class HasPermalinkTest < ActiveSupport::TestCase
  SAMPLES = {
    'This IS a Tripped out title!!.!1  (well/ not really)' => 'this-is-a-tripped-out-title-1-well-not-really',
    '////// meph1sto r0x ! \\\\\\' => 'meph1sto-r0x',
    'āčēģīķļņū' => 'acegiklnu',
    '中文測試 chinese text' => 'chinese-text',
    'some-)()()-ExtRa!/// .data==?>    to \/\/test' => 'some-extra-data-to-test',
    'http://simplesideias.com.br/tags/' => 'http-simplesideias-com-br-tags',
    "Don't Repeat Yourself (DRY)" => 'don-t-repeat-yourself-dry',
    "Text\nwith\nline\n\n\tbreaks" => 'text-with-line-breaks'
  }
  
  test "should create permalink using to_permalink" do
    SAMPLES.each do |from, to|
      assert_equal to, from.to_permalink
    end
  end
  
  test "should create permalink" do
    beer = create_beer
    assert_equal 'duff', beer.permalink
  end
  
  test "should create permalink for custom field" do
    donut = create_donut
    assert_equal 'cream', donut.slug
  end
  
  test "should add permalink before_save" do
    beer = Beer.new
    assert_nil beer.permalink
    beer.update_attribute(:name, 'Duff Premium')
    beer.reload
    assert_equal 'duff-premium', beer.permalink
  end
  
  test "should create unique permalinks" do
    post1 = create_post(:title => 'Ruby is a beautiful language')
    assert_equal "ruby-is-a-beautiful-language", post1.permalink
    
    post2 = create_post(:title => 'Ruby is a beautiful language')
    assert_equal "ruby-is-a-beautiful-language-2", post2.permalink
    
    post3 = create_post(:title => 'Ruby is a beautiful language')
    assert_equal "ruby-is-a-beautiful-language-3", post3.permalink
  end
  
  test "return to_param for unique permalink" do
    post1 = create_post(:title => 'Ruby')
    assert_equal post1.to_param, 'ruby'
    
    post2 = create_post(:title => 'Ruby')
    assert_equal post2.to_param, 'ruby-2'
  end
  
  test "should override to_param method" do
    beer = create_beer
    assert_equal "#{beer.id}-#{beer.permalink}", beer.to_param
  end
  
  test "should override to_param with custom fields" do
    donut = create_donut
    assert_equal "#{donut.slug}-#{donut.id}-permalink", donut.to_param
  end
  
  test "should ignore blank attributes from to_param" do
    user = create_user
    assert_equal "1-john-doe", user.to_param
  end
  
  test "should set permalink if permalink is blank" do
    user = create_user(:permalink => " ")
    user.reload
    assert_equal "john-doe", user.permalink
  end
  
  test "should keep defined permalink" do
    user = create_beer(:permalink => "jdoe")
    user.reload
    assert_equal "jdoe", user.permalink
  end
  
  test "should create unique permalinks for number-ended titles" do
    post1 = create_post(:title => "Rails 3")
    assert_equal "rails-3", post1.permalink
    
    post2 = create_post(:title => "Rails 3")
    assert_equal "rails-3-2", post2.permalink
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
