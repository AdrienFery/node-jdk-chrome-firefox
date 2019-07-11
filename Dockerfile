FROM buildpack-deps:stretch

# Install Java 8


RUN set -x \
    && apt-get update \
    && apt-get install -y \
        locales

ENV LANG C.UTF-8
RUN locale-gen $LANG

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        ca-certificates-java \
        openjdk-8-jre-headless \
        openjdk-8-jre \
        openjdk-8-jdk-headless \
        openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install maven
ENV MAVEN_VERSION 3.3.9

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

VOLUME /root/.m2

# Install node 8
RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update \
    && apt-get install -y \
        nodejs \
    && npm install -g npm@latest

# Make 'node' available
RUN set -x \
    && touch ~/.bashrc \
    && echo 'alias nodejs=node' > ~/.bashrc

# Install yarn 1.7+

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        yarn

# Install Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        google-chrome-stable

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome

# Install firefox

RUN echo "deb http://ftp.hr.debian.org/debian sid main contrib non-free" > /etc/apt/sources.list.d/firefox.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        pkg-mozilla-archive-keyring


RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
    && apt-get install -y \
        firefox

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

ENV FIREFOX_BIN /usr/bin/firefox

# This is needed for PhantomJS
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        bzip2 \
        zip \
    && rm -rf /var/lib/apt/lists/*

# RUN node -v
# RUN npm -v
# RUN yarn -v
# RUN java -version
# RUN mvn -v
# RUN apt-cache policy firefox-esr | grep Installed | sed -e "s/Installed/Firefox/"
# RUN apt-cache policy google-chrome-stable | grep Installed | sed -e "s/Installed/Chrome/"
