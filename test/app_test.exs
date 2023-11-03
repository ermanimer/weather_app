defmodule WeatherAppTest do
  use ExUnit.Case

  import Tesla.Mock
  import ExUnit.CaptureIO

  setup do
    mock(fn
      %{method: :get, url: "https://api.api-ninjas.com/v1/weather", query: [city: "corlu"]} ->
        %Tesla.Env{
          status: 200,
          body: %{"temp" => 1, "humidity" => 2, "wind_speed" => 3, "wind_degrees" => 4}
        }

      %{method: :get, url: "https://api.api-ninjas.com/v1/weather", query: [city: "unknown_city"]} ->
        %Tesla.Env{status: 400}
    end)
  end

  test "main" do
    assert "temperature   : 1°C\nhumidity      : 2%\nwind speed    : 3m/s\nwind direction: 4°\n" ==
             capture_io(fn -> WeatherApp.main(["corlu"]) end)

    assert "error: http request failed with status code 400\n" ==
             capture_io(fn -> WeatherApp.main(["unknown_city"]) end)
  end
end
