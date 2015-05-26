defmodule StackAgentTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = StackAgent.start_link

    {:ok, %{pid: pid}}
  end

  test "push and pop", c do
    StackAgent.push(c.pid, :item1)
    StackAgent.push(c.pid, :item2)

    assert StackAgent.pop(c.pid) == {:ok, :item2}
    assert StackAgent.pop(c.pid) == {:ok, :item1}
  end

  test "get stack as a list", c do
    assert StackAgent.to_list(c.pid) == {:ok, []}

    StackAgent.push(c.pid, :item1)
    StackAgent.push(c.pid, :item2)

    assert StackAgent.to_list(c.pid) == {:ok, [:item2, :item1]}
  end

  test "clear the stack", c do
    StackAgent.push(c.pid, :item)
    StackAgent.push(c.pid, :item)

    StackAgent.clear(c.pid)

    assert StackAgent.to_list(c.pid) == {:ok, []}
  end

  test "get stack length", c do
    assert StackAgent.length(c.pid) == {:ok, 0}

    StackAgent.push(c.pid, :item)

    assert StackAgent.length(c.pid) == {:ok, 1}

    StackAgent.push(c.pid, :item)
    StackAgent.push(c.pid, :item)

    assert StackAgent.length(c.pid) == {:ok, 3}

    StackAgent.clear(c.pid)

    assert StackAgent.length(c.pid) == {:ok, 0}
  end

  test "pop returns {:error, :empty} when stack is empty", c do
    assert StackAgent.pop(c.pid) == {:error, :empty}
  end
end
