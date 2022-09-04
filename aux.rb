# aux.rb

require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'

module AppHelper
  def confirm_class
    class_answered = false
    class_message = 'Would you like to create a teacher [1] or a student [2]? Please enter 1 or 2'

    until class_answered
      puts class_message
      class_input = gets.chomp.to_i
      check = class_input.between?(1, 2)
      if check
        return 'Student' if class_input == 2

        return 'Teacher' if class_input == 1

        class_answered = true
      else
        puts 'Please enter only the number 1 or 2'
        next
      end
    end
  end

  def confirm_specialty(class_name)
    if class_name == 'Teacher'
      puts "What is this teacher's specialty?"
      gets.chomp
    else
      'Student'
    end
  end

  def confirm_age
    age_answered = false
    age_message = 'Please enter an age between 1-120'

    until age_answered
      puts age_message
      age_input = gets.chomp.to_i
      check = age_input.between?(1, 120)
      return age_input if check

      age_message = 'Please enter a valid number between 1-120'
    end
  end

  def confirm_permission(class_name)
    if class_name == 'Student'
      permission_answered = false
      permission_message = 'Does this student have parent permissions [Y/N]?'

      until permission_answered
        puts permission_message
        permission_input = gets.chomp
        check = %w[Y y N n].include? permission_input
        if check
          permission_answered = true
        else
          puts 'Please enter only Y or N'
          next
        end
      end
    else
      return true if %w[Y y].include? permission_input

      return false if %w[N n].include? permission_input

      true
    end
  end

  def make_person_selection
    max = @people.length - 1
    answered = false
    selection = 'nil'
    until answered
      puts 'Please select the person by selection number (number on the left of the name)'
      @people.each_with_index do |person, idx|
        puts "Selection #{idx}- Name: #{person.name} ID: #{person.id}"
      end
      selection = gets.chomp.to_i
      return selection if selection.between?(0, max)
    end
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
