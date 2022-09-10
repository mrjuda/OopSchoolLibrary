# student_spec.rb

require_relative '../rental'
require_relative '../student'

# def initialize(age, classroom, name = 'Unknown', parent_permission: true, id: Random.rand(1..100))

describe Student do
  before :each do
    @student = Student.new(21, 'Math', 'Verstappen')
  end

  describe 'Check new student' do
    it 'Takes two parameters and returns a Student object' do
      expect(@student).to be_instance_of Student
    end

    it 'Should match name' do
      expect((@student.name)).to eq 'Verstappen'
    end

    it 'Should match classroom' do
      expect((@student.classroom)).to eq 'Math'
    end

    it "Should detect when 'of_age'" do
      expect((@student.age)).to be > 18
    end
  end
end
