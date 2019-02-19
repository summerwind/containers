FROM golang:1.11 AS builder

ARG VERSION

ENV DEP_VERSION=0.5.0 \
    KUSTOMIZE_VERSION=2.0.1

RUN curl -L -O https://github.com/kubernetes-sigs/kubebuilder/releases/download/v${VERSION}/kubebuilder_${VERSION}_linux_amd64.tar.gz \
  && tar zxvf kubebuilder_${VERSION}_linux_amd64.tar.gz \
  && mv kubebuilder_${VERSION}_linux_amd64 /usr/local/kubebuilder

RUN curl -L -O https://github.com/golang/dep/releases/download/v${DEP_VERSION}/dep-linux-amd64 \
  && install -o root -g root -m 755 dep-linux-amd64 /usr/local/bin/dep

RUN curl -L -O https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 \
  && install -o root -g root -m 755 kustomize_${KUSTOMIZE_VERSION}_linux_amd64 /usr/local/bin/kustomize

#######################################

FROM golang:1.11

ENV PATH=/usr/local/kubebuilder/bin:$PATH

COPY --from=builder /usr/local/kubebuilder /usr/local/kubebuilder
COPY --from=builder /usr/local/bin /usr/local/bin
