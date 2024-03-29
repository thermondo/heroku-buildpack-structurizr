
FROM heroku/heroku:22-build
SHELL [ "/bin/bash", "-Eeuo", "pipefail", "-c" ]

WORKDIR /app

ENV STACK=heroku-22

RUN mkdir /tmp/structurizr-lite /tmp/structurizr-ui /app/structurizr-lite /app/structurizr-ui /var/build-cache

# Download structurizr
RUN curl -sfSLo- https://github.com/structurizr/lite/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp/structurizr-lite && \
curl -sfSLo- https://github.com/structurizr/ui/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp/structurizr-ui

RUN mv /tmp/structurizr-lite/lite-main/* /app/structurizr-lite/. && \
mv /tmp/structurizr-ui/ui-main/* /app/structurizr-ui/.

WORKDIR /app/structurizr-lite
RUN ./ui.sh

WORKDIR /app

RUN echo "java.runtime.version=17.0.6" > /app/structurizr-lite/system.properties

# Download the gradle buildpack
RUN curl -sfSLo- https://github.com/heroku/heroku-buildpack-gradle/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp && \
/tmp/heroku-buildpack-gradle-main/bin/compile /app/structurizr-lite /var/build-cache /var/env
