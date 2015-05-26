
import Bio

defmodule BioTest do
  use ExUnit.Case

  test "should return count of a particular pattern in a sequence where count includes overlaps" do
    pc = pattern_count("ACAACTATGCATACTATCGGGAACTATCCT","ACTAT")
    assert pc == 3
  end

  test "should break up sequence into an array of k chunks" do
    seq = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    ans = ["ABC", "DEF", "GHI", "JKL", "MNO", "PQR", "STU", "VWX", "YZ"]
    assert get_kmers(seq,3) == ans
  end


end
