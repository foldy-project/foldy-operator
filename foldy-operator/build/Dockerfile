FROM golang:latest AS builder
ENV GO111MODULE=on
WORKDIR /go/src/github.com/foldy-project/foldy-operator/foldy-operator
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build \
    -o foldy-operator \
    -gcflags all=-trimpath=/go/src/github.com/foldy-project/foldy-operator \
    -asmflags all=-trimpath=/go/src/github.com/foldy-project/foldy-operator \
    github.com/foldy-project/foldy-operator/foldy-operator/cmd/manager

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

ENV OPERATOR=/usr/local/bin/foldy-operator \
    USER_UID=1001 \
    USER_NAME=foldy-operator

COPY --from=builder /go/src/github.com/foldy-project/foldy-operator/foldy-operator/foldy-operator /usr/local/bin/foldy-operator

COPY build/bin /usr/local/bin
RUN  /usr/local/bin/user_setup

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${USER_UID}
