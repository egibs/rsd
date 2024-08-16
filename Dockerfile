FROM cgr.dev/chainguard/rust@sha256:9b167acfd4ccad6ea0861702d2e8b173f4759b63b97bb29ee32cc6dc0b5cdb18 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
