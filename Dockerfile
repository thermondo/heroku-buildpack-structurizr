
FROM heroku/heroku:22-build

WORKDIR /app

ENV STACK=heroku-22

RUN mkdir /tmp/structurizr-lite /tmp/structurizr-ui /app/structurizr-lite /app/structurizr-ui /var/build-cache

# Download structurizr
RUN curl -sLo- https://github.com/structurizr/lite/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp/structurizr-lite
RUN curl -sLo- https://github.com/structurizr/ui/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp/structurizr-ui

RUN mv /tmp/structurizr-lite/lite-main/* /app/structurizr-lite/.
RUN mv /tmp/structurizr-ui/ui-main/* /app/structurizr-ui/.

WORKDIR /app/structurizr-lite
RUN ./ui.sh

WORKDIR /app

RUN echo "java.runtime.version=17.0.6" > /app/structurizr-lite/system.properties

# Download the gradle buildpack
RUN curl -sLo- https://github.com/heroku/heroku-buildpack-gradle/archive/refs/heads/main.tar.gz | tar xzf - -C /tmp
RUN /tmp/heroku-buildpack-gradle-main/bin/compile /app/structurizr-lite /var/build-cache /var/env