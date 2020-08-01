# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(opts)
    @type = 'Passenger'
    super(opts)
  end
end
