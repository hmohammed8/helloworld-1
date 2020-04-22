#!/usr/bin/env sh

repo="http://ec2-18-224-182-237.us-east-2.compute.amazonaws.com:8081"
groupId=$1
artifactId=$2
version=$3
# optional
type=$4
targetFile=$5
classifier=$6
groupIdUrl="${groupId//.//}"
count=`echo ${version}|grep SNAPSHOT|wc -l`
if [ $count -gt 0 ] 
then
mavenrespos=maven-snapshots
else
mavenrespos=maven-releases
fi
echo $mavenrespos
versionTimestamped=`curl -v -u admin:admin "${repo}/repository/$mavenrespos/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml" | grep -m 1 \<value\> | sed -e 's/<value>\(.*\)<\/value>/\1/' | sed -e 's/ //g'`
if [  "" == "$versionTimestamped" ]; then
       echo "============= WARNING ================="
       echo "Unable to download artifact information, double-check that the url above exists in SonaType nexus as timestamp is null"
       echo "======================================="
       exit 255
   fi
curl -v -u admin:admin "${repo}/repository/$mavenrespos/${groupIdUrl}/${artifactId}/${version}/${artifactId}-$versionTimestamped.${type}" -o /tmp/${targetFile}

   if [  ! -f "/tmp/${targetFile}" ]; then
       echo "============= WARNING ================="
       echo "Unable to download artifact, double-check that the artifact classifier ${classifier} is correct in SonaType nexus"
       echo "======================================="
       exit 255
   fi
   
   docker service create --name helloworld --detach
 
 
