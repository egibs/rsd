FROM cgr.dev/chainguard/rust@sha256:c7eaad3826b2434e572d1b805c34682fbb3e3e488ce1e7672dccf1e2a293da32 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
