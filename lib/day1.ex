defmodule Aoc2019.Day1 do
  @moduledoc false

  @spec required_fuel(mass :: pos_integer) :: integer
  defp required_fuel(mass), do: div(mass, 3) - 2

  @doc """
  Calculates total fuel requirement.
  """
  @spec total_fuel_requirement(input_stream :: String.t()) :: integer
  def total_fuel_requirement(input_stream) do
    input_stream
    |> Stream.map(fn line ->
      {mass, _rest} = Integer.parse(line)
      required_fuel(mass)
    end)
    |> Enum.sum()
  end

  @doc """
  Runs part 1 solution.
  """
  @spec part_one(file_name :: Path.t()) :: integer
  def part_one(file_name \\ "day1/input.txt") do
    file_name
    |> File.stream!()
    |> total_fuel_requirement()
  end
end
