JENKINS_HOST=http://localhost:8080/

JOB_FILES=$(find jobs/ -name \*.xml)
for JOB_FILE in $JOB_FILES;
do
	FILENAME=$( echo $JOB_FILE | cut -d\/ -f2 )
	JOBNAME=$(echo $FILENAME| cut -d\. -f1)
	if [ ! -d ~/.hudson/jobs/$JOBNAME ]
	then
		curl -X POST -H"Content-Type:application/xml" "$JENKINS_HOST/createItem?name=$JOBNAME" --data-binary @$JOB_FILE
		#echo wget -X POST -H"Content-Type:application/xml" "$JENKINS_HOST/jenkins/createItem?name=$JOBNAME" -d @$JOB_FILE
	fi
#	if [ ! -f ~/.hudson/plugins/$FILENAME ]
#	then
#		cp deps/$FILENAME ~/.hudson/plugins
#	fi
done
