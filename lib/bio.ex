defmodule Bio do

  def get_kmers("", _k) do
    []
  end

  def get_kmers(seq, k) do
    ht = String.split_at(seq, k)
    head = elem(ht, 0)
    tail = elem(ht, 1)
    [ head | get_kmers(tail, k) ]
  end

  def pattern_count(seq, pattern) do
    _k = String.length(pattern)
    seq
  end

end


