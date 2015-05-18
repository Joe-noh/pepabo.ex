defmodule StackAgent do
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def push(pid, elem) do
    Agent.update(pid, &[elem | &1])
  end

  def pop(pid) do
    Agent.get_and_update pid, fn [head | rest] ->
      {head, rest}
    end
  end
end
