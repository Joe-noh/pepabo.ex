defmodule StackAgentTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = StackAgent.start_link

    {:ok, %{pid: pid}}
  end

  test "push and pop", c do
    StackAgent.push(c.pid, :item1)
    StackAgent.push(c.pid, :item2)

    assert StackAgent.pop(c.pid) == :item2
    assert StackAgent.pop(c.pid) == :item1
  end
end
