class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

cat = Cat.new("black")

p cat.make_one_year_older
p cat.age