require "spec_helper"

describe Permalink::Orm::ActiveRecord do
  let(:model) { Post }
  it_behaves_like "orm"

  it "overrides to_param method" do
    model.permalink :title

    record = model.create(:title => "Some nice post")
    expect(record.to_param).to eql("#{record.id}-some-nice-post")
  end
end
