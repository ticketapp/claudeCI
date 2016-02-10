FROM build

RUN git clone https://github.com/ticketapp/master

RUN cd master; npm install

RUN cd master; node_modules/bower/bin/bower install --allow-root --save

RUN cd master; grunt build

RUN cd /usr/local/share && \
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
	tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs && \
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
