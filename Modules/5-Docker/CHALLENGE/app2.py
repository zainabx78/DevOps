import os
import socket

import redis
from flask import Flask, render_template_string

app = Flask(__name__)

# Redis connection details come from environment variables (set in docker-compose.yml)
r = redis.Redis(
    host=os.environ.get("REDIS_HOST", "redis"),
    port=int(os.environ.get("REDIS_PORT", 6379)),
    decode_responses=True,
)

# Each container has its own name, so this shows which copy answered the request
CONTAINER = socket.gethostname()

# Each container gets its own colour, so you can see load balancing at a glance
COLOURS = ["#FFB4A2", "#9BE3C8", "#FFD166", "#8EC5FF"]
COLOUR = COLOURS[sum(ord(c) for c in CONTAINER) % len(COLOURS)]

PAGE = """
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ title }}</title>
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,800&display=swap" rel="stylesheet">
<style>
  :root { --accent: {{ colour }}; --bg: #3B1E54; --text: #FFF4E8; --soft: #CDB8DD; }
  * { box-sizing: border-box; }
  body {
    margin: 0; min-height: 100vh; display: grid; place-items: center;
    background: var(--bg); color: var(--text);
    font-family: "Bricolage Grotesque", system-ui, sans-serif;
    border-top: 14px solid var(--accent);
  }
  main { width: min(640px, 90vw); padding: 48px 0; }
  h1 { font-size: clamp(48px, 9vw, 84px); line-height: 1; margin: 0 0 20px; font-weight: 800; letter-spacing: -0.03em; }
  p { font-size: 20px; line-height: 1.5; color: var(--soft); margin: 0 0 32px; max-width: 34em; }
  .count { font-size: clamp(120px, 26vw, 220px); font-weight: 800; line-height: 0.9; color: var(--accent); margin: 0; letter-spacing: -0.05em; }
  .label { font-size: 22px; margin: 8px 0 36px; color: var(--text); }
  .badge {
    display: inline-flex; align-items: center; gap: 12px; padding: 12px 18px;
    border: 2px solid var(--accent); border-radius: 14px; font-size: 17px; margin-bottom: 36px;
  }
  .dot { width: 14px; height: 14px; border-radius: 50%; background: var(--accent); }
  code { font-family: ui-monospace, Consolas, monospace; font-size: 16px; }
  .actions { display: flex; gap: 14px; flex-wrap: wrap; }
  a.button {
    display: inline-block; padding: 14px 24px; border-radius: 12px; font-size: 18px; font-weight: 800;
    text-decoration: none; background: var(--accent); color: var(--bg);
  }
  a.ghost { background: transparent; color: var(--text); border: 2px solid var(--soft); }
  a:focus-visible { outline: 3px solid var(--text); outline-offset: 3px; }
</style>
</head>
<body>
<main>
{{ body|safe }}
<div class="badge"><span class="dot"></span>Served by container <code>{{ container }}</code></div>
</main>
</body>
</html>
"""


def render(title, body):
    return render_template_string(PAGE, title=title, body=body, colour=COLOUR, container=CONTAINER)


@app.route("/")
def home():
    body = """
    <h1>Hi, I'm Zainab.</h1>
    <p>This app runs in Docker, keeps its count in Redis, and NGINX shares
    every visit between three copies of it. Refresh the counter and watch
    the colour change as a different container answers.</p>
    <div class="actions" style="margin-bottom: 36px">
      <a class="button" href="/count">See the visit counter</a>
    </div>
    """
    return render("Zainab's app", body)


@app.route("/count")
def count():
    visits = r.incr("visits")
    body = f"""
    <p class="count">{visits}</p>
    <p class="label">visits to Zainab's app so far</p>
    <div class="actions" style="margin-bottom: 36px">
      <a class="button" href="/count">Visit again</a>
      <a class="button ghost" href="/">Home</a>
    </div>
    """
    return render(f"{visits} visits", body)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
