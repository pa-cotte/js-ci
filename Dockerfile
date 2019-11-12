FROM node:10.15-alpine

# Get library requirements.
RUN apk update && apk add make git build-base protobuf curl autoconf automake libtool python bash docker go

# install gcloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN gcloud components install kubectl

RUN npm install -g @angular/cli
RUN npm install -g firebase-tools

RUN GIT_TAG="v1.3.1" \
    && go get -d -u github.com/golang/protobuf/protoc-gen-go \
    && git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout $GIT_TAG \
    && go install github.com/golang/protobuf/protoc-gen-go
