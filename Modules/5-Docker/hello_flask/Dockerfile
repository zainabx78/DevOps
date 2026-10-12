

# Stage 1: Build stage

FROM python:3.8-slim as Build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

COPY . .

RUN pip install --prefix=/install flask mysqlclient



# Stage 2 - Production stage

FROM python:3.8-slim 

WORKDIR /app

RUN apt-get update && apt-get install -y libmariadb3 && rm -rf /var/lib/apt/lists/*

COPY --from=build /install /usr/local
COPY --from=build /app /app

EXPOSE 5000

CMD ["python", "app.py"]
