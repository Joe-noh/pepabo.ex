defmodule StackServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def push(pid, elem) do
    GenServer.cast(pid, {:push, elem})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  ### GenServer callbacks

  def handle_cast({:push, elem}, stack) do
    {:noreply, [elem | stack]}
  end

  def handle_call(:pop, _from, [head | rest]) do
    {:reply, head, rest}
  end
end
