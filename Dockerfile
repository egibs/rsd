FROM cgr.dev/chainguard/rust@sha256:5c07f1fec0c67ff22f52a63abd4b07bf666c6fbf48fd8d781adf75e67cbd8a57 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
