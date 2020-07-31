# frozen_string_literal: true

require 'sinatra/base'
require 'json'

Dir['./modules/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
require_relative 'webapp'

WebApp.run!
