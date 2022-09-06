# app.rb

require_relative 'book_controller'
require_relative 'people_controller'
require_relative 'rentals_controller'
require 'set'

class App
  def initialize
    @rentals_controller = RentalsController.new
    @book_controller = BookController.new
    @people_controller = PeopleController.new
  end

  def list_all_books
    @book_controller.list_all_books
  end

  def list_all_people
    @people_controller.list_all_people
  end

  def create_person
    @people_controller.create_person
  end

  def create_book
    @book_controller.create_book
  end

  def create_rental
    @rentals_controller.create_rental
  end

  def list_all_rentals
    @rentals_controller.list_all_rentals
  end
end
