# frozen_string_literal: true

class Route
  include Validatable

  attr_reader :id, :stations, :name, :created_at

  def initialize(opts)
    @id = rand(36**8).to_s(36)
    @stations = [opts[:first], opts[:last]]
    @name = "#{opts[:first]}-#{opts[:last]}"
    @created_at = Time.now
    validate
    store_info if valid?
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

  def store_info
    info = {"id": "#{id}", "name": "#{name}", "created_at": "#{created_at}"}
    File.open('data/routes.txt', 'a+') { |file| file.puts(info.to_json) } 
  end

  def validate
    super(stations)
    super(name)
    raise AttributePresentError if stations.first == stations.last
    self.valid = true
  rescue AttributeSizeError, AttributePresentError => e
    self.valid = false
  end
end
