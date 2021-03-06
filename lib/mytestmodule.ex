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

 defmodule MyTestModule do
   @moduledoc """
   Simple test module to show Variadic functions. See documentation for the Variadic module.

   """

   import Variadic

   @doc false
   defv :test_function do
     # If arguments needed as a list this should be the first thing called
     arguments = args_to_list(binding())
     work = arg1 + arg2
     {arg1, arg2, arg3, arg4, work, arguments}
   end

   @doc false
   defv :other_function do
     binding = binding()
     ## Do work
     x = 1 + 2 + 3
     arguments = args_to_list(binding)
     arity = get_arity(binding)
     {arg1, arg2, x, [arity: arity, arguments: arguments]}
   end
 end
