defmodule WeatherApp do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.api-ninjas.com/v1")
  plug(Tesla.Middleware.Headers, [{"x-api-key", "your_api_key"}])
  plug(Tesla.Middleware.JSON)

  def main(args) do
    args
    |> OptionParser.parse(strict: [city: :string])
    |> send_request()
    |> print_response()
  end

  defp send_request({[city: city], [], []}) do
    get("/weather", query: [city: city])
  end

  defp send_request(_), do: {:error, :invalid_args}

  defp print_response({:ok, %{status: 200, body: body}}) do
    IO.puts("temperature   : #{body["temp"]}°C")
    IO.puts("humidity      : #{body["humidity"]}%")
    IO.puts("wind speed    : #{body["wind_speed"]}m/s")
    IO.puts("wind direction: #{body["wind_degrees"]}°")
  end

  defp print_response({:ok, %{status: status}}) do
    IO.puts("error: http request failed with status code #{status}")
  end

  defp print_response({:error, :invalid_args}) do
    IO.puts("usage: weather_app --city <city>")
  end

  defp print_response({:error, reason}) do
    IO.puts("error: #{reason}")
  end
end
