# book_controller.rb

class BookController
  attr_accessor :books

  def initialize
    @books = []
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
