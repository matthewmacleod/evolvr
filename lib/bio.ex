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


