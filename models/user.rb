# frozen_string_literal: true

module FR
  ##
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in collection: :users
    has_many :interests, class_name: 'FR::Interest'

    field :email, type: String, default: nil
    field :username, type: String, default: nil
    field :active, type: Boolean, default: false
  end
end
