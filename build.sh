#!/bin/bash
set -e

if [ -z $JAVA_HOME ]; then
    echo "JAVA_HOME needs to point to Java 11"
    exit 1
fi

PKG_TEMP=../i2p.i2p/pkg-temp/lib

echo "copying jars, renaming '-' to '.'"
rm -f *.jar
for j in $(find $PKG_TEMP -name '*.jar'); do
    moduleName=$(basename "${j%.*}")
    if [ ! -z $(grep $moduleName exclude.modules) ]; then
	echo "excluding $moduleName"
        continue
    fi
    target=$(echo $j | sed "s/-/\./g" | sed "s/.*\///g")
    cp $j $target
done

echo "generating module descriptors"
rm -rf module-info
mkdir module-info

for j in *.jar; do
    $JAVA_HOME/bin/jdeps --module-path .:$PKG_TEMP:lib-noop --generate-module-info module-info $j | grep -v split
done

echo "hacking module descriptors to exclude runtime modules"
for exclude in $(cat exclude.modules); do
    exclude=$(echo $exclude | sed "s/-/./g")
    find module-info -name module-info.java -exec sed -i "s/.*$exclude.*//g" '{}' \;
done

echo "overwriting with custom module infos (if any)"
cp -R custom-module-info/* module-info

echo "patching jars to create modules"
for j in *.jar; do
    moduleName=$(basename "${j%.*}")
    $JAVA_HOME/bin/javac -nowarn --module-path .:$PKG_TEMP:lib-noop --patch-module $moduleName=$j module-info/$moduleName/module-info.java
    $JAVA_HOME/bin/jar uf $j -C module-info/$moduleName module-info.class
done

echo "JLinking..."
rm -rf dist
if [ ! -z $JAVA_HOME_LINUX ]; then 
    echo "Linux"
    $JAVA_HOME/bin/jlink --module-path=$JAVA_HOME_LINUX/jmods:.:lib-noop --add-modules $(cat jlink.modules) --output dist/linux --strip-debug --compress 0 --no-header-files --no-man-pages
fi
if [ ! -z $JAVA_HOME_MAC ]; then
    echo "Mac"
    $JAVA_HOME/bin/jlink --module-path=$JAVA_HOME_MAC/jmods:.:lib-noop --add-modules $(cat jlink.modules) --output dist/mac --strip-debug --compress 0 --no-header-files --no-man-pages
fi
if [ ! -z $JAVA_HOME_WIN ]; then
    echo "Win"
    $JAVA_HOME/bin/jlink --module-path=$JAVA_HOME_WIN/jmods:.:lib-noop --add-modules $(cat jlink.modules) --output dist/win --strip-debug --compress 0 --no-header-files --no-man-pages
fi

echo "Done."

