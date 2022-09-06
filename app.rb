# app.rb

require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'
require_relative 'auxx'
require_relative 'rental'
require_relative 'book_controller'
require_relative 'people_controller'
require 'set'

class App
  include AppAux
  attr_accessor :rentals

  def initialize
    @rentals = []
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
    if @people.empty?
      puts 'Please add a person before setting up a rental'
      return ''
    end
    if @books.empty?
      puts 'Please add a book before setting up a rental'
      return ''
    end
    person_selection_idx = make_person_selection
    book_selection_idx = make_book_selection
    book = @books[book_selection_idx]
    person = @people[person_selection_idx]
    puts 'Please enter a date in format YYYY-MM-DD'
    date = gets.chomp
    rental = Rental.new(date, book, person)
    @rentals << rental
  end

  def list_all_rentals
    puts 'No rentals so far' if @rentals.empty?
    unless @rentals.empty? # rubocop:disable Style/GuardClause
      search_id = find_id
      filtered = @rentals.select { |rental| rental.person.id == search_id }
      filtered.each do |rental|
        puts "Rental Details - Date: #{rental.date} Book: #{rental.book.title}
      \sby #{rental.book.author} Rented by: #{rental.person.name}"
      end
    end
  end
end
