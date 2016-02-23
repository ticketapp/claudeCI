#/bin/bash -e

git clone https://github.com/ticketapp/master

cd master; npm install

node_modules/bower/bin/bower install --allow-root --save

node_modules/bower/bin/bower update --allow-root --save

grunt build

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

else
	echo -e "\e[31mTests did not pass\e[0m";

	curl -d '{"color":"red","message":"Build failed (areyoukiddingme)","notify":true,"message_format":"text"}' -H 'Content-Type: application/json' https://siloprod.hipchat.com/v2/room/1512094/notification?auth_token=LB0K8CkgPFy3Zq3nugKVwAnhTzr8dEYEhgullZs9	
fi

