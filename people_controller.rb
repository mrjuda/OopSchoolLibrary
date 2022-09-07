# people_controller.rb
require 'json'

require_relative 'student'
require_relative 'teacher'

class PeopleController
  def initialize
    people_file = File.open('./data/people.json')
    people_data = people_file.read
    people_file.close
    @people = people_data != '' ? parse_json(people_data) : []
  end

  def list_all_people
    @people.each do |person|
      puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a?(Student)
      puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a?(Teacher)
    end
  end

  def student_to_hash(student)
    {
      id: student.id,
      name: student.name,
      age: student.age,
      parent_permission: student.parent_permission,
      type: 'student'
    }
  end
  def teacher_to_hash(teacher) 
    {
      id: teacher.id, 
      name: teacher.name,
      age: teacher.age,
      specialization: teacher.specialization,
      type: 'teacher'
    }
  end

  def to_json
    people_hash = @people.map { |person| person.is_a?(Student) ?  student_to_hash(person) : teacher_to_hash(person) }
    JSON.pretty_generate(people_hash)
  end

  def parse_json(people_json)
    people_hash = JSON.parse(people_json)
    people_hash.map do |person_hash| 
      if(person_hash['type'] == 'student')
        id, name, age, parent_permission = person_hash.values_at('id', 'name', 'age', 'parent_permission')
        Student.new(age, '', name, parent_permission: parent_permission, id: id)
      else
        id, name, age, specialization = person_hash.values_at('id', 'name', 'age', 'specialization')
        Teacher.new(age, specialization, name, id: id)
      end
    end
  end

  def save
    if !@people.empty?
      people_json = to_json
      people_file = File.open('./data/people.json', 'w')
      people_file.write(people_json)
      people_file.close
    end
  end

  def create_person
    class_name = confirm_class
    specialty = confirm_specialty(class_name)
    age = confirm_age

    puts "Please enter this Person's name"
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
        puts 'Please enter number 1 or 2'
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

  def empty?
    @people.empty?
  end

  def get_person_at(index)
    @people[index]
  end

  def find_by_id(person_id)
    @people.find { |person| person.id == person_id }
  end
end
