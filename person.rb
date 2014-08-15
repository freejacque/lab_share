require 'pry'

class Person

attr_accessor :memories

  def initialize
    @alive = true
    @age = 0
    @memories = nil
    @brain = {memories: memories, love_ones: nil, interests: nil}
  end

  def alive?
    @alive
  end


  def age
    @age
  end

  def age!
    @age += 1
  end

  def name=(name)
    @name = name
  end

  def name
    @name
  end

  def brain
    @brain
  end

  def memories
    if @age >= 3
    @memories = []
    end
  end
end #class
# binding.pry
