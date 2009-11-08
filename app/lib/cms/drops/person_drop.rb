class PersonDrop < Liquid::Drop
  
  def initialize(person)
    @person = person
  end

  def firstname
    @person.firstname
  end
  
  def lastname
    @person.lastname
  end
  
  def name
    [firstname, lastname] * ' '
  end
  
  def email
    @person.email
  end
end