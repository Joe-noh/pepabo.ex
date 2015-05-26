defmodule Fibonacci do
  use Application

  @server Fibonacci.Server

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Fibonacci.Server, [[name: @server]])
    ]

    opts = [strategy: :one_for_one, name: Fibonacci.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def next do
    Fibonacci.Server.next(@server)
  end
end
