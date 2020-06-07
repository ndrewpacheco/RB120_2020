
# 1 A D C y
# 2 A C y
# 3 b c y
# 4 b y
# 5 d. y
# 6 a c d y
# 7 b y
# 8 a  y
# 9 a b c
# 10 b c

# clas

class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    "baaaaaaa!"
  end
end

class Cow
  def speak
    super + "mooooooo!"
  end
end

Sheep.new.speak # => "Sheep says baa!"
Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
Cow.new.speak # => "Cow says mooooooo!"