FROM foldy/foldy-operator:deps AS deps
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

COPY --from=deps /go/src/github.com/foldy-project/foldy-operator/foldy-operator/foldy-operator ${OPERATOR}

COPY build/bin /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint \
    && chmod +x /usr/local/bin/user_setup \
    && /usr/local/bin/user_setup

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${USER_UID}
