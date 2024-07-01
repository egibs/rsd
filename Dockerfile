FROM cgr.dev/chainguard/rust@sha256:8d66cda206047252b39305a7c5c3196f7d519c14c2634ab01000a454d6675571 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
