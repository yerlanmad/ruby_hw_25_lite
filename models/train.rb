# frozen_string_literal: true

class Train
  include Validatable

  attr_reader :number, :type

  def initialize(number)
    @number = number
    validate
  end
  
  protected

  def validate
    super(number)
  rescue AttributeSizeError, AttributePresentError => e
    self.valid = false
  else
    self.valid = true
  end
end
