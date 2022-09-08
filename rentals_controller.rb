# rentals_controller.rb

require_relative 'rental'

class RentalsController
  def initialize(people_controller, book_controller)
    @people_controller = people_controller
    @book_controller = book_controller
    rentals_file = File.open('./data/rentals.json')
    rentals_data = rentals_file.read
    rentals_file.close
    @rentals = rentals_data != '' ? parse_json(rentals_data) : []
  end

  def rental_to_hash(rental)
    return {
      date: rental.date,
      person_id: rental.person.id,
      book_id: rental.book.id
    }
  end

  def create_rental
    if @people_controller.empty?
      puts 'Please add a person before setting up a rental'
      return ''
    end

    if @book_controller.empty?
      puts 'Please add a book before setting up a rental'
      return ''
    end
    person_selection_idx = @people_controller.make_person_selection
    book_selection_idx = @book_controller.make_book_selection
    book = @book_controller.get_book_at(book_selection_idx)
    person = @people_controller.get_person_at(person_selection_idx)
    rental = Rental.new(book, person)
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

  def to_json
    rentals_hash = @rentals.map { |rental| rental_to_hash(rental) }
    JSON.pretty_generate(rentals_hash)
  end

  def parse_json(rentals_json)
    rentals_hash = JSON.parse(rentals_json)
    rentals_hash.map do |rental_hash|
      date, person_id, book_id = rental_hash.values_at('date', 'person_id', 'book_id')
      book = @book_controller.find_by_id(book_id)
      person = @people_controller.find_by_id(person_id)
      Rental.new(book, person, date)
    end
  end

  def save
    return if @rentals.empty?

    rentals_json = to_json
    rentals_file = File.open('./data/rentals.json', 'w')
    rentals_file.write(rentals_json)
    rentals_file.close
  end
end
