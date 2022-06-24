defmodule Variadic.MixProject do
  use Mix.Project

  def project do
    [
      app: :variadic_elixir,
      version: "1.0.0",
      elixir: "~> 1.10",
      description: description(),
      package: package(),
      name: "Variadic functions",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
     {:ex_doc, "~> 0.28.4", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Simple, if not a bit hacky, way to do variadic functions in Elixir"
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nhpip/variadic-elixir"}
    ]
  end
  
end
