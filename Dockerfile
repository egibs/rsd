FROM cgr.dev/chainguard/rust@sha256:abe2b65ccb33882f7589842a207d7b73692c1c646e474e7bf5d48c2c2d91e96b as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:0fa3935a85aa2349cc89d9715d891c318f700ba951f3945610a2b90c6b0d5e76

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
