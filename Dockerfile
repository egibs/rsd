FROM cgr.dev/chainguard/rust@sha256:a38d5a01d8aa01efd0943cfe8cc86f52bcb1c50f7008c676b67c8b1888db653b as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
