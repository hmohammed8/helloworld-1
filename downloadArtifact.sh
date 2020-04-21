#!/usr/bin/env sh

repo="http://ec2-3-22-172-119.us-east-2.compute.amazonaws.com:8081"
groupId=$1
artifactId=$2
version=$3

# optional
type=$4
targetFile=$5
classifier=$6

groupIdUrl="${groupId//.//}"

versionTimestamped=`curl -v -u admin:admin "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml" | grep -m 1 \<value\> | sed -e 's/<value>\(.*\)<\/value>/\1/' | sed -e 's/ //g'`

if [  "" == "$versionTimestamped" ]; then
       echo "============= WARNING ================="
       echo "Unable to download artifact information, double-check that the url above exists in SonaType nexus as timestamp is null"
       echo "======================================="
       exit 255
   fi

curl -v -u admin:admin "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/${artifactId}-$versionTimestamped.${type}" -o ${targetFile}

#if [[ ${version} == *"SNAPSHOT"* ]]; then repo_type="snapshots"; else repo_type="releases"; fi

#if [[ $repo_type == "releases" ]]
 #then
  #echo wget -q --no-check-certificate "${repo}/repository/maven-releases/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${version}${classifier}.${type}" -O ${targetFile}
  #wget -q --no-check-certificate "${repo}/repository/maven-releases/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${version}${classifier}.${type}" -O ${targetFile}
 #else
  # echo wget -q -O- --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml"
  # versionTimestamped=$(wget -q -O- --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/maven-metadata.xml" | grep -m 1 \<value\> | sed -e 's/<value>\(.*\)<\/value>/\1/' | sed -e 's/ //g')
   
   #echo wget -q --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${versionTimestamped}${classifier}.${type}" -O ${targetFile}
  # wget -q --no-check-certificate "${repo}/repository/maven-snapshots/${groupIdUrl}/${artifactId}/${version}/${artifactId}-${versionTimestamped}${classifier}.${type}" -O ${targetFile}
   if [  ! -f "/var/jenkins_home/workspace/deploy/${targetFile}" ]; then
       echo "============= WARNING ================="
       echo "Unable to download artifact, double-check that the artifact classifier ${classifier} is correct in SonaType nexus"
       echo "======================================="
       exit 255
   fi
 fi
 
