#sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"
#sudo apt-get update

# Upgrade existing packages
#sudo apt-get -y upgrade

# Mark the the "Distributor License for Java" as accepted
#echo sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true | sudo /usr/bin/debconf-set-selections

# Install the JDK and required x86 libraries
#sudo apt-get install -y sun-java6-jdk ia32-libs

# Retrieve and extract Android SDK
wget http://dl.google.com/android/android-sdk_r12-linux_x86.tgz
tar -zxf android-sdk_r09-linux_x86.tgz
mv android-sdk-linux_x86/ ~/android

# Export environment variables and put Android tools on the path
export ANDROID_HOME=/home/ubuntu/android
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Download and install the SDK tools and all available Android platforms
~/android/tools/android update sdk -u -t platform,platform-tool,tool

# Done!
