defmodule StackAgent do
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def push(pid, elem) do
    Agent.update(pid, &[elem | &1])
  end

  def pop(pid) do
    Agent.get_and_update pid, fn stack ->
      case stack do
        [] -> {{:error, :empty}, []}
        [head | rest] -> {{:ok, head}, rest}
      end
    end
  end

  def to_list(pid) do
    {:ok, Agent.get(pid, & &1)}
  end

  def clear(pid) do
    Agent.update(pid, fn (_) -> [] end)
  end

  def length(pid) do
    {:ok, Agent.get(pid, &Enum.count/1)}
  end
end
