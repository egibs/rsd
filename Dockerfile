FROM cgr.dev/chainguard/rust@sha256:abe2b65ccb33882f7589842a207d7b73692c1c646e474e7bf5d48c2c2d91e96b as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:e78eb21f59f52446a23f7d45e78805c4f26406a6e9c4b21ec50dfdf07e6bec57

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
