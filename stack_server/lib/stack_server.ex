defmodule StackServer do
  use GenServer
  alias __MODULE__, as: S

  defstruct stack: [], length: 0, max_length: 0

  def start_link(opts \\ []) do
    GenServer.start_link(S, opts)
  end

  def push(pid, elem) do
    GenServer.call(pid, {:push, elem})
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

  def init(opts) do
    max_length = Keyword.get(opts, :max_length, 1000)

    {:ok, %S{max_length: max_length}}
  end

  def handle_cast(:clear, stack) do
    {:noreply, %S{stack | stack: [], length: 0}}
  end

  def handle_call({:push, _elem}, _from, state = %S{length: length, max_length: max})
  when length >= max do
    {:reply, {:error, :overflow}, state}
  end

  def handle_call({:push, elem}, _from, state = %S{stack: stack, length: length}) do
    {:reply, :ok, %S{state | stack: [elem | stack], length: length+1}}
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
