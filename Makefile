run:
	go run ./main.go

build:
	mkdir -p bin/cmd/
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -a -installsuffix cgo -o sample-test-one ./main.go

fmt:
	go fmt ./...

vet:
	go vet ./*

gometalinter:
	gometalinter ./*