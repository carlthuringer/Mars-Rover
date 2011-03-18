class BoundaryError < StandardError
  
end

class Rover
  attr_reader :direction

  def initialize(dimension = 10)
    @direction = "N"
    @location = {:x => 0, :y => 0}
    @dimension = dimension
  end
  
  def location
    [@location[:x], @location[:y]]
  end
  
  def recieve(message)
    message.split.each do |instruction|
      case instruction
      when "R", "L"
        turn(instruction)
      when "M"
        move
      end
    end
  end

  Compass = {
    "R" => {
      "N" => "E",
      "E" => "S",
      "S" => "W",
      "W" => "N"
    },
    "L" => {
      "N" => "W",
      "E" => "N",
      "S" => "E",
      "W" => "S"
    }
  }

  def turn(instruction)
    @direction = Compass[instruction][@direction]
  end
  
  def move
    new_location = @location.dup

    case @direction
    when "N"
      new_location[:y] -= 1
    when "E"
      new_location[:x] += 1
    when "S"
      new_location[:y] += 1
    when "W"
      new_location[:x] -= 1
    end

    raise BoundaryError if new_location.any? { |_, i| i < 0 or i >= @dimension }

    @location = new_location
  end
  
end