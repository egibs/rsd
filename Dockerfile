FROM cgr.dev/chainguard/rust@sha256:b29d43a20dbb3a9abb889b259b8e88e828bce0fb5bd8249ccc166d82a51ab508 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d7518504f59dacbc90852349c0878871199cefd4bed7952d2eeb7cc3ddbe69e5

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
