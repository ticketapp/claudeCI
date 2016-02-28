#/bin/bash -e

git clone https://github.com/ticketapp/master

cd master; npm install

if [ $? != 0 ] ; then
	echo -e "\e[31mTests did not pass because of npm install\e[0m";

        curl -d '{"color":"red","message":"Build failed because of npm install (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9

	exit 1;
fi

node_modules/bower/bin/bower install --allow-root --save

if [ $? != 0 ] ; then
        echo -e "\e[31mTests did not pass because of bower install\e[0m";

        curl -d '{"color":"red","message":"Build failed because of bower install (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9

        exit 1;
fi

node_modules/bower/bin/bower update --allow-root --save

if [ $? != 0 ] ; then
        echo -e "\e[31mTests did not pass because of bower update\e[0m";

        curl -d '{"color":"red","message":"Build failed because of bower update (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9

        exit 1;
fi

grunt build

if [ $? == 0 ] ; then 

	sbt_output=$(sbt "test")
	#Only TestAddressModel")

	echo $sbt_output

	if [[ $(echo $sbt_output | tail -c 80 | grep success | wc -l) > 0 ]]; then
		echo -e "\e[32mTests pass\e[0m";

        	sbt dist;

        	sshpass -p 9g2Myjdt scp -o StrictHostKeyChecking=no /master/server/target/universal/server-0.1-SNAPSHOT.zip root@51.254.122.113:/root/claude.zip;

        	sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'unzip -o claude.zip;';

        	sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'service supervisor restart; sleep 5';

		echo -e "\e[32mEverything worked well\e[0m";
	
		curl -d '{"color":"green","message":"Build success (yey)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9

		curl https://claude.wtf
	else
		echo -e "\e[31mTests did not pass\e[0m";

		curl -d '{"color":"red","message":"Build failed because of the sbt tests (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9	
	fi

else
	 echo -e "\e[31mTests did not pass because of the Grunt build\e[0m";

         curl -d '{"color":"red","message":"Build failed because of the Grunt build (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9
fi

