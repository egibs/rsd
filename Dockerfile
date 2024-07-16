FROM cgr.dev/chainguard/rust@sha256:1870b54d85e47a7dea50a3e441615a89325d511d80c5a8a35864ebdd740fb102 as build

WORKDIR /build

COPY . .

RUN make build

FROM cgr.dev/chainguard/static@sha256:e78eb21f59f52446a23f7d45e78805c4f26406a6e9c4b21ec50dfdf07e6bec57

COPY --from=build /build/rsd /rsd

ENTRYPOINT ["/rsd"]
