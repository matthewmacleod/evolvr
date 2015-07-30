import Evolve.Maths
import Evolve.Data

defmodule MathsTest do
  use ExUnit.Case, async: true

  ### basic tests ###
  import :math

  test "should return integer sum" do
    assert sum([1,2,3]) == 6
  end

  test "should return float sum" do
    assert Float.round(sum([1.1,2.2,3]),1) == 6.3
  end

  test "should return cube" do
    assert round(pow(3,3)) == 27
  end

  test "should return square root" do
    assert round(pow(4,1/2)) == 2
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

  test "should return minkowoski distance between vectors" do
    assert minkowski_distance([0,0,0],[0,3,4],2) == 5
  end

  test "should return angle between vectors" do
    assert Float.round(angle([9,2,7],[4,8,10]),3) == 38.229
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

  test "should give componentwise difference from mean" do
    assert from_mean([1,3,2,4]) == [-1.5,0.5,-0.5,1.5]
  end

  test "should return variance" do
    assert Float.round(variance([1,3,2,4]),3) == 1.667
  end

  test "should return standard deviations" do
    assert Float.round(standard_deviation([1,3,2,4]),3) == 1.291
  end


  ### probability tests ###

  test "should return uniform cumulative distribution value" do
    assert uniform_cdf(0.8) == 0.8
  end

  test "should return normal probability distribution value" do
    assert Float.round(normal_pdf(0,0,1),4) == 0.3989
  end

  test "should return normal cumulative distribution value" do
    assert normal_cdf(0,0,1) == 0.5
  end

  test "should return gamma function value" do
    #assert gamma(0.5) == :math.sqrt(:math.pi)
    assert Float.round(gamma(9+1),4) == factorial(9)
  end

  test "should return beta function value" do
    assert Float.round(beta_pdf(0.5,2,2),4) == 1.5
  end


  ### machine learning tests ###

  test "should partition a list" do
    list = [1,2,3,4,5,6,7,8,9,10]
    training = [1,2,3,4,5,6]
    testing = [7,8,9,10]
    assert create_data_partition(list,0.6) == {training,testing}
  end

  test "should import data dict" do
    sorted = [{[3.0, 20.0], 0}, {[20.0, 14.0], 0}, {[18.0, 1.0], 1}, {[30.0, 30.0], 1}, {[35.0, 35.0], 1}, {[56.0, 2.0], 1}]
    assert Enum.sort_by(house, fn {k,v} -> v end) == sorted
  end

  test "should find nearest neighbor" do
    # pattern match the output into more useable form
    [{nearest_point, value}] = find_nearest(house,[10.0,10.0])
    assert {nearest_point, value} == {[20.0, 14.0],0}
  end



end
