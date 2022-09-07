#!/usr/bin/env ruby

require_relative 'app'

class Main
  def menu_list
    puts ''
    puts 'Please choose an option by entering a number'
    puts ''
    puts '1 - List all Books'
    puts '2 - List all People'
    puts '3 - Create a Person'
    puts '4 - Create a Book'
    puts '5 - Create a new Rental'
    puts '6 - List all Rentals for a given person id'
    puts '7 - exit'
    puts ''
  end

  def main # rubocop:disable Metrics/CyclomaticComplexity
    app = App.new
    user_finished = false
    until user_finished
      menu_list
      selection = gets.chomp.to_i
      case selection
      when 1 then app.list_all_books
      when 2 then app.list_all_people
      when 3 then app.create_person
      when 4 then app.create_book
      when 5 then app.create_rental
      when 6 then app.list_all_rentals
      when 7
        app.save_books
        app.save_people
        puts 'School Library appreciates your visit!'
        user_finished = true
      else
        puts 'Please choose a number between 1 and 7'
      end
    end
  end
end

main = Main.new
main.main
