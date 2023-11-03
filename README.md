# WeatherApp

This repository features a CLI tool that uses an HTTP client implementation for educational purposes, with tests included.

# Usage

Update the api key in lib/app.ex line 5:

```elixir
plug(Tesla.Middleware.Headers, [{"x-api-key", "your_api_key"}])
```

Build:

```bash
mix escript.build
```

Run:

```bash
./weather_app tekirdag
```

Output:

```bash
temperature   : 22°C
humidity      : 64%
wind speed    : 4.12m/s
wind direction: 160°
```
