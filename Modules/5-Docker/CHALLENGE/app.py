import os
from flask import Flask
import redis

app = Flask(__name__)

# Connect to Redis. "redis" is the name of the Redis container (set in docker-compose.yml)
# r = redis.Redis(host=os.environ.get("REDIS_HOST", "redis"), port=6379, decode_responses=True)

# New added - env variable bonus task
r = redis.Redis(host=os.environ.get("REDIS_HOST", "redis"), port=int(os.environ.get("REDIS_PORT", 6379)), decode_responses=True)

@app.route("/")
def home():
    return "Welcome! Go to /count to see the visit counter."


@app.route("/count")
def count():
    visits = r.incr("visits")  # add 1 to the "visits" number stored in Redis
    return f"This page has been visited {visits} times."


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
