#JETTY_VERSION=7.0.2.v20100331
#cd jetty-distribution-$JETTY_VERSION
cd jetty

nohup java -Xmx1024m -Xms1024m -jar start.jar &
