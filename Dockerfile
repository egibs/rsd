FROM cgr.dev/chainguard/rust@sha256:4abdbc0a119268e33ba070a52e19353ea8d0d25b1a3db4c34848ed88181d9cbc as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:0fa3935a85aa2349cc89d9715d891c318f700ba951f3945610a2b90c6b0d5e76

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
