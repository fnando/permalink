require "spec_helper"

describe Permalink::Orm::MongoMapper do
  let(:model) { Page }
  it_should_behave_like "orm"

  it "should override to_param method" do
    model.permalink :title

    record = model.create(:title => "Some nice post")
    record.to_param.should == "some-nice-post"
  end
end
