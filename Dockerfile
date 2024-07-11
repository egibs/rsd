FROM cgr.dev/chainguard/rust@sha256:fb52700641ebb5568b5ebf623b78e9a9be12b3c2d55e846c4bcb17d9652bee1d as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d94c01c30dda455626c9642272b489adfc402982b99849149ca678ff4d45b267

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
