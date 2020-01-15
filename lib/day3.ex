defmodule Aoc2019.Day3 do
  @moduledoc false

  @spec part_one(file_name :: Path.t()) :: integer
  def part_one(file_name \\ "lib/day3/input.txt") do
    file_name
    |> File.read!()
    |> distance()
  end

  @spec part_two(file_name :: Path.t()) :: integer
  def part_two(file_name \\ "lib/day3/input.txt") do
    file_name
    |> File.read!()
    |> steps()
  end

  @doc """
  Calculates Manhattan distance from central port to closest intersection.
  """
  @spec distance(input :: String.t()) :: integer
  def distance(input) do
    input
    |> intersection_coords()
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  @doc """
  Calculates what is the fewest combined steps the wires must take to reach an intersection?
  """
  @spec steps(input :: String.t()) :: integer
  def steps(input) do
    panel =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&trace_wire/1)

    intersections =
      panel
      |> Enum.map(fn wire -> Map.keys(wire) |> MapSet.new() end)
      |> Enum.reduce(fn wire, panel -> MapSet.intersection(panel, wire) end)
      |> Enum.to_list()

    [wire1, wire2] = Enum.map(panel, fn wire -> Map.take(wire, intersections) end)

    {_coords, steps} =
      Map.merge(wire1, wire2, fn _k, v1, v2 -> v1 + v2 end)
      |> Enum.min_by(fn {_k, v} -> v end)

    steps
  end

  @spec intersection_coords(wires :: String.t()) :: MapSet.t()
  defp intersection_coords(wires) do
    wires
    |> String.split("\n", trim: true)
    |> Enum.map(fn wire -> trace_wire(wire) |> Map.keys() |> MapSet.new() end)
    |> Enum.reduce(fn wire, panel -> MapSet.intersection(panel, wire) end)
  end

  @spec trace_wire(wire :: String.t()) :: map
  defp trace_wire(wire) do
    {_position, _steps, wiring} =
      wire
      |> String.split(",", trim: true)
      |> Enum.reduce({{0, 0}, 1, %{}}, fn move, {position, steps, wiring} ->
        [_old_position | coords_list] =
          move
          |> parse_move()
          |> move_to_coords(position)

        position = List.last(coords_list)

        {steps, wiring} =
          Enum.reduce(coords_list, {steps, wiring}, fn coords, {step, acc} ->
            acc = Map.put(acc, coords, step)
            {step + 1, acc}
          end)

        {position, steps, wiring}
      end)

    wiring
  end

  @spec parse_move(raw_move :: String.t()) :: tuple
  defp parse_move(move) do
    {direction, steps} = String.split_at(move, 1)
    {direction, String.to_integer(steps)}
  end

  @spec move_to_coords(move :: tuple, current_position :: tuple) :: list(tuple)
  defp move_to_coords({"U", steps}, {x, y}), do: for(y <- y..(y + steps), do: {x, y})
  defp move_to_coords({"D", steps}, {x, y}), do: for(y <- y..(y - steps), do: {x, y})
  defp move_to_coords({"R", steps}, {x, y}), do: for(x <- x..(x + steps), do: {x, y})
  defp move_to_coords({"L", steps}, {x, y}), do: for(x <- x..(x - steps), do: {x, y})
end
