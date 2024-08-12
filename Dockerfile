FROM cgr.dev/chainguard/rust@sha256:7621e7a92f41ce191c032f5417f8910854e34488d42eff02129a7bc26e3d9d58 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
