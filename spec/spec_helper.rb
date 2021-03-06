require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require 'rspec'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end