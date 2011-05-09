JETTY_VERSION=7.0.2.v20100331

JETTY_URL=http://download.eclipse.org/jetty/$JETTY_VERSION/dist/jetty-distribution-$JETTY_VERSION.tar.gz
JENKINS_REPOSOTORY=http://mirrors.jenkins-ci.org
JENKINS_URL=$JENKINS_REPOSOTORY/war/latest/jenkins.war


#make dep dir if it dosent exists
[ ! -d deps ] && mkdir deps

#download jetty
[ ! -f deps/jetty-distribution-$JETTY_VERSION.tar.gz ] && wget $JETTY_URL -O deps/jetty-distribution-$JETTY_VERSION.tar.gz

#download jenkins
[ ! -f deps/jenkins.war ] && wget $JENKINS_URL -O deps/jenkins.war

#download the plugins
PLUGINS=$(find plugins/)
for PLUGIN in $PLUGINS;
do
	if [ -f $PLUGIN ]
	then
		PLUGIN_NAME=$(echo $PLUGIN | cut -d\/ -f2)
		if [ ! -f deps/$PLUGIN_NAME.hpi ]
		then 
			PLUGIN_VERSION=$(cat $PLUGIN)
			wget -nv $JENKINS_REPOSOTORY/plugins/$PLUGIN_NAME/$PLUGIN_VERSION/$PLUGIN_NAME.hpi -O deps/$PLUGIN_NAME.hpi
		fi
	fi
done

#install stuff
[ ! -d ~/.hudson/plugins ] && mkdir -p ~/.hudson/plugins

PLUGIN_FILES=$(find deps -name \*.hpi)
for PLUGIN_FILE in $PLUGIN_FILES;
do
	FILENAME=$( echo $PLUGIN_FILE | cut -d\/ -f2 )
	if [ ! -f ~/.hudson/plugins/$FILENAME ]
	then
		cp deps/$FILENAME ~/.hudson/plugins
	fi
done

#config files
CONFIG_FILES=$(find config)
for CONFIG_FILE in $CONFIG_FILES;
do
	FILENAME=$( echo $CONFIG_FILE | cut -d\/ -f2 )
	if [ ! -f ~/.hudson/$FILENAME ]
	then
		echo config/$FILENAME ~/.hudson
	fi
done
#TODO: remove this after fix the code above
cp config/* ~/.hudson/

tar xfz deps/jetty-distribution-$JETTY_VERSION.tar.gz

rm -rf jetty-distribution-$JETTY_VERSION/contexts/*
cp jenkins.xml jetty-distribution-$JETTY_VERSION/contexts/
cp deps/jenkins.war jetty-distribution-$JETTY_VERSION/webapps/

mv jetty-distribution-$JETTY_VERSION jetty
