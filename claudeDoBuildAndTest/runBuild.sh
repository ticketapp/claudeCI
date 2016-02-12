#/bin/bash -e

sbt_output=$(sbt "testOnly TestTariffController")

echo $sbt_output

if [[ $(echo $sbt_output | grep [error] | wc -l) > 0 ]]; then
        echo "Tests did not pass";
else
        sbt dist;

        sshpass -p 9g2Myjdt scp -o StrictHostKeyChecking=no /master/server/target/universal/server-0.1-SNAPSHOT.zip root@51.254.122.113:/root/claude.zip;

        sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'unzip -o claude.zip;';

        sshpass -p "9g2Myjdt" ssh -o StrictHostKeyChecking=no -t root@51.254.122.113 'service supervisor restart; sleep 2';
fi

