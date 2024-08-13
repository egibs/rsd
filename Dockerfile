FROM cgr.dev/chainguard/rust@sha256:fc5f6925ba3745d2ad061a8e9e7125566eb1631101ae7bfe9a3f20daaff56524 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
