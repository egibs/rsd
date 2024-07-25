FROM cgr.dev/chainguard/rust@sha256:4abdbc0a119268e33ba070a52e19353ea8d0d25b1a3db4c34848ed88181d9cbc as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d7518504f59dacbc90852349c0878871199cefd4bed7952d2eeb7cc3ddbe69e5

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
