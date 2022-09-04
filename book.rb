# book.rb

require 'rental'

class Book
  def initialize(title, author)
    @title = title
    @author = author
    @person = nil
    @rentals = []
  end

  attr_accessor :title, :author, :person, :rentals
end
