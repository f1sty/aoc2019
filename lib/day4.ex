defmodule Aoc2019.Day4 do
  @moduledoc false

  @spec part_one(filename :: Path.t()) :: integer
  def part_one(filename \\ "lib/day4/input.txt") do
    filename
    |> parse_input()
    |> Stream.filter(&validate_part_one/1)
    |> Enum.count()
  end

  @spec part_two(filename :: Path.t()) :: integer
  def part_two(filename \\ "lib/day4/input.txt") do
    filename
    |> parse_input()
    |> Stream.filter(&validate_part_one/1)
    |> Stream.filter(&validate_part_two/1)
    |> Enum.count()
  end

  @doc """
  Validates, if list of digits have same adjacent digits and non decreasing digits.
  Returns `true` or `false`.
  """
  @spec validate_part_one(digits :: list) :: boolean
  def validate_part_one(digits) do
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

  @doc """
  Validates, if list of digits have at least one or more groups of only two same
  adjacent digits. Returns `true` or `false`.
  """
  @spec validate_part_two(digits :: list) :: boolean
  def validate_part_two(digits) do
    digits
    |> split_on_same_digits_groups()
    |> Enum.any?(fn same_digits -> tuple_size(same_digits) == 2 end)
  end

  @spec split_on_same_digits_groups(digits :: list) :: list(tuple)
  def split_on_same_digits_groups([digit | digits]) do
    split_on_same_digits_groups(digits, {{digit}, []})
  end

  defp split_on_same_digits_groups([], {last_processed, rest}), do: [last_processed | rest]

  defp split_on_same_digits_groups([digit | digits], {current_same_group, acc})
       when elem(current_same_group, 0) == digit do
    split_on_same_digits_groups(digits, {Tuple.append(current_same_group, digit), acc})
  end

  defp split_on_same_digits_groups([digit | digits], {current_same_group, acc}) do
    split_on_same_digits_groups(digits, {{digit}, [current_same_group | acc]})
  end

  @spec parse_input(filename :: Path.t()) :: Enumerable.t()
  defp parse_input(filename) do
    filename
    |> File.read!()
    |> String.replace("-", "..")
    |> Code.eval_string()
    |> elem(0)
    |> Stream.map(&Integer.digits/1)
  end
end
