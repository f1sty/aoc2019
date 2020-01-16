defmodule Aoc2019.Day4Test do
  use ExUnit.Case, async: true

  test "validate_part_one/1" do
    results =
      [111111, 223450, 123789]
      |> Enum.map(fn number ->
        Integer.digits(number) |> Aoc2019.Day4.validate_part_one()
      end)
    assert results == [true, false, false]
  end

  test "validate_part_two/1" do
    results =
      [112233, 123444, 111122]
      |> Enum.map(fn number ->
        Integer.digits(number) |> Aoc2019.Day4.validate_part_two()
      end)
    assert results == [true, false, true]
  end
end
