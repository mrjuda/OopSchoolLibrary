# rental.rb

require_relative 'person'
require_relative 'book'

class Rental
  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals.push(self) unless book.rentals.include?(self)
    person.rentals.push(self) unless person.rentals.include?(self)
  end

  attr_accessor :date, :person, :book
end
