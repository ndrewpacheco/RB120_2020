class Person

  attr_accessor :first_name, :last_name

  def initialize(first_name)

    @first_name = first_name
    @name = first_name
    @last_name = ''
  end

  def name
    @last_name.empty? ? @first_name : @first_name + " " + @last_name
  end

  def name=(n)
    @name = n
    new_name = n.split
    @first_name = new_name[0]
    @last_name = new_name[1] if new_name.size == 2

    @name = n
  end


end




bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
p bob.name