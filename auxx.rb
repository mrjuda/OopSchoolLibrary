# aux.rb

require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'

module AppAux
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
