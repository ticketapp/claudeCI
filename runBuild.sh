#/bin/bash -e

git clone https://github.com/ticketapp/master

cd master; npm install

node_modules/bower/bin/bower install --allow-root --save

grunt build

sbt_output=$(sbt "test")
#Only TestAddressModel")

echo $sbt_output

if [[ $(echo $sbt_output | tail -c 80 | grep success | wc -l) > 0 ]]; then
        sbt dist;

        sshpass -p 9g2Myjdt scp -o StrictHostKeyChecking=no /master/server/target/universal/server-0.1-SNAPSHOT.zip root@51.254.122.113:/root/claude.zip;

        sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'unzip -o claude.zip;';

        sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'service supervisor restart; sleep 2';
else
        echo "Tests did not pass";
fi
