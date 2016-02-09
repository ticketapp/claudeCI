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
