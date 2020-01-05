defmodule Aoc2019.Day1Test do
  use ExUnit.Case, async: true
  doctest Aoc2019.Day1

  setup do
    {:ok, input} = StringIO.open("""
      12
      14
      1969
      100756
      """)

    %{input: IO.stream(input, :line)}
  end

  test "total_fuel", %{input: input} do
    assert Aoc2019.Day1.total_fuel(input) == 34241
  end

  test "total_fuel_fixed", %{input: input} do
    assert Aoc2019.Day1.total_fuel_fixed(input) == 51316
  end

  test "part_one" do
    file_path = "lib/day1/input.txt"
    assert Aoc2019.Day1.part_one(file_path) == 3443395
  end

  test "part_two" do
    file_path = "lib/day1/input.txt"
    assert Aoc2019.Day1.part_two(file_path) == 5162216
  end
end
