#!/bin/sh

#  CleanFrameworkHeaders.sh
#  SCToolkit
#
#  Created by Vincent Wang on 12/1/11.
#  Copyright (c) 2011 Vincent S. Wang. All rights reserved.

# To remove the Frameworks' headers,
# run this script file in the other projects' build phase which are using SCToolkit or other frameworks.


echo "Start cleaning up Framework headers"
echo "build path ${TARGET_BUILD_DIR}"
cd "${TARGET_BUILD_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks"
rm -rf */Headers 
rm -rf */Versions/*/Headers 
rm -rf */Versions/*/PrivateHeaders 
rm -rf */Versions/*/Resources/*/Contents/Headers