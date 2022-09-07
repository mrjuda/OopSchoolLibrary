# teacher.rb

require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'unknown', parent_permission: true, id: Random.rand(1..100))
    super(age, name, parent_permission: parent_permission, id: id)
    @specialization = specialization
  end

  def can_use_services
    true
  end
end
