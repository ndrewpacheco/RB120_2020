





class Animal
  def speak
    'bark!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end


end

class Cat < Animal



end

class Dog < Animal

def swim
    'swimming!'
  end

   def fetch
    'fetching!'
  end

end

#What is the method lookup path and how is it important?

The method look up path is the way inwhich we can see which class Ruby looks through first when look to see how to implement a certain method


