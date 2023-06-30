#!/usr/bin/env sh
set -x
NAME=go-proxy-bingai 
SRC="main.go" 
rm -rf ./release

CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build     -tags netgo -trimpath  -ldflags="-w -s" -o release/${NAME}_darwin_amd64 ${SRC}                 
CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build     -tags netgo -trimpath  -ldflags="-w -s" -o release/${NAME}_darwin_arm64 ${SRC}                 
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build      -tags netgo -trimpath  -ldflags="-w -s" -o release/${NAME}_linux_amd64 ${SRC}                                            
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build      -tags netgo -trimpath  -ldflags="-w -s" -o release/${NAME}_linux_arm64 ${SRC}                                  
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build    -tags netgo -trimpath  -ldflags="-w -s" -o release/${NAME}_windows_amd64.exe ${SRC}                               

pushd release
for entry in *
do
  echo "Packing : ${entry%.*}.tar.xz"
  COPYFILE_DISABLE=1 tar cvfJ ${entry%.*}.tar.xz $entry && rm $entry
done
popd
