defmodule StackServerTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = StackServer.start_link(max_length: 5)

    {:ok, %{pid: pid}}
  end

  test "push an item", c do
    StackServer.push(c.pid, :item)

    assert StackServer.pop(c.pid) == {:ok, :item}
  end

  test "get stack as a list", c do
    assert StackServer.to_list(c.pid) == {:ok, []}

    StackServer.push(c.pid, :item1)
    StackServer.push(c.pid, :item2)

    assert StackServer.to_list(c.pid) == {:ok, [:item2, :item1]}
  end

  test "clear the stack", c do
    StackServer.push(c.pid, :item)
    StackServer.push(c.pid, :item)

    StackServer.clear(c.pid)

    assert StackServer.to_list(c.pid) == {:ok, []}
  end

  test "get stack length", c do
    assert StackServer.length(c.pid) == {:ok, 0}

    StackServer.push(c.pid, :item)

    assert StackServer.length(c.pid) == {:ok, 1}

    StackServer.push(c.pid, :item)
    StackServer.push(c.pid, :item)

    assert StackServer.length(c.pid) == {:ok, 3}

    StackServer.clear(c.pid)

    assert StackServer.length(c.pid) == {:ok, 0}
  end

  test "pop returns {:error, :empty} when stack is empty", c do
    assert StackServer.pop(c.pid) == {:error, :empty}
  end

  test "push returns {:error, :overflow} when stack is full", c do
    Enum.each 1..5, fn _ ->
      assert StackServer.push(c.pid, :item) == :ok
    end

    assert StackServer.push(c.pid, :item) == {:error, :overflow}
  end
end
