defmodule WeatherApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather_app,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: WeatherApp]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.8"},
      {:jason, "~> 1.4"}
    ]
  end
end
