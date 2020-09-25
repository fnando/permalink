# frozen_string_literal: true

ActiveRecord::Schema.define(version: 0) do
  create_table :posts do |t|
    t.string :title, :permalink, :description, :slug
    t.belongs_to :user
  end

  create_table :users do |t|
  end
end
