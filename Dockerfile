FROM cgr.dev/chainguard/rust@sha256:0cc25a4a950a59f3af38bada6278fdc46b724a63621f1de84b6d8678eceefc43 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
