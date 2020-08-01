# frozen_string_literal: true

class Train
  include Validatable

  attr_reader :id, :number, :type, :created_at

  def initialize(opts)
    @id = rand(36**8).to_s(36)
    @number = opts[:number]
    @created_at = Time.now
    validate
    store_info if valid?
  end
  
  protected

  def store_info
    info = {"id": "#{id}", "number": "#{number}", "type": "#{type}", "created_at": "#{created_at}"}
    File.open('data/trains.txt', 'a+') { |file| file.puts(info.to_json) } 
  end

  def validate
    super(number)
    self.valid = true
  rescue AttributeSizeError, AttributePresentError => e
    self.valid = false
  end
end
