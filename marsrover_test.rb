require 'test/unit'
require 'marsrover'

class MarsRoverTest < Test::Unit::TestCase
  def test_starts_facing_north
    robby = Rover.new
    facing = robby.direction
    assert_equal("N", facing)
  end
  
  def test_receive_turn_right
    robby = Rover.new
    facing = robby.direction
    instruction = "R"
    robby.recieve(instruction)
    facing = robby.direction
    assert_equal("E", facing)    
  end
  
  def test_receive_turn_left_twice
    robby = Rover.new
    instruction = "L L"
    robby.recieve(instruction)
    facing = robby.direction
    assert_equal("S", facing)
  end

  def test_receive_turns_east_then_south
    robby = Rover.new
    instruction = "R M R M"
    robby.recieve(instruction)
    facing = robby.direction
    assert_equal("S", facing)
    assert_equal([1, 1], robby.location)
  end
  
  def test_recieve_hits_top_wall
    robby = Rover.new
    instruction = "M"
    assert_raise(BoundaryError) do
      robby.recieve(instruction)
    end
  end
  
  def test_recieve_hits_right_wall
    robby = Rover.new(5)
    instruction = "R M M M M M"
    assert_raise(BoundaryError) do
      robby.recieve(instruction)
    end
    assert_equal([4, 0], robby.location)
  end

  def test_recieve_hits_left_wall
    robby = Rover.new(5)
    instruction = "L M"
    assert_raise(BoundaryError) do
      robby.recieve(instruction)
    end
  end

  def test_recieve_hits_bottom_wall
    robby = Rover.new(5)
    instruction = "L L M M M M M"
    assert_raise(BoundaryError) do
      robby.recieve(instruction)
    end
  end
  
end