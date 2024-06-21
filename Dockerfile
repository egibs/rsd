FROM cgr.dev/chainguard/rust@sha256:2f9305aeb62e0a6bbbf4b133cf8bc3d1f8dd4122b81f1eb27a3dd06bd650e6b9 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
