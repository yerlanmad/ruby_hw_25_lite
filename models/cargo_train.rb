# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(opts)
    @type = 'Cargo'
    super(opts)
  end
end
