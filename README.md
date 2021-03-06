## **Introduction**

The steps to be described here are targeted towards professionals who already work with Data but want to start on the journey of cloud and open source. Below steps, helps them to setup their laptop. Also, provides introduction to deploying databases using DevOps tools and writing serverless Rest APIs.

I believe it is mandatory for anyone working as developer in cloud space to have access to Linux terminal and Docker in their local environment. For Windows users, Linux is not available by default. So, I am covering the steps to setup Linux as an App on Windows 10.

## **Agenda**

- Installing Ubuntu on Windows 10
- Running Docker natively on WSL2
- Useful data tools in Linux
- VS Code for Data Engineering
- Build API Using serverless Code


## **Installing Ubuntu on Windows 10**

- #### **Step 1: Enable the Windows Subsystem for Linux**

    ``` PowerShell
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```
    > Restart machine

- #### **Step 2: Enable the Virtual Machine Platform**

    ```PowerShell
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

- #### **Step 3: Install Linux Kernel update package**
    1. Download the latest package from - [WSL2 Linux kernel update for x64 machines](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi).
    2. Run the downloaded package. Double-click to run – you will be prompted for elevated permissions, select ‘yes’ to approve this installation.

- #### Step 4: Set WSL2 as your default version
    ```PowerShell
    wsl -l -v
    wsl --set-default-version 2
    ```
- #### Step 5: Install your preferred Linux distribution
    From `Microsoft Store` install the Linux
- #### Step 6: Set default Distro
    ```
    wsl --set-default Ubuntu-20.04
    ```
## **Running Docker on WSL2**
    
1. Download & Install [Docker Desktop for Windows](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe)
2. In Docker, select `Settings > General` and check `User WSL 2 based engine`. Then restart Docker.
3. Go to Settings > Resources > WSL Integration, select `Enable intergration with my default WSL distro`.
4. Test docker is working using 
    ```bash
    docker run -d -p 80:80 docker/getting-started
    ```

## **Useful data tools in Linux**
1. Extract JSON to CSV - 
```bash
cat json/sample.json | jq -r '.CUSTOMER| map([.C_CUSTOMER_SK,.C_CUSTOMER_ID,.C_CURRENT_CDEMO_SK,.C_CURRENT_HDEMO_SK,.C_CURRENT_ADDR_SK,.C_FIRST_SHIPTO_DATE_SK,.C_FIRST_SALES_DATE_SK,.C_SALUTATION,.C_FIRST_NAME,.C_LAST_NAME,.C_PREFERRED_CUST_FLAG,.C_BIRTH_DAY,.C_BIRTH_MONTH,.C_BIRTH_YEAR,.C_BIRTH_COUNTRY,.C_LOGIN,.C_EMAIL_ADDRESS,.C_LAST_REVIEW_DATE]| join(", "))| join("\n")'
```
2. Word count using linux 
```bash
cat data/text/random.txt | sed 's/\s\+/\n/g' | sed 's/\.//' | sed '/^[[:space:]]*$/d' | sort | uniq -c | sort -rh | head
```
3. Word count using awk
```bash
awk '{for(i=1;i<=NF;i++) a[$i]++} END {for(k in a) print k,a[k]}' data/text/random.txt
```

## **Get VS Code**

> To continue following the session download & install [VS Code](https://code.visualstudio.com/Download)

## **Data Engineering Development using VS Code**
1. Using SQLTools Extension to query data Snowflake.
2. Install Liquibase using `liquibase/install.sh`
```bash
apt update
apt install -y openjdk-11-jdk
apt install -y unzip
wget "https://github.com/liquibase/liquibase/releases/download/v4.1.1/liquibase-4.1.1.zip"
wget "https://github.com/liquibase/liquibase-snowflake/releases/download/liquibase-snowflake-4.1.1/liquibase-snowflake-4.1.1.jar"
wget "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.12.9/snowflake-jdbc-3.12.9.jar"
unzip liquibase-4.1.1.zip -d /liquibase
mv liquibase-snowflake-4.1.1.jar /liquibase/lib/
mv snowflake-jdbc-3.12.9.jar /liquibase/lib/
```
3. Review sample sql in liquibase changelog format.
4. Create Database.
```sql
create database webinar;
```
5. Deploy tables to the database
```bash
liquibase --changeLogFile=samplechangelog.h2.sql --username=$username --password=$password --url="""jdbc:snowflake://$account.ap-southeast-2.snowflakecomputing.com/?db=webinar&schema=public""" update
```
6. Explore the created tables in Snowflake

## **Setting up a Serverless project**
1. Install AWS CLI
```
sudo apt install awscli 
```
1. [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) providing Access Key and Secrete Key.
```
aws configure
```
1. Install node & npm
```
sudo apt install nodejs
```
2. Install/Upgrade serverless framework
```
sudo npm install -g serverless
sudo npm update -g serverless
```
3. Create a python3 aws lambda project using templates under `serverless` folder.
```
sls create --template aws-python3
``` 
4. Update the code to generate an API.
5. Deploy stack
```
sls deploy
```
6. Test api using `Thunder client` VS Code extension