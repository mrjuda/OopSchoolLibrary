# Person.rb

require_relative 'nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @books = []
  end

  attr_accessor :age, :name, :parent_permission, :rentals
  attr_reader :id

  def can_use_services
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  def add_rental(rental, book)
    book.rentals.push(rental) unless book.rentals.include?(rental)
    # book.person = self
    @rentals.push(rental)
    @books.push(book)
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
