defmodule Fibonacci.Server do
  use GenServer

  @doc false
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [0, 1], opts)
  end

  @doc false
  def next(pid) do
    GenServer.call(pid, :next)
  end

  def handle_call(:next, _from, [13, _]) do
    raise RuntimeError, message: "oh it's 13!!"
  end

  def handle_call(:next, _from, [curr, next]) do
    {:reply, curr, [next, curr+next]}
  end
end
