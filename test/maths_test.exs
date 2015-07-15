import Evolve.Maths

defmodule MathsTest do
  use ExUnit.Case, async: true

  ### basic tests ###

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

  ### linear algebra tests ###

  test "should return the scaled vector" do
    assert scalar_multiply(3,[0,5,10,15]) == [0,15,30,45]
  end

  test "should return vector dot product" do
    assert dot([0,2,4],[0,1,1]) == 6
  end

  test "should return vector addition" do
    assert vector_add([0,2,4],[1,1,1]) == [1,3,5]
  end

  test "should return vector subtraction" do
    assert vector_subtract([0,2,4],[0,1,1]) == [0,1,3]
  end

  test "should return vector sum" do
    assert vector_sum([[0,2,4],[0,1,1],[1,2,3]]) == [1,5,8]
  end

  test "should return a vector with the componentwise mean of vectors" do
    assert vector_mean([[0,0,0],[1,2,4],[2,4,8]]) == [1,2,4]
  end

  test "should return distance between vectors" do
    assert distance([0,0,0],[0,3,4]) == 5
  end

  ## matrix tests ##

  test "should return dimensions of matrix: [rows,columns]" do
    assert shape([[1,2,3],[4,5,6]]) == [2,3]
  end

  test "should return ith row of matrix (zero indexed)" do
    assert get_row([[1,2,3],[4,5,6]],1) == [4,5,6]
  end

  test "should return ith column of matrix (zero indexed)" do
    assert get_column([[1,2,3],[4,5,6]],0) == [1,4]
  end




  ### statistics tests ###

  test "should return mean, average" do
    assert Float.round(mean([1,2,3,4]),1) == 2.5
  end

  test "should return median from even list" do
    assert Float.round(median([4,2,3,1]),1) == 2.5
  end

  test "should return median from odd list" do
    assert median([5,2,3,4,1]) == 3
  end

  test "should return the data range for list" do
    assert data_range([2,1,3,5,4]) == 4
  end

  test "should return quantile" do
    assert quantile([1,2,3,4],0.25) == 2
  end

  test "should return element counts" do
    assert counts(0,[0,1,1,2,3,3]) == 1
  end

  test "should return modes (max frequency elements)" do
    assert mode([0,1,1,2,3,3,4]) == [1,3]
  end


  ### probability tests ###




  ### machine learning tests ###





end
