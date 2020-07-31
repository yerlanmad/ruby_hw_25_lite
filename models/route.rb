# frozen_string_literal: true

class Route
  include Validatable

  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station}-#{last_station}"
    validate
  end

  def add_station(station)
    return if stations.include?(station)

    stations.insert(-2, station)
  end

  def delete_station(station)
    return if [0, -1].any? { |i| stations[i] == station }

    stations.delete(station)
  end

  private

  def validate
    super(stations)
    super(name)
    raise AttributePresentError if stations.first == stations.last
  rescue AttributeSizeError, AttributePresentError => e
    self.valid = false
  else
    self.valid = true
  end
end
