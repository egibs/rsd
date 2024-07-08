FROM cgr.dev/chainguard/rust@sha256:8d66cda206047252b39305a7c5c3196f7d519c14c2634ab01000a454d6675571 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d94c01c30dda455626c9642272b489adfc402982b99849149ca678ff4d45b267

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
