FROM dart:3.2-sdk AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart compile exe bin/main.dart -o bin/adventure_game

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/bin/adventure_game /app/adventure_game
COPY --from=build /app/assets /app/assets

EXPOSE 8080
CMD ["/app/adventure_game"]
