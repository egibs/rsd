FROM cgr.dev/chainguard/rust@sha256:7766cec2f849fa923c87ada8d58ab986574362ed8ef52fcda1aaeb45d46fb901 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
