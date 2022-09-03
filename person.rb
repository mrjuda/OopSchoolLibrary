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

  # def parent_permission
  #   @parent_permission
  # end

  def can_use_services?
    if @age >= 18 || @parent_permission == true
      true
    else
      false
    end
  end

  private

  def is_of_age?
    if @age >= 18
      true
    else
      false
    end
  end
end
