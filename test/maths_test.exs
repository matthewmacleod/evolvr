import Evolve.Maths

defmodule MathsTest do
  use ExUnit.Case, async: true

  test "should return integer sum" do
    assert sum([1,2,3]) == 6
  end

  test "should return float sum" do
    assert Float.round(sum([1.1,2.2,3]),1) == 6.3
  end

  test "should return cube" do
    assert Float.round(power(3,3),0) == 27
  end

  test "should return square root" do
    assert Float.round(power(4,1/2),0) == 2
  end

  test "should return mean, average" do
    assert Float.round(mean([1,2,3,4]),1) == 2.5
  end

  test "should return median from even list" do
    assert Float.round(median([1,2,3,4]),1) == 2.5
  end

  test "should return median from odd list" do
    assert median([1,2,3,4,5]) == 3
  end

end
