FROM cgr.dev/chainguard/rust@sha256:4fdfca2c9d92e4a941ea3a89db83a01176f4627e1d2d4be5f7b1f43abc84a893 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:0fa3935a85aa2349cc89d9715d891c318f700ba951f3945610a2b90c6b0d5e76

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
