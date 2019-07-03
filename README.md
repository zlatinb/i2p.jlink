# Scripts to build mini-JREs for the I2P Router

**This is work in progress**

Someone smarter than me can/should rewrite this to be a Makefile

1. Check out branch i2p.i2p as a sibling to this branch.
2. Run "ant pkg" there in order to build all the necessary jars.
3. Set JAVA_HOME to point to where you have jdk 11 installed
4. Set one or more of the following:
    JAVA_HOME_WIN - to where the windows jdk installation is
    JAVA_HOME_MAC - to where the osx jdk installation is
    JAVA_HOME_LINUX - to where the linux jdk installation is
4. run "build.sh"
5. If all goes well, the mini-jvms for each platform will be in the "dist" folder.

Note that compression is disabled because it is assumed that the final redistributable will be compressed using lzma or such.

In "lib-noop" you will find libraries necessary for the linking process to complete, but that are not necessary when running i2p.

In "custom-module-info" you can put module-info.java files that will override the ones that are automatically generated.  THIS IS A HORRIBLE HACK.  Hopefully moving to Jetty 9.4 will remove the need for it.

There are two files that you can edit:

* "exclude.modules" : these are jar files that are necessary only on runtime, or have external dependencies that are never really needed (such as ant, ecj)
* "jlink.modules" : the modules to be forcibly included by jlink.  Find out which by trial and error :)

