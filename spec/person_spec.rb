# person_spec.rb

require_relative '../rental'

describe Person do
  before :each do
    @person = Person.new(19, 'Hamilton')
  end

  describe 'Add new person' do
    it 'Takes two parameters and returns a Person object' do
      expect(@person).to be_instance_of Person
    end

    it 'Should match name' do
      expect((@person.name)).to eq 'Hamilton'
    end

    it "Should detect when 'of_age'" do
      expect((@person.age)).to be > 18
    end
  end
end
