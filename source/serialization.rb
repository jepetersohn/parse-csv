require 'csv'

class Person
  def initialize(hash)
    @id = hash['id']
    @first_name = hash['first_name']
    @last_name = hash['last_name']
    @email = hash['email']
    @phone = hash['phone']
    @created_at = hash['created_at']
  end
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = nil
  end

  def people
    return @people if @people
    @people = []
    CSV.foreach(@file, :headers => true) do |row_hash|
      @people << Person.new(row_hash)
    end
  end

  def add_person(person)
    @people << person
  end
end


#-----DRIVERS-----

parser = PersonParser.new('people.csv')
parser.people
p parser.people.size == 200

molly_info = {
  "id" => 201,
  "first_name" => "Molly",
  "last_name" => "Harris",
  "email" => "molly.harris@email.com",
  "phone" => "123-456-7890",
  "created_at" => "2013-12-02T07:45:30-08:00"
}
parser.add_person(Person.new(molly_info))
p parser.people.size == 201