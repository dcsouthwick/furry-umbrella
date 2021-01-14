FROM centos:8

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL org.label-schema.maintainer="David.Southwick@cern.ch"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="davesouth/universalgpu"
LABEL org.label-schema.description="universal gpu (AMD+NVIDIA) base image"
LABEL org.label-schema.url="http://docker.io/davesouth/universalgpu"
LABEL org.label-schema.vcs-url="https://github.com/dcsouthwick/furry-umbrella"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="WSO2"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd=None


ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN \
    DEPS="nvidia-container-runtime rocm-dev" && \
    # ROCM repo
    echo -e "[ROCm]\nname=ROCm\nbaseurl=https://repo.radeon.com/rocm/centos8/rpm\nenabled=1\ngpgcheck=1\ngpgkey=https://repo.radeon.com/rocm/rocm.gpg.key" >> /etc/yum.repos.d/rocm.repo && \
    # NVIDIA repo
    distribution=$(. /etc/os-release; echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.repo | tee /etc/yum.repos.d/nvidia-container-runtime.repo && \
    # install & verify
    # dnf install -y -q epel-release dnf-plugins-core && \
    dnf install -y --setopt=tsflags=nodocs $DEPS && \
    rpm -V $DEPS && \
    dnf -y clean all --enablerepo='*'