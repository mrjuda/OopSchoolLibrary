require 'date'
require_relative '../rental'

describe Rental do
  before(:each) do
    book = Book.new('AwesomeBook', 'Mr.awesome')
    person = Person.new(25)
    @rental = Rental.new(book, person)
  end

  it 'should show the correct date of the rental' do
    today_date = DateTime.now.strftime('%m/%d/%Y')
    
    rental_date = @rental.date.strftime('%m/%d/%Y')

    expect(rental_date).to eq today_date
  end

  it 'should add a rental to the book object' do
    book_rentals_length = @rental.book.rentals.length
    expect(book_rentals_length).to eq 1
  end

  it 'should add a rental to the person object' do
    person_rentals_length = @rental.person.rentals.length
    expect(person_rentals_length).to eq 1
  end
end 