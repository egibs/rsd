FROM cgr.dev/chainguard/rust@sha256:b29d43a20dbb3a9abb889b259b8e88e828bce0fb5bd8249ccc166d82a51ab508 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
