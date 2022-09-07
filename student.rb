# student.rb

require_relative './classroom'
require './person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true, id: Random.rand(1..100))
    super(age, name, parent_permission: parent_permission, id: id)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def add_rental(rental, book)
    book.rentals.push(rental) unless book.rentals.include?(rental)
    @books.push(book)
    @rentals.push(rental)
  end

  attr_reader :classroom
end
