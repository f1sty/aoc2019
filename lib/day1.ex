defmodule Aoc2019.Day1 do
  @moduledoc false

  @spec fuel_per_mass(mass :: pos_integer) :: integer
  defp fuel_per_mass(mass), do: div(mass, 3) - 2

  @spec fuel_per_mass_fixed(mass :: pos_integer, fuel :: integer) :: integer
  defp fuel_per_mass_fixed(mass, fuel \\ 0) do
    case fuel_per_mass(mass) do
      required when required >=0 -> fuel_per_mass_fixed(required, fuel + required)
      _ -> fuel
    end
  end


  @doc """
  Calculates total fuel requirement.
  """
  @spec total_fuel(input_stream :: File.Stream.t()) :: integer
  def total_fuel(input_stream) do
    input_stream
    |> Stream.map(fn line ->
      {mass, _rest} = Integer.parse(line)
      fuel_per_mass(mass)
    end)
    |> Enum.sum()
  end

  @doc """
  Calculates total fuel required, counting fuel, needed for the fuel itself.
  """
  @spec total_fuel_fixed(input_stream :: File.Stream.t()) :: pos_integer
  def total_fuel_fixed(input_stream) do
    input_stream
    |> Stream.map(fn line ->
      {mass, _rest} = Integer.parse(line)
      fuel_per_mass_fixed(mass)
    end)
    |> Enum.sum()
  end

  @doc """
  Runs part 1 solution.
  """
  @spec part_one(file_name :: Path.t()) :: integer
  def part_one(file_name) do
    file_name
    |> File.stream!()
    |> total_fuel()
  end

  @doc """
  Runs part 2 solution.
  """
  @spec part_two(file_name :: Path.t()) :: pos_integer
  def part_two(file_name) do
    file_name
    |> File.stream!()
    |> total_fuel_fixed()
  end
end
