# Dockerfile for the App

# Stage 1 - Build
FROM python:3.12-slim AS build

# Create a folder called /app and go into it. Everything after this happens inside that folder
WORKDIR /app

COPY requirements.txt .

# Install everything on the shopping list (Flask and Redis). --no-cache-dir throws away leftover download files to keep things small. 
# --prefix=/install puts the packages in a folder called /install, so they’re easy to find and pick up in Stage 2.
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy the rest of your project (like app.py) into /app.
COPY . .





# Stage 2 - Prod
FROM python:3.12-slim

# Create and go into /app again, because this is a fresh start.
WORKDIR /app

# A setting that makes the app’s messages show up in the logs straight away instead of being delayed.
ENV PYTHONUNBUFFERED=1

# Tells the app that Redis can be found at the name redis.
ENV REDIS_HOST=redis

# Reach back into the “build” stage and grab the installed packages from /install. 
# Put them in /usr/local, which is where Python automatically looks for packages.
COPY --from=build /install /usr/local

# Grab your app files from the build stage and put them in /app here.
COPY --from=build /app /app

# Create a normal, limited user called appuser
RUN useradd appuser

# Switch to that user, so the app doesn’t run as root (the all-powerful admin). 
# Safer if someone breaks in.
USER appuser

EXPOSE 5000

# When the container starts, run python app.py to launch the app.
CMD ["python", "app.py"]