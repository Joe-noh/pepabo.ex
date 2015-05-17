defmodule Person do
  @external_resource people_txt = [__DIR__, ~w(.. priv people.txt)]
    |> List.flatten
    |> Path.join

  defstruct [:name, :age]

  File.stream!(people_txt)
  |> Stream.map(fn line ->
    [name, age] = String.split(line)
    age = String.to_integer(age)
    fn_name = String.to_atom(name)

    def unquote(fn_name)() do
      %__MODULE__{name: unquote(name), age: unquote(age)}
    end
  end)
  |> Stream.run
end
