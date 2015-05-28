defmodule FibonacciTest do
  use ExUnit.Case

  test "return fibonacci and crash on 13" do
    assert Fibonacci.next == 0
    assert Fibonacci.next == 1
    assert Fibonacci.next == 1
    assert Fibonacci.next == 2
    assert Fibonacci.next == 3
    assert Fibonacci.next == 5
    assert Fibonacci.next == 8

    catch_exit Fibonacci.next
  end
end
