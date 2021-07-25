#!bin/bash

apt update
apt install -y openjdk-11-jdk
apt install -y unzip
wget "https://github.com/liquibase/liquibase/releases/download/v4.1.1/liquibase-4.1.1.zip"
wget "https://github.com/liquibase/liquibase-snowflake/releases/download/liquibase-snowflake-4.1.1/liquibase-snowflake-4.1.1.jar"
wget "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.12.9/snowflake-jdbc-3.12.9.jar"
unzip liquibase-4.1.1.zip -d /liquibase
mv liquibase-snowflake-4.1.1.jar /liquibase/lib/
mv snowflake-jdbc-3.12.9.jar /liquibase/lib/
export PATH=/liquibase:$PATH