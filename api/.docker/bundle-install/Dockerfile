# =============================================================================
# DOCKERFILE — Lambda-Compatible Gem Builder
# =============================================================================
#
# Builds Ruby gems with native extensions (trilogy, etc.) against the
# Amazon Linux ARM64 environment to match AWS Lambda's runtime.
#
# The GitHub Actions runner compiles gems against Ubuntu's glibc, which
# may differ from Lambda's Amazon Linux glibc. This Docker image ensures
# native extensions are linked against the correct libraries.
#
# USAGE (in GitHub Actions):
#   docker run --platform linux/arm64 --rm \
#     -v $PWD/api:/var/task -w /var/task \
#     $(docker buildx build --platform linux/arm64 -q api/.docker/bundle-install)
#
# =============================================================================

FROM public.ecr.aws/lambda/ruby:3.4
LABEL maintainer="david@cutmyaws.com"

WORKDIR /var/task

RUN mkdir -p /var/task/vendor

# Install build dependencies for native gem extensions
# - openssl/openssl-devel: required by trilogy gem (TiDB/MySQL SSL connections)
# - gcc/make: C compiler toolchain for native extensions
RUN dnf install libyaml-devel git make automake gcc gcc-c++ kernel-devel tar -y
RUN dnf install openssl openssl-devel -y

COPY entry.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entry.sh
ENTRYPOINT entry.sh
