defmodule StackServer do
  use GenServer
  alias __MODULE__, as: S

  defstruct stack: [], length: 0

  def start_link do
    GenServer.start_link(S, %S{})
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

  def handle_cast({:push, elem}, state = %S{stack: stack, length: length}) do
    {:noreply, %S{state | stack: [elem | stack], length: length+1}}
  end

  def handle_cast(:clear, _stack) do
    {:noreply, %S{}}
  end

  def handle_call(:pop, _from, state = %S{stack: []}) do
    {:reply, {:error, :empty}, state}
  end

  def handle_call(:pop, _from, state = %S{stack: [head | rest], length: length}) do
    {:reply, {:ok, head}, %S{state | stack: rest, length: length-1}}
  end

  def handle_call(:to_list, _from, state) do
    {:reply, {:ok, state.stack}, state}
  end
end
