mvn clean deploy -Dsha1="-$(git rev-parse --short HEAD)" -Prelease,snapshot
