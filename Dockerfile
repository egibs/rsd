FROM cgr.dev/chainguard/rust@sha256:8d66cda206047252b39305a7c5c3196f7d519c14c2634ab01000a454d6675571 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:a1f8a15835e5efebb41f7a3a1a81d32143c7c0ac83a27d85401fe52904c90182

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
