#!/bin/bash
set -ex

FLUTTER_ANDROID_PROJECT=`pwd`/android
if [[ -d "$FLUTTER_ANDROID_PROJECT" ]]
then
    export FLUTTER_HOME=`pwd`/flutter
    envman add --key FLUTTER_HOME --value $FLUTTER_HOME
    envman run bash -c 'echo "fluter home env is: $FLUTTER_HOME"'
        
    export PATH=$FLUTTER_HOME/bin:$PATH
    envman add --key PATH --value $PATH
    
    if [[ -d $FLUTTER_HOME ]]
    then
        echo 'flutter already cloned'
        flutter upgrade
    else
        git clone https://github.com/flutter/flutter.git -b ${flutter_branch}
    fi
    
    flutter doctor

    export FLUTTER_SDK_PROP=flutter.sdk=$FLUTTER_HOME
                        
    echo $FLUTTER_SDK_PROP >> $FLUTTER_ANDROID_PROJECT/local.properties
    
    echo ${debug_build}
    
    if [[ ${debug_build} = "yes" ]]
    then
        echo 'flutter.buildMode=debug' >> $FLUTTER_ANDROID_PROJECT/local.properties
    fi
    exit 0
else
	echo "Flutter.io android project not found to configure it."
	exit 1
fi
