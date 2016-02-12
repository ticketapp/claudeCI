FROM build

RUN git clone https://github.com/ticketapp/master

RUN cd master; npm install

RUN cd master; node_modules/bower/bin/bower install --allow-root --save

RUN cd master; grunt build

RUN echo 'scalacOptions ++= Seq("-Xmax-classfile-name","82")' > ~/.sbt/0.13/local.sbt

RUN apt-get install -y sshpass

ADD runBuild.sh /master

RUN cd /master; chmod +x ./runBuild.sh

WORKDIR /master

#CMD exitCode=$(sbt "testOnly TestAddressModel" | sed -e '$!d' | awk '{print $1}'); if [ exitCode == "[error]" ]; then echo "a"; else echo "b"; fi

#CMD sbt test; sshpass -p 9g2Myjdt scp -o StrictHostKeyChecking=no target/universal/claude-0.001.zip root@51.254.122.113:/root/claude.zip

#RUN cd master; sbt test
