# decorators.rb

require_relative 'person'

class BaseDecorator
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip.upcase
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip.slice(0, 10)
  end
end
