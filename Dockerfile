FROM cgr.dev/chainguard/rust@sha256:4abdbc0a119268e33ba070a52e19353ea8d0d25b1a3db4c34848ed88181d9cbc as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:e78eb21f59f52446a23f7d45e78805c4f26406a6e9c4b21ec50dfdf07e6bec57

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
