defmodule Evolvr.Mixfile do
  use Mix.Project

  def project do
    [app: :evolvr,
     version: "0.0.1",
     name: "Evolvr",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps]
  end


  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger],
     mod: {Evolvr, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      { :ex_doc, github: "elixir-lang/ex_doc" }
    ]
  end

  defp escript_config do
    [ main_module: Evolvr.CLI ]
  end
end
