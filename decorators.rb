# decorators.rb

require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip.capitalize
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip.slice(0, 10)
  end
end
