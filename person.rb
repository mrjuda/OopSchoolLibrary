# Person.rb

class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_reader :id, :parent_permission
  attr_accessor :name, :age

  def can_use_services?
    return true if @age >= 18 || @parent_permission

    false
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
