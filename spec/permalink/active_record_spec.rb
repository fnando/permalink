require "spec_helper"

describe Permalink::ActiveRecord do
  let(:model) { Post }

  before do
    model.delete_all
    model.permalink :title
  end

  it "responds to options" do
    expect(model).to respond_to(:permalink_options)
  end

  it "uses default options" do
    model.permalink :title
    record = model.create(:title => "Some nice post")
    expect(record.permalink).to eq("some-nice-post")
  end

  it "uses custom attribute" do
    model.permalink :title, :to => :slug
    record = model.create(:title => "Some nice post")
    expect(record.slug).to eq("some-nice-post")
  end

  it "sets permalink before_save" do
    record = model.new(:title => "Some nice post")
    expect(record.permalink).to be_nil
    record.valid?
    expect(record.permalink).to eq("some-nice-post")
  end

  it "creates unique permalinks" do
    model.permalink :title, :unique => true

    record = model.create(:title => "Some nice post")
    expect(record.permalink).to eq("some-nice-post")

    record = model.create(:title => "Some nice post")
    expect(record.permalink).to eq("some-nice-post-2")

    record = model.create(:title => "Some nice post")
    expect(record.permalink).to eq("some-nice-post-3")
  end

  it "creates unique permalinks based on scope" do
    model.permalink :title, :unique => true, :scope => :user_id

    user = User.create!
    another_user = User.create!

    # Create posts for user
    record = model.create(:title => "Some nice post", :user => user)
    expect(record.permalink).to eq("some-nice-post")

    record = model.create(:title => "Some nice post", :user => user)
    expect(record.permalink).to eq("some-nice-post-2")

    # Create posts for another user
    record = model.create(:title => "Some nice post", :user => another_user)
    expect(record.permalink).to eq("some-nice-post")

    record = model.create(:title => "Some nice post", :user => another_user)
    expect(record.permalink).to eq("some-nice-post-2")
  end

  it "returns param for unique permalink" do
    model.permalink :title, :to_param => :permalink, :unique => true

    record = model.create(:title => "Ruby")
    expect(record.to_param).to eq("ruby")

    record = model.create(:title => "Ruby")
    expect(record.to_param).to eq("ruby-2")
  end

  it "overrides to_param with custom fields" do
    model.permalink :title, :to => :slug, :to_param => [:slug, :id, "page"]

    record = model.create(:title => "Some nice post")
    expect(record.to_param).to eq("some-nice-post-#{record.id}-page")
  end

  it "ignores blank attributes from to_param" do
    model.permalink :title, :to_param => [:id, "    ", nil, "\t", :permalink]

    record = model.create(:title => "Some nice post")
    expect(record.to_param).to eq("#{record.id}-some-nice-post")
  end

  it "sets permalink if permalink is blank" do
    record = model.create(:title => "Some nice post", :permalink => "  ")
    expect(record.permalink).to eq("some-nice-post")
  end

  it "keeps defined permalink" do
    record = model.create(:title => "Some nice post", :permalink => "awesome-post")
    expect(record.permalink).to eq("awesome-post")
  end

  it "creates unique permalinks for number-ended titles" do
    model.permalink :title, :unique => true

    record = model.create(:title => "Rails 3")
    expect(record.permalink).to eq("rails-3")

    record = model.create(:title => "Rails 3")
    expect(record.permalink).to eq("rails-3-2")
  end

  it "forces permalink" do
    model.permalink :title, :force => true

    record = model.create(:title => "Some nice post")
    record.update_attributes :title => "Awesome post"

    expect(record.permalink).to eq("awesome-post")
  end

  it "forces permalink and keep unique" do
    model.permalink :title, :force => true, :unique => true

    record = model.create(:title => "Some nice post")

    record.update_attributes :title => "Awesome post"
    expect(record.permalink).to eq("awesome-post")

    record = model.create(:title => "Awesome post")
    expect(record.permalink).to eq("awesome-post-2")
  end

  it "keeps same permalink when another field changes" do
    model.permalink :title, :force => true, :unique => true

    record = model.create(:title => "Some nice post")
    record.update_attributes :description => "some description"

    expect(record.permalink).to eq("some-nice-post")
  end

  it "overrides to_param method" do
    model.permalink :title

    record = model.create(:title => "Some nice post")
    expect(record.to_param).to eql("#{record.id}-some-nice-post")
  end
end
