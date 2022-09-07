# book_controller.rb
require 'json'
require_relative 'book'

class BookController
  def initialize
    books_file = File.open('./data/books.json')
    books_data = books_file.read
    books_file.close
    @books = books_data != '' ? parse_json(books_data) : []
  end

  def empty?
    @books.empty?
  end

  def get_book_at(index)
    @books[index]
  end

  def book_to_hash(book)
    return {
      title: book.title, 
      author: book.author
    }
  end

  def to_json
    books_hash = @books.map { |book| book_to_hash(book) }
    JSON.pretty_generate(books_hash)
  end

  def parse_json(books_json)
    books_hash = JSON.parse(books_json)
    books_hash.map do |book_hash| 
      title, author = book_hash.values_at('title', 'author')
      Book.new(title, author)
    end
  end

  def save
    if !@books.empty?
      books_json = to_json
      books_file = File.open('./data/books.json', 'w')
      books_file.write(books_json)
      books_file.close
    end
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts "New book: #{title} by #{author}"
    @books << book
  end

  def make_book_selection
    max = @books.length - 1
    answered = false
    selection = 'nil'
    until answered
      puts 'Please select the book by selection number (number on the left of the name)'
      @books.each_with_index do |book, idx|
        puts "Selection #{idx}- Title: #{book.title} Author: #{book.author}"
        selection = gets.chomp.to_i
        return selection if selection.between?(0, max)
      end
    end
  end

  def list_all_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: \"#{book.author}\"" }
  end
end
