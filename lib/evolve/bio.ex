defmodule Evolve.Bio do

  def get_all_kmers("", _k) do
    []
  end

  def get_all_kmers(seq, k) do
    ht = String.split_at(seq, k)
    head = elem(ht, 0)
    htt = String.split_at(seq, 1)
    tail = elem(htt, 1)
    [ head | get_all_kmers(tail, k) ]
  end

  def get_kmers(seq, k) do
    ks = get_all_kmers(seq, k)
    Enum.filter(ks, fn(x) -> String.length(x) == k end)
  end

  def count_pattern([], _pattern, total) do
    total
  end

  def count_pattern(kmers, pattern, total) do
    [head | tail] = kmers
    if head == pattern do
      count_pattern(tail, pattern, total+1)
    else
      count_pattern(tail, pattern, total)
    end
  end


  def pattern_count(seq, pattern) do
    k = String.length(pattern)
    kmers = get_kmers(seq, k)
    count_pattern(kmers, pattern, 0)
  end

end


