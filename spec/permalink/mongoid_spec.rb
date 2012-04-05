require "spec_helper"

describe Permalink::Orm::Mongoid do
  let(:model) { Article }
  
  context do
    before do
      model.field :permalink
      model.field :slug
    end
    
    it_should_behave_like "orm"
  end

  it "should override to_param method" do
    model.field :permalink
    model.permalink :title

    record = model.create(:title => "Some nice post")
    record.to_param.should == "some-nice-post"
  end
end
