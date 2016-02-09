FROM build

RUN git clone https://github.com/ticketapp/master

RUN cd master; npm install

RUN cd master; node_modules/bower/bin/bower install --allow-root --save

RUN cd master; grunt build
