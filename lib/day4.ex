defmodule Aoc2019.Day4 do
  @moduledoc false

  @spec part_one(filename :: Path.t()) :: integer
  def part_one(filename \\ "lib/day4/input.txt") do
    filename
    |> File.read!()
    |> String.replace("-", "..")
    |> Code.eval_string
    |> elem(0)
    |> Stream.map(&Integer.digits/1)
    |> Stream.filter(&validate/1)
    |> Enum.count()
  end

  @doc """
  Validates, if list of digits have same adjacent digits and non decreasing digits.
  Returns `true` or `false`.
  """
  @spec validate(digits :: list) :: boolean
  def validate(digits) do
    {_helper_digit, result} =
      Enum.reduce_while(digits, {0, false}, fn digit, {previous, has_same_adjacent} ->
        cond do
          digit > previous -> {:cont, {digit, has_same_adjacent}}
          digit == previous -> {:cont, {digit, true}}
          true -> {:halt, {0, false}}
        end
      end)
    result
  end
end
