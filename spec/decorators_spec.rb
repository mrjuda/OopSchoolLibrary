require_relative '../decorators'

describe CapitalizeDecorator do
  before(:each) do
    person = Person.new(25, 'jack')
    @person_capitalized = CapitalizeDecorator.new(person)
  end

  it 'should show the correct name capitalized' do    
    name_capitalized = @person_capitalized.correct_name

    expect(name_capitalized).to eq 'Jack'
  end
end 