class AttributeSizeError < StandardError
  ERROR = "Attribute's size is not valid".freeze

  def message
    ERROR
  end
end

class AttributePresentError < StandardError
  ERROR = 'Attribute is not present'.freeze

  def message
    ERROR
  end
end
