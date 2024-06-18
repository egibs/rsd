FROM cgr.dev/chainguard/rust@sha256:a4f40a7cc66053f2f4e48f2e7f079e45affbeb84137fff14bacb568e4edf3909 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:68b8855b2ce85b1c649c0e6c69f93c214f4db75359e4fd07b1df951a4e2b0140

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
