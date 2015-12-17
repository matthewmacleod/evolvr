import Evolvr.Parallel

defmodule ParallelTest do
  use ExUnit.Case, async: true

  ### basic tests ###

  test "should use pmap" do
    assert pmap 1..10, &(&1 * &1) == [1,4,9,16,25,36,49,64,81,100]
  end



end


