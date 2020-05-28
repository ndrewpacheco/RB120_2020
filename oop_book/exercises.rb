# How do we create an object in Ruby? Give an example of the creation of an object.

# module Sup

# end

# class Objt
#   include Sup
# end


# new_objt = Objt.new

# What is a module? What is its purpose?
# How do we use them with our classes?
# Create a module for the class you created in exercise 1 and include it properly.

# A module is a collection of behaviors that can be mixed in with various classes.

###########################################

# Create a class called MyCar.
# When you initialize a new instance or object of the class,
# allow the user to define some instance variables that tell us the year, color, and model
#of the car.
# Create an instance variable that is set to 0 during instantiation of the object to
# track the current speed of the car as well.
# Create instance methods that allow the car to speed up, brake, and shut the car off.
module Bridgable
  def bridge
    puts "I can fit on a bridge"
  end
end

class Vehicle
  @@vehicles_made = 0
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @@vehicles_made += 1
    @current_speed = 0
    @year = year
    @color = color
    @model = model
  end

  def self.gas_mileage
    # puts "gas mileage"
  end

  def self.amount_of_vehicles
    puts "We have made #{@@vehicles_made} vehicles"
  end
  def spray_paint(new_color)
    self.color = new_color
  end
  def speed_up(num)
    @speed += num
    puts "You sped up by #{num}. You are now going #{@current_speed}"
  end

  def brake
    @speed -= num
    puts "You slowed down by #{num}. You are now going #{@current_speed}"
  end

  def shut_off
    @current_speed = 0
    puts "Vehicle is now off."
  end

  def age

    puts "The vehicle is #{calc_age(year)} years old"
  end

  private

  def calc_age(year)
    now = Time.now

    now.year - year

  end


end

class MyCar < Vehicle

  VEHICLE_TYPE = "Car"

  def to_s
    "This is a #{@model} car"
  end
end

class MyTruck < Vehicle

  VEHICLE_TYPE = "Car"
end

my_car = MyCar.new(123, "Blue", "Ford")
puts my_car
my_car.age
puts MyCar.ancestors
puts " "
puts MyTruck.ancestors