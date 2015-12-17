
import Evolvr.Bio

defmodule BioTest do
  use ExUnit.Case, async: true

  test "should return count of a particular pattern in a sequence where count includes overlaps" do
    assert pattern_count("ACAACTATGCATACTATCGGGAACTATCCT","ACTAT") == 3
  end

  test "should break up sequence into an array of k chunks" do
    seq = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    all_kmers = ["ABC", "BCD", "CDE", "DEF", "EFG", "FGH", "GHI", "HIJ", "IJK", "JKL", "KLM", "LMN", "MNO", "NOP", "OPQ", "PQR", "QRS", "RST", "STU", "TUV", "UVW", "VWX", "WXY", "XYZ"]
    assert get_kmers(seq, 3) == all_kmers
  end

  test "should return most frequent kmers in sequence" do
    seq = "ACGTTGCATGTCGCATGATGCATGAGAGCT"
    assert frequent_words(seq, 4) == ["CATG", "GCAT"]
  end

end
