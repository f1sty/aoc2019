defmodule Aoc2019.Day3Test do
  use ExUnit.Case, async: true

  alias Aoc2019.Day3
  doctest Day3

  test "distance/1" do
    assert Day3.distance("""
      R75,D30,R83,U83,L12,D49,R71,U7,L72
      U62,R66,U55,R34,D71,R55,D58,R83
      """) == 159
    assert Day3.distance("""
      R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
      U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
      """) == 135
  end

  test "steps/1" do
    assert Day3.steps("""
      R75,D30,R83,U83,L12,D49,R71,U7,L72
      U62,R66,U55,R34,D71,R55,D58,R83
      """) == 610
    assert Day3.steps("""
      R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
      U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
      """) == 410
  end
end
