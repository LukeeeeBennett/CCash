FROM debian:latest AS build
WORKDIR /ccash
RUN apt update && apt -y install build-essential g++ cmake protobuf-compiler libjsoncpp-dev uuid-dev openssl libssl-dev zlib1g-dev
COPY . .
RUN mkdir build

WORKDIR /ccash/build
RUN cmake ..
RUN make -j$(nproc)

FROM debian:latest
WORKDIR /ccash/build
RUN apt update && apt -y install libjsoncpp-dev uuid-dev openssl libssl-dev zlib1g-dev
COPY --from=build /ccash/build .

ENTRYPOINT ["/ccash/build/bank"]
