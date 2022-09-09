require_relative '../rental'

describe Book do
  before :each do
    @book = Book.new('Game of Thrones', 'George')
  end

  describe '#new' do
    it 'Takes two parameters and returns a Book object' do
      expect(@book).to be_instance_of Book
    end

    it 'Has the title Game of Thrones' do
      expect(@book.title).to eq 'Game of Thrones'
    end

    it 'Has the author George' do
      expect(@book.author).to eq 'George'
    end

    it 'Has rentals with method length' do
      expect(@book.rentals).to respond_to(:length)
    end

    it 'Has empty rentals array after initialization' do
      expect(@book.rentals.length).to be 0
      expect(@book.rentals.length).to eq 0
      expect(@book.rentals.length).to eql 0
    end

    it 'Create instance without parameters' do
      expect { Book.new }.to raise_error(ArgumentError)
    end

    it 'Can create new rentals' do
      person = Person.new(64, 'Alice')
      @book.add_rental(person)
      expect(@book.rentals.length).to eq 1
    end
  end
end