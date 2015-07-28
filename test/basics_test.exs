import Evolve.Basics

defmodule BasicsTest do
  use ExUnit.Case

  ### basic tests ###

  test "should quicksort a list" do
    assert qsort([5,1,4,2,3,6]) == [1,2,3,4,5,6]
  end

  test "should compress a list" do
    start_list = [1,2,2,2,3,4,4,5,6,6,6,6]
    end_list = [1,{2,3},3,{4,2},5,{6,4}]
    assert compress(start_list) == end_list
  end


end


