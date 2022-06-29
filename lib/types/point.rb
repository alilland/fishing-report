# frozen_string_literal: true

class Point
  attr_reader :lat, :lon

  def initialize(lat, lon)
    @lat, @lon = lat, lon
  end

  # Converts an object of this instance into a database friendly value.
  # In this example, we store the values in the database as array.
  def mongoize
    [lat, lon]
  end

  class << self
    # Takes any possible object and converts it to how it would be
    # stored in the database.
    def mongoize(object)
      case object
      when Point then object.mongoize
      when Hash then Point.new(object[:lat], object[:lon]).mongoize
      else object
      end
    end

    # Get the object as it was stored in the database, and instantiate
    # this custom class from it.
    def demongoize(object)
      Point.new(object[0], object[1])
    end

    # Converts the object that was supplied to a criteria and converts it
    # into a query-friendly form.
    def evolve(object)
      case object
      when Point then object.mongoize
      else object
      end
    end
  end
end
