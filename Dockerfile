FROM cgr.dev/chainguard/rust@sha256:4fdfca2c9d92e4a941ea3a89db83a01176f4627e1d2d4be5f7b1f43abc84a893 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d7518504f59dacbc90852349c0878871199cefd4bed7952d2eeb7cc3ddbe69e5

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
