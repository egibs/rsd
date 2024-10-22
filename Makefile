.PHONY: build docker fmt fmt-check test release sbom

keygen:
	melange keygen

rsd-melange: keygen
	melange build --arch arm64,x86_64 rsd.yaml --signing-key melange.rsa --git-repo-url  https://github.com/egibs/rsd --git-commit 9e58fafed60dcc9e5068ccf00bebefd76649f658

rsd-apko: rsd-melange
	apko build rsd.apko.yaml rsd:latest rsd.tar

rsd-docker:
	docker load < rsd.tar

build:
	rustc -C target-feature=+crt-static src/main.rs -o rsd

docker:
	docker buildx build -t rsd:latest .

fmt:
	cargo fmt --all

fmt-check:
	cargo fmt --all -- --check

test:
	cargo test --all --release

release:
	cargo build --all --release

sbom:
	syft -o spdx-json . | jq . > sbom.json
