FROM play

RUN apt-get install -y build-essential

RUN apt-get install -y ruby-full

RUN gem update --system

RUN gem install compass

RUN apt-get install --yes nodejs

RUN apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get install --yes nodejs

RUN npm install -g grunt-cli --save-dev

RUN echo "{}" > package.json && npm install grunt --save-dev 

RUN apt-get install -y git

RUN cd /usr/local/share && \
        wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
        tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
        ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs && \
        ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
        ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

