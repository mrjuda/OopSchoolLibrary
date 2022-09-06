# rentals_controller.rb

require_relative 'rental'

class RentalsController
  def initialize
    @rentals = []
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

  def find_id
    answered = false
    selection = nil
    max = @rentals.length - 1
    puts "There are #{@rentals.length} current rentals of books on record"
    until answered
      puts 'Please Select a person using the selection number for the person (number to the left of the name)'
      @rentals.map(&:person).to_set.each_with_index do |person, idx|
        puts "Selection #{idx} - #{person.name}"
      end
      selection = gets.chomp.to_i
      return @rentals[selection].person.id if selection.between?(0, max)

      next
    end
  end
end
