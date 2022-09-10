# teacher_spec.rb

require_relative '../rental'
require_relative '../teacher'

describe Teacher do
  before :each do
    @teacher = Teacher.new(21, 'Cornering speed', 'Vettel')
  end

  describe 'Check new teacher' do
    it 'Takes two parameters and returns a Teacher object' do
      expect(@teacher).to be_instance_of Teacher
    end

    it 'Should match name' do
      expect((@teacher.name)).to eq 'Vettel'
    end

    it 'Should match classroom' do
      expect((@teacher.specialization)).to eq 'Cornering speed'
    end

    it "Should detect when 'of_age'" do
      expect((@teacher.age)).to be > 18
    end
  end
end
