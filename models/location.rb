# frozen_string_literal: true

module FR
  ##
  class Location
    include Mongoid::Document
    include Mongoid::Timestamps
    include ES

    store_in collection: :locations
    has_and_belongs_to_many :users, class_name: 'FR::User'

    field :state, type: String
    field :date, type: DateTime
    field :county, type: String
    field :name, type: String
    field :specie, type: String
    field :coordinates, type: Point
    field :unit_id, type: String
  end
end
