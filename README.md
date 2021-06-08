# Variadic

Simulates Variadic functions in Elixir (i.e functions with an unknown number of arguments)

Arguments will named arg1, arg2....argN where N is @max_arity.

Uninitialized arguments are set to nil

## Example:

```
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
```
From the shell:
```
  Pass 3 arguments (note arg4 is nil):
    iex(2)> MyModule.test_function(1, 2, :hello)
    {1, 2, :hello, nil, 3, [1, 2, :hello]}

  Pass 10 arguments:
    iex(3)> MyModule.test_function(1, 2, :hello, 4, 5, 6, :bye, %{key: 123}, [771,"something"], 10)
    {1, 2, :hello, 4, 3, [1, 2, :hello, 4, 5, 6, :bye, %{key: 123}, [771, "something"], 10]}

  Show binding
    iex(10)> MyModule.other_function(777, 888, 999)
    {777, 888, 6, [arity: 3, arguments: [777, 888, 999]]}
```

Helper functions: `get_arity/1` and `args_to_list/1`
