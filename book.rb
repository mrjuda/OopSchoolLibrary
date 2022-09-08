# book.rb

require_relative 'rental'

class Book
  def initialize(title, author, id: Random.rand(1..100))
    @id = id
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  attr_accessor :title, :author, :person, :rentals
  attr_reader :id
end
