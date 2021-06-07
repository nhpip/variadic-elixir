defmodule VariadicTest do
  use ExUnit.Case
  doctest Variadic

  test "greets the world" do
    assert Variadic.hello() == :world
  end
end
