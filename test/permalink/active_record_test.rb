# frozen_string_literal: true

require "test_helper"

class ActiveRecordTest < Minitest::Test
  let(:model) { Post }

  setup do
    model.delete_all
    model.permalink :title
  end

  test "responds to options" do
    assert model.respond_to?(:permalink_options)
  end

  test "uses default options" do
    model.permalink :title
    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post", record.permalink
  end

  test "uses custom attribute" do
    model.permalink :title, to: :slug
    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post", record.slug
  end

  test "sets permalink before_save" do
    record = model.new(title: "Some nice post")
    assert_nil record.permalink
    record.valid?
    assert_equal "some-nice-post", record.permalink
  end

  test "creates unique permalinks" do
    model.permalink :title, unique: true

    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post", record.permalink

    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post-2", record.permalink

    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post-3", record.permalink
  end

  test "creates unique permalinks with custom separator" do
    model.permalink :title, unique: true, separator: "_"

    record = model.create(title: "Some nice post")
    assert_equal "some_nice_post", record.permalink

    record = model.create(title: "Some nice post")
    assert_equal "some_nice_post_2", record.permalink
  end

  test "creates unique permalinks based on scope" do
    model.permalink :title, unique: true, scope: :user_id

    user = User.create!
    another_user = User.create!

    # Create posts for user
    record = model.create(title: "Some nice post", user: user)
    assert_equal "some-nice-post", record.permalink

    record = model.create(title: "Some nice post", user: user)
    assert_equal "some-nice-post-2", record.permalink

    # Create posts for another user
    record = model.create(title: "Some nice post", user: another_user)
    assert_equal "some-nice-post", record.permalink

    record = model.create(title: "Some nice post", user: another_user)
    assert_equal "some-nice-post-2", record.permalink
  end

  test "returns param for unique permalink" do
    model.permalink :title, to_param: :permalink, unique: true

    record = model.create(title: "Ruby")
    assert_equal "ruby", record.to_param

    record = model.create(title: "Ruby")
    assert_equal "ruby-2", record.to_param
  end

  test "overrides to_param with custom fields" do
    model.permalink :title, to: :slug, to_param: [:slug, :id, "page"]

    record = model.create(title: "Some nice post")
    assert_equal "some-nice-post-#{record.id}-page", record.to_param
  end

  test "ignores blank attributes from to_param" do
    model.permalink :title, to_param: [:id, "    ", nil, "\t", :permalink]

    record = model.create(title: "Some nice post")
    assert_equal "#{record.id}-some-nice-post", record.to_param
  end

  test "sets permalink if permalink is blank" do
    record = model.create(title: "Some nice post", permalink: "  ")
    assert_equal "some-nice-post", record.permalink
  end

  test "keeps defined permalink" do
    record = model.create(title: "Some nice post", permalink: "awesome-post")
    assert_equal "awesome-post", record.permalink
  end

  test "creates unique permalinks for number-ended titles" do
    model.permalink :title, unique: true

    record = model.create(title: "Rails 3")
    assert_equal "rails-3", record.permalink

    record = model.create(title: "Rails 3")
    assert_equal "rails-3-2", record.permalink
  end

  test "forces permalink" do
    model.permalink :title, force: true

    record = model.create(title: "Some nice post")
    record.update title: "Awesome post"

    assert_equal "awesome-post", record.permalink
  end

  test "forces permalink and keep unique" do
    model.permalink :title, force: true, unique: true

    record = model.create(title: "Some nice post")

    record.update title: "Awesome post"
    assert_equal "awesome-post", record.permalink

    record = model.create(title: "Awesome post")
    assert_equal "awesome-post-2", record.permalink
  end

  test "keeps same permalink when another field changes" do
    model.permalink :title, force: true, unique: true

    record = model.create(title: "Some nice post")
    record.update description: "some description"

    assert_equal "some-nice-post", record.permalink
  end

  test "overrides to_param method" do
    model.permalink :title

    record = model.create(title: "Some nice post")
    assert_equal "#{record.id}-some-nice-post", record.to_param
  end

  test "uses custom separator" do
    model.permalink :title, separator: "_"
    record = model.create(title: "Some nice post")

    assert_equal "#{record.id}_some_nice_post", record.to_param
  end

  test "uses custom normalization" do
    model.permalink :title,
                    normalizations: [->(input, _options) { input.to_s.reverse }]
    record = model.create(title: "Some nice post")

    assert_equal "Some nice post".reverse, record.permalink
  end
end
