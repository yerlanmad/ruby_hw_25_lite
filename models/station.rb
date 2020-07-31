# frozen_string_literal: true

class Station
  include Validatable

  attr_reader :name

  def initialize(name)
    @name = name
    validate
  end

  private

  def validate
    super(name)
  rescue AttributeSizeError, AttributePresentError => e
    self.valid = false
  else
    self.valid = true
  end
end
