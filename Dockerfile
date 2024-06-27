FROM cgr.dev/chainguard/rust@sha256:3c4ac0bc04a168ee21a4237a9669f89e02924fff23180c900b5015ade3421c83 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
