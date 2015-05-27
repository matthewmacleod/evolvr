defmodule Evolve do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Evolve.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Evolve.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def main(args) do
    options = parse_args(args)
    IO.puts "Running evolve bioinformatics program..."
    IO.puts " using these options:"
    IO.inspect options
    IO.puts "input file = "
    IO.inspect  options[:input]
    infile = options[:input]

    data = File.read!(infile)
    IO.inspect data
    cdata = String.replace(data, "\n", "")
    data_list = String.split(cdata, "\r", trim: true)
    IO.inspect data_list

    [seq,k] = data_list
    ik = String.to_integer(k)
    IO.inspect seq
    kmers = Evolve.Bio.get_kmers(seq,ik)
    IO.puts "getting kmers for k = #{k}..."
    IO.inspect kmers

  end


  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [n: :integer, url: :string]
    )
    options
  end

end
