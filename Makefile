BINARY = tailscale-ssl-proxy

.PHONY: clean
clean: clean-build clean-bin clean-dist clean-other

.PHONY: clean-build
clean-build:
	rm -rf build/
	rm -rf ${BINARY}

.PHONY: clean-bin
clean-bin:
	rm -rf bin/

.PHONY: clean-dist
clean-dist:
	rm -rf dist/

.PHONY: clean-other
clean-other:
	rm -rf install-${BINARY}.sh cert.pem key.pem ./*.log

.PHONY: upgrade-deps
upgrade-deps: clean
	go mod tidy -compat=1.17
	go install
	go get -u all
	go mod tidy -compat=1.17

.PHONY: go-install
go-install:
	go install

.PHONY: build
build: go-install
	GOOS=$${HOST_OS:-} go build -o ${BINARY}

.PHONY: test
test:
	go install
	go test -v ./...

.PHONY: run
run: go-install
	make build
	./${BINARY}

.PHONY: build-linux
build-linux: go-install
	GOOS=linux GOARCH=amd64 go build -o build/${BINARY}-linux-amd64 .

.PHONY: build-darwin
build-darwin: go-install
	GOOS=darwin GOARCH=amd64 go build -o build/${BINARY}-darwin-amd64 .

.PHONY: build-windows
build-windows: go-install
	GOOS=windows GOARCH=amd64 go build -o build/${BINARY}-windows-amd64.exe .

.PHONY: build-all
build-all: build-linux build-darwin build-windows

.PHONY: release
release: go-install
	./build/godownloader .godownloader.yaml > install-${BINARY}.sh
	goreleaser release --rm-dist
