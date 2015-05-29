defmodule Fibonacci do
  @moduledoc """
  フィボナッチなモジュールだよ

  * みんなで
  * 一緒に
  * フィボナッチ！
  """

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

  @doc """
  次のフィボナッチ数を返す

      iex> Fibonacci.next
      0
      iex> Fibonacci.next
      1
  """
  @spec next :: integer | no_return
  def next do
    Fibonacci.Server.next(@server)
  end
end
