FROM cgr.dev/chainguard/rust@sha256:1870b54d85e47a7dea50a3e441615a89325d511d80c5a8a35864ebdd740fb102 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:d94c01c30dda455626c9642272b489adfc402982b99849149ca678ff4d45b267

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
