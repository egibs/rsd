FROM cgr.dev/chainguard/rust@sha256:0a0878bd6e21912e8d24fa749a8608faf62f0785fba50bd464c3520b62905a0f as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d94c01c30dda455626c9642272b489adfc402982b99849149ca678ff4d45b267

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
