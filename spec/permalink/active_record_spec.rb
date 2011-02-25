require "spec_helper"

describe Permalink::Orm::ActiveRecord do
  let(:model) { Post }
  it_should_behave_like "orm"
end
