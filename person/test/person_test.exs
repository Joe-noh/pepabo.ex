defmodule PersonTest do
  use ExUnit.Case

  test "them" do
    assert Person.alex == %Person{name: "alex", age: 20}
    assert Person.jack == %Person{name: "jack", age: 18}
    assert Person.mary == %Person{name: "mary", age: 22}
  end
end
