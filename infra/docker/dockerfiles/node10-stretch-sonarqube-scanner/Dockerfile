FROM node:10.21.0-stretch

ENV SONAR_SCANNER_VERSION=4.3.0.2102
ENV PATH $PATH:/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin

RUN apt-get update \
    && apt-get install apt-utils -y \
    && apt-get install unzip -y \
    && apt-get install openjdk-8-jre -y \
    && wget -O sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && unzip sonar-scanner-cli.zip \
    && rm sonar-scanner-cli.zip \
    && sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner
