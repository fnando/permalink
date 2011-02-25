shared_examples_for "orm" do
  before do
    model.delete_all
    model.permalink :title
  end

  it "should respond to options" do
    model.should respond_to(:permalink_options)
  end

  it "should use default options" do
    model.permalink :title
    record = model.create(:title => "Some nice post")
    record.permalink.should == "some-nice-post"
  end

  it "should use custom attribute" do
    model.permalink :title, :to => :slug
    record = model.create(:title => "Some nice post")
    record.slug.should == "some-nice-post"
  end

  it "should set permalink before_save" do
    record = model.new(:title => "Some nice post")
    record.permalink.should be_nil
    record.valid?
    record.permalink.should == "some-nice-post"
  end

  it "should create unique permalinks" do
    model.permalink :title, :unique => true

    record = model.create(:title => "Some nice post")
    record.permalink.should == "some-nice-post"

    record = model.create(:title => "Some nice post")
    record.permalink.should == "some-nice-post-2"

    record = model.create(:title => "Some nice post")
    record.permalink.should == "some-nice-post-3"
  end

  it "should return to_param for unique permalink" do
    model.permalink :title, :to_param => :permalink, :unique => true

    record = model.create(:title => "Ruby")
    record.to_param.should == "ruby"

    record = model.create(:title => "Ruby")
    record.to_param.should == "ruby-2"
  end

  it "should override to_param with custom fields" do
    model.permalink :title, :to => :slug, :to_param => [:slug, :id, "page"]

    record = model.create(:title => "Some nice post")
    record.to_param.should == "some-nice-post-#{record.id}-page"
  end

  it "should ignore blank attributes from to_param" do
    model.permalink :title, :to_param => [:id, "    ", nil, "\t", :permalink]

    record = model.create(:title => "Some nice post")
    record.reload
    record.to_param.should == "#{record.id}-some-nice-post"
  end

  it "should set permalink if permalink is blank" do
    record = model.create(:title => "Some nice post", :permalink => "  ")
    record.permalink.should == "some-nice-post"
  end

  it "should keep defined permalink" do
    record = model.create(:title => "Some nice post", :permalink => "awesome-post")
    record.permalink.should == "awesome-post"
  end

  it "should create unique permalinks for number-ended titles" do
    model.permalink :title, :unique => true

    record = model.create(:title => "Rails 3")
    record.permalink.should == "rails-3"

    record = model.create(:title => "Rails 3")
    record.permalink.should == "rails-3-2"
  end
end
