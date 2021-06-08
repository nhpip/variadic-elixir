#
# MIT License
#
# Copyright (c) 2021 Matthew Evans
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

defmodule Variadic do
  @moduledoc """
  Simulates Variadic functions in Elixir (i.e functions with an unknown number of arguments)

  Arguments will named arg1, arg2....argN where N is @max_arity.

  Uninitialized arguments are set to nil

  Example:

  defmodule MyTestModule do

    import Variadic

    ##
    ## Functions are defined as defv (they will be public)
    ##
    defv :test_function do
      # If arguments needed as a list or need arity then binding() should be the first thing called
      arguments = args_to_list(binding())
      work = arg1 + arg2
      {arg1, arg2, arg3, arg4, work, arguments}
    end

    defv :other_function do
      binding = binding()
      ## Do work
      x = 1 + 2 + 3
      arguments = args_to_list(binding)
      arity = get_arity(binding)
      {arg1, arg2, x, [arity: arity, arguments: arguments]}
    end
  end

  Pass 3 arguments (note arg4 is nil)::
    iex(2)> MyModule.test_function(1, 2, :hello)
    {1, 2, :hello, nil, 3, [1, 2, :hello]}

  Pass 10 arguments:
    iex(3)> MyModule.test_function(1, 2, :hello, 4, 5, 6, :bye, %{key: 123}, [771,"something"], 10)
    {1, 2, :hello, 4, 3, [1, 2, :hello, 4, 5, 6, :bye, %{key: 123}, [771, "something"], 10]}

  Show binding
    iex(10)> MyModule.other_function(777, 888, 999)
    {777, 888, 6, [arity: 3, arguments: [777, 888, 999]]}

  Helper functions: get_arity/1 and args_to_list/1
  """

  ## Probably not a good idea to make this too high
  @max_arity 25

  defmacro defv(name, do: block) do
    args =
      for n <- 1..@max_arity do
        {:\\, [], [{:"arg#{n}", [], nil}, nil]}
      end

    function_head = {name, [], args}
    {block_header, _, block_body} = block
    # To avoid unused variables
    new_block = {block_header, [], [{:binding, [], []} | block_body]}

    quote do
      def unquote(function_head) do
        unquote(new_block)
      end
    end
  end

  @doc "Returns the arity of the set arguments
    arity = get_arity(binding())

    The function binding should be the first function called
  "
  def get_arity(binding) do
    Enum.count(binding, fn {_, e} -> e != nil end)
  end

  @doc "Returns the ordered list of set arguments
    arguments = args_to_list(binding())

    The function binding should be the first function called
  "
  def args_to_list(binding) do
    Enum.map(binding, fn {a, v} -> {arg_to_integer(a), v} end)
    |> Enum.filter(fn {_, e} -> e != nil end)
    |> Enum.sort()
    |> Enum.map(fn {_, v} -> v end)
  end

  defp arg_to_integer(arg),
    do: Atom.to_string(arg) |> String.replace("arg", "") |> String.to_integer()
end
