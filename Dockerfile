FROM cgr.dev/chainguard/rust@sha256:e0b6c966f83e0b12db8e30af758e410d501466d6c44824f003dea37176d69572 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:5e9c88174a28c259c349f308dd661a6ec61ed5f8c72ecfaefb46cceb811b55a1

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
