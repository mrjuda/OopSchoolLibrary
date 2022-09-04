# student.rb

require_relative './classroom'
require './person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    # classroom.students.push(self) unless classroom.students.include?(self)
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
