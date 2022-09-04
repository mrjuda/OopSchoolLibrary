#!/usr/bin/env ruby
# app.rb

require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'
require_relative 'aux'
require_relative 'rental'
require 'set'

class App
  include AppHelper
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: \"#{book.author}\"" }
  end

  def list_all_people
    @people.each do |person|
      puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a?(Student)
      puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a?(Teacher)
    end
  end

  def create_person
    class_name = confirm_class
    specialty = confirm_specialty(class_name)
    age = confirm_age

    puts "please enter this Person's name"
    name = gets.chomp
    permission = confirm_permission(class_name)

    student = Student.new(age, '', name, parent_permission: permission)
    teacher = Teacher.new(age, specialty, name)
    if class_name == 'Teacher'
      puts "Created Teacher Name: #{name} Age: #{age} Specialty: #{specialty}"
      @people << teacher
    else
      puts "Created Student Name: #{name} Age: #{age} ID: #{student.id}"
      @people << student
    end
  end

  def create_book
    puts 'title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts "Book made. #{title} by #{author}"
    @books << book
  end

  def create_rental
    if @people.empty?
      puts 'We need a person to rent to! Please add a person before setting up a rental'
      return ''
    end
    if @books.empty?
      puts 'We need a book to rent out! Please add a book before setting up a rental'
      return ''
    end
    person_selection_idx = make_person_selection
    book_selection_idx = make_book_selection
    book = @books[book_selection_idx]
    person = @people[person_selection_idx]
    puts 'please enter a date in format YYYY-MM-DD'
    date = gets.chomp
    rental = Rental.new(date, book, person)
    @rentals << rental
  end

  def list_all_rentals
    puts 'No rentals currently' if @rentals.empty?
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
