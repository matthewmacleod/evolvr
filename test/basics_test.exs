import Evolve.Basics

defmodule BasicsTest do
  use ExUnit.Case

  ### basic tests ###

  test "should quicksort a list" do
    assert qsort([5,1,4,2,3,6]) == [1,2,3,4,5,6]
  end



end


