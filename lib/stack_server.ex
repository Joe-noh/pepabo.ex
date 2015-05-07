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

  def clear(pid) do
    GenServer.cast(pid, :clear)
  end

  def to_list(pid) do
    GenServer.call(pid, :to_list)
  end

  ### GenServer callbacks

  def handle_cast({:push, elem}, stack) do
    {:noreply, [elem | stack]}
  end

  def handle_cast(:clear, _stack) do
    {:noreply, []}
  end

  def handle_call(:pop, _from, []) do
    {:reply, {:error, :empty}, []}
  end

  def handle_call(:pop, _from, [head | rest]) do
    {:reply, {:ok, head}, rest}
  end

  def handle_call(:to_list, _from, stack) do
    {:reply, {:ok, stack}, stack}
  end
end
