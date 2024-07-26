FROM cgr.dev/chainguard/rust@sha256:0cc25a4a950a59f3af38bada6278fdc46b724a63621f1de84b6d8678eceefc43 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d7518504f59dacbc90852349c0878871199cefd4bed7952d2eeb7cc3ddbe69e5

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
