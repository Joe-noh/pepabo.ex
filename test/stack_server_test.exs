defmodule StackServerTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = StackServer.start_link

    {:ok, %{pid: pid}}
  end

  test "push an item", c do
    StackServer.push(c.pid, :item)

    assert StackServer.pop(c.pid) == :item
  end
end
