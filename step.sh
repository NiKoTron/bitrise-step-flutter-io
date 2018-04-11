#!/bin/bash
set -ex

FLUTTER_ANDROID_PROJECT="`pwd`/android/"
if [[ -d "$FLUTTER_ANDROID_PROJECT" ]]
then
    if [[ -d "`pwd`/flutter/" ]]
    then
        echo 'flutter already cloned'
        export PATH=`pwd`/flutter/bin:$PATH
        envman add --key PATH --value $PATH
        
        flutter upgrade
    else
        git clone https://github.com/flutter/flutter.git -b ${flutter_branch}
        export PATH=`pwd`/flutter/bin:$PATH
        envman add --key PATH --value $PATH
    fi
    
    flutter doctor

    export FLUTTER_SDK_PROP=flutter.sdk=`pwd`/flutter
                        
    echo $FLUTTER_SDK_PROP >> `pwd`/android/local.properties
    
    echo ${debug_build}
    
    if [[ ${debug_build} = "yes" ]]
    then
        echo 'flutter.buildMode=debug' >> `pwd`/android/local.properties
    fi
    exit 0
else
	echo "Flutter.io android project not found to configure it."
	exit 1
fi
