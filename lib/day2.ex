defmodule Aoc2019.Day2 do
  @moduledoc false

  @type opcode_list :: [integer]

  @doc """
  Executes part 1.
  """
  @spec part_one(program :: opcode_list()) :: integer
  def part_one(program) do
    state =
      program
      |> patch()
      |> populate_state()
    execute(state, 0) |> hd()
  end

  @spec execute(program :: opcode_list()) :: opcode_list()
  def execute(program) do
    state = populate_state(program)
    execute(state, 0)
  end

  @spec populate_state(program :: opcode_list) :: :ets.tid()
  defp populate_state(program) do
    state = :ets.new(:state, [:ordered_set])
    program
    |> Stream.with_index()
    |> Enum.each(fn {value, key} -> :ets.insert(state, {key, value}) end)

    state
  end

  @spec execute(state :: :ets.tid(), ip :: non_neg_integer) :: opcode_list() | {:error, reason :: term}
  defp execute(state, ip) do
    case :ets.lookup_element(state, ip, 2) do
      1 ->
        {arg1, arg2, out, ip} = read_args_and_inc_ip(state, ip)
        :ets.insert(state, {out, arg1 + arg2})
        execute(state, ip)

      2 ->
        {arg1, arg2, out, ip} = read_args_and_inc_ip(state, ip)
        :ets.insert(state, {out, arg1 * arg2})
        execute(state, ip)

      99 -> :ets.select(state, [{{:"$1", :"$2"}, [], [:"$2"]}])

      _ -> {:error, :bad_opcode}
    end
  end

  @spec read_args_and_inc_ip(state :: :ets.tid(), ip :: non_neg_integer) :: tuple
  defp read_args_and_inc_ip(state, ip) do
    in1 = :ets.lookup_element(state, ip + 1, 2)
    in2 = :ets.lookup_element(state, ip + 2, 2)
    out = :ets.lookup_element(state, ip + 3, 2)
    ip = ip + 4
    arg1 = :ets.lookup_element(state, in1, 2)
    arg2 = :ets.lookup_element(state, in2, 2)
    {arg1, arg2, out, ip}
  end

  @spec patch(state :: list) :: list
  defp patch(program) do
    program
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
  end
end
