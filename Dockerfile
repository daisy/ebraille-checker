# build the ebraille-checker.jar file
FROM maven:slim AS builder

WORKDIR /app
COPY . .
RUN mvn clean install

# prepare runner for ebraille-checker.jar execution
FROM openjdk:slim

WORKDIR /app
COPY --from=builder /app .
RUN echo '#!/bin/bash\n java -jar /app/target/ebraille-checker.jar "${@:1}"\n' > entrypoint.sh
RUN chmod +x entrypoint.sh

ENV DATA_PATH=/data
WORKDIR ${DATA_PATH}
VOLUME ${DATA_PATH}

ENTRYPOINT [ "/app/entrypoint.sh" ]
