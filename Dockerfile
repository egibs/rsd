FROM cgr.dev/chainguard/rust@sha256:4e7729b380ad4793453d126d47822caa63990b5fb382c85bf9f0a02b003c248e as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
