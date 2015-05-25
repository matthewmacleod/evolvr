defmodule BioTest do
  use ExUnit.Case

  test "should return count of a particular pattern in a sequence..including overlaps" do
    pc = Bio.pattern_count("ACAACTATGCATACTATCGGGAACTATCCT","ACTAT")
    assert pc == 3
  end


end
