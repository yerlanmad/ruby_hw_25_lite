# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super
    @type = 'Cargo'
  end
end
