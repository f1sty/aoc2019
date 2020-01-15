defmodule Aoc2019.Day4Test do
  use ExUnit.Case, async: true

  test "validate/1" do
    numbers =
      [111111, 223450, 123789]
      |> Enum.map(fn number ->
        Integer.digits(number) |> Aoc2019.Day4.validate()
      end)
    assert numbers === [true, false, false]
  end
end
