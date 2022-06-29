# frozen_string_literal: true

module FR
  ##
  class Interest
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in collection: :interests
    belongs_to :user, class_name: 'FR::User', optional: true
    has_and_belongs_to_many :locations, class_name: 'FR::Location'

    field :name, type: String
    field :geofence, type: Array

    def include?(lat, lon)
      target = Geokit::LatLng.new(lat, lon)
      points = []
      geofence.each { |pt| points << Geokit::LatLng.new(pt[0], pt[1]) }
      polygon = Geokit::Polygon.new(points)
      polygon.contains?(target)
    end
  end
end
