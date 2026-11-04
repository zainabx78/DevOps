# Simple Weather App - browser version
# Open it in your web browser, type a city, and see the weather.
# Uses the free Open-Meteo service - no account or key needed.

import requests
from flask import Flask, request, render_template_string

app = Flask(__name__)

# Weather code -> (plain words, sky colour for the page background)
WEATHER = {
    0: ("Clear sky", "clear"), 1: ("Mostly clear", "clear"),
    2: ("Partly cloudy", "cloudy"), 3: ("Cloudy", "cloudy"),
    45: ("Foggy", "fog"), 48: ("Foggy", "fog"),
    51: ("Light drizzle", "rain"), 53: ("Drizzle", "rain"), 55: ("Heavy drizzle", "rain"),
    61: ("Light rain", "rain"), 63: ("Rain", "rain"), 65: ("Heavy rain", "rain"),
    71: ("Light snow", "snow"), 73: ("Snow", "snow"), 75: ("Heavy snow", "snow"),
    80: ("Rain showers", "rain"), 81: ("Rain showers", "rain"), 82: ("Heavy rain showers", "rain"),
    95: ("Thunderstorm", "storm"), 96: ("Thunderstorm with hail", "storm"),
    99: ("Thunderstorm with hail", "storm"),
}


def get_data(url, params):
    response = requests.get(url, params=params, timeout=10)
    response.raise_for_status()
    return response.json()


def look_up(city):
    places = get_data("https://geocoding-api.open-meteo.com/v1/search",
                      {"name": city, "count": 1}).get("results")
    if not places:
        return None
    place = places[0]
    now = get_data("https://api.open-meteo.com/v1/forecast", {
        "latitude": place["latitude"],
        "longitude": place["longitude"],
        "current": "temperature_2m,apparent_temperature,weather_code,wind_speed_10m",
    })["current"]
    words, sky = WEATHER.get(now["weather_code"], ("Unknown", "cloudy"))
    return {
        "place": place["name"],
        "country": place.get("country", ""),
        "words": words,
        "sky": sky,
        "temp": round(now["temperature_2m"]),
        "feels": round(now["apparent_temperature"]),
        "wind": round(now["wind_speed_10m"]),
    }


PAGE = """
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Weather{% if w %} in {{ w.place }}{% endif %}</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,700&display=swap" rel="stylesheet">
<style>
  :root { --sky: #8fc3ea; --ink: #0d2a44; --soft: rgba(13,42,68,.65); }
  body.clear  { --sky: #8fc3ea; --ink: #0d2a44; --soft: rgba(13,42,68,.65); }
  body.cloudy { --sky: #c3cbd3; --ink: #26313b; --soft: rgba(38,49,59,.65); }
  body.fog    { --sky: #dde0de; --ink: #3a403d; --soft: rgba(58,64,61,.65); }
  body.rain   { --sky: #4f6578; --ink: #eef3f7; --soft: rgba(238,243,247,.7); }
  body.snow   { --sky: #eef4fb; --ink: #2c4a6b; --soft: rgba(44,74,107,.65); }
  body.storm  { --sky: #2f2a45; --ink: #f1edff; --soft: rgba(241,237,255,.7); }
  * { box-sizing: border-box; }
  body {
    margin: 0; min-height: 100vh; background: var(--sky); color: var(--ink);
    font-family: "Bricolage Grotesque", system-ui, sans-serif;
    display: flex; flex-direction: column; padding: 2rem clamp(1.25rem, 6vw, 5rem);
    transition: background .6s ease;
  }
  form { display: flex; gap: .5rem; max-width: 30rem; }
  input {
    flex: 1; font: inherit; font-size: 1.1rem; padding: .7rem 1rem;
    border: 2px solid var(--ink); border-radius: 999px; background: transparent; color: var(--ink);
  }
  input::placeholder { color: var(--soft); }
  button {
    font: inherit; font-weight: 700; font-size: 1.1rem; padding: .7rem 1.4rem;
    border: none; border-radius: 999px; background: var(--ink); color: var(--sky); cursor: pointer;
  }
  input:focus-visible, button:focus-visible { outline: 3px solid var(--ink); outline-offset: 3px; }
  main { flex: 1; display: flex; flex-direction: column; justify-content: flex-end; padding-top: 3rem; }
  .temp { font-size: clamp(7rem, 30vw, 18rem); font-weight: 700; line-height: .85; letter-spacing: -.05em; margin: 0; }
  .place { font-size: clamp(1.6rem, 5vw, 2.6rem); margin: 1rem 0 .25rem; }
  .details { font-size: 1.15rem; color: var(--soft); margin: 0; }
  .note { font-size: 1.3rem; color: var(--soft); max-width: 28rem; }
  @media (prefers-reduced-motion: reduce) { body { transition: none; } }
</style>
</head>
<body class="{{ w.sky if w else 'clear' }}">
  <form method="get" action="/">
    <input name="city" placeholder="Type a city" value="{{ city }}" aria-label="City" autofocus>
    <button type="submit">Show weather</button>
  </form>
  <main>
    {% if w %}
      <p class="temp">{{ w.temp }}°</p>
      <h1 class="place">{{ w.place }}, {{ w.country }}</h1>
      <p class="details">{{ w.words }}. Feels like {{ w.feels }}°C, wind {{ w.wind }} km/h.</p>
    {% elif message %}
      <p class="note">{{ message }}</p>
    {% else %}
      <p class="note">Type a city above to see its weather right now.</p>
    {% endif %}
  </main>
</body>
</html>
"""


@app.route("/")
def home():
    city = request.args.get("city", "").strip()
    w, message = None, ""
    if city:
        try:
            w = look_up(city)
            if not w:
                message = f"No city called “{city}” was found. Check the spelling and try again."
        except Exception as error:
            # Show the real problem in the terminal, to help fix it
            print("Weather lookup failed:", repr(error))
            message = "The weather service didn't answer. Check your internet connection and try again."
    return render_template_string(PAGE, w=w, city=city, message=message)


if __name__ == "__main__":
    # 0.0.0.0 lets Docker show the app on your computer
    app.run(host="0.0.0.0", port=5000)