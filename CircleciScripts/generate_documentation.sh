#!/bin/bash

# Creates Swift and Objective-C documentation by module, packages all modules
# into a ZIP file, and leaves the result in the ${DOCS_TMP} directory, which is
# safe to leave while checking out the gh-pages directory

set -x

SDK_VERSION="2.31.1"

GITHUB_DOC_ROOT=https://aws-amplify.github.io
GITHUB_SOURCE_ROOT=https://github.com/aws-amplify/aws-sdk-ios

if [[ -z $SOURCE_ROOT ]] ; then
  SOURCE_ROOT=$( pwd )
fi

DOCS_TMP=${SOURCE_ROOT}/docs_tmp

# remove everything generated by this script
function cleanup {
  rm -rf ${DOCS_TMP}
}

cleanup

if [[ $1 == "clean" ]] ; then
	exit 0
fi

cd "$SOURCE_ROOT"

mkdir -p ${DOCS_TMP}

test_device_id=$( bash ${SOURCE_ROOT}/CircleciScripts/get_circleci_test_device_id.sh )
exitValue=$?
if [[ $exitValue -ne  0 ]] || [[ -z $test_device_id ]] ; then
  echo "Error getting test device ID"
  exit 1
fi
destination="id=${test_device_id}"

# Generate Swift documentation--right now only for AWSMobileClient. Not
# technically necessary to do a `find` here, but it will generate an empty list
# if it can't find AWSMobileClient
SWIFT_SDK_LIST=$(find ${SOURCE_ROOT}/AWSAuthSDK/Sources -type d -maxdepth 1 -mindepth 1 -name "AWS*" \
  -name "AWSMobileClient" \
  | sort
)

for sdkRoot in $SWIFT_SDK_LIST ; do
  sdkName=$( basename "$sdkRoot" )
  bundle exec jazzy \
    --clean \
    --author "Amazon Web Services, Inc." \
    --author_url ${GITHUB_DOC_ROOT} \
    --github_url ${GITHUB_SOURCE_ROOT} \
    --module-version $SDK_VERSION \
    --root-url ${GITHUB_DOC_ROOT}/aws-sdk-ios/docs/reference/ \
    --output ${DOCS_TMP}/${sdkName} \
    --build-tool-arguments -project,${SOURCE_ROOT}/AWSAuthSDK/AWSAuthSDK.xcodeproj,-scheme,${sdkName},-destination,"${destination}" \
    --sdk iphonesimulator \
    --exclude=${SOURCE_ROOT}/AWSAuthSDK/Sources/AWSMobileClient/AWSUserPoolOperationsHandler.swift \
    --module ${sdkName} \
    --min-acl public

  exitValue=$?
  if [[ $exitValue -ne 0 ]] ; then
    echo "Error generating docs for ${sdkName}" >&2
    exit $exitValue
  fi

done

# Generate Objective-C documentation
OBJC_SDK_LIST=$(find $SOURCE_ROOT ${SOURCE_ROOT}/AWSAuthSDK/Sources -type d -maxdepth 1 -mindepth 1 -name "AWS*" \
  -not -name ".*" \
  -not -name "*.xcodeproj" \
  -not -name "*Test*" \
  -not -name "AWSAuthSDK" \
  -not -name "AWSMobileClient" \
  -not -name "AWSMobileClientXCF" \
  -not -name "AWSLocationXCF" \
  | sort
)

for sdkRoot in $OBJC_SDK_LIST ; do
  sdkName=$( basename "$sdkRoot" )
  bundle exec jazzy \
    --objc \
    --clean \
    --author "Amazon Web Services, Inc." \
    --author_url ${GITHUB_DOC_ROOT} \
    --github_url ${GITHUB_SOURCE_ROOT} \
    --module-version $SDK_VERSION \
    --root-url ${GITHUB_DOC_ROOT}/aws-sdk-ios/docs/reference/ \
    --output ${DOCS_TMP}/${sdkName} \
    --sdk iphonesimulator \
    --umbrella-header ${sdkRoot}/${sdkName}.h \
    --module ${sdkName} \
    --framework-root ${sdkRoot}

  exitValue=$?
  if [[ $exitValue -ne 0 ]] ; then
    echo "Error generating docs for ${sdkName}" >&2
    exit $exitValue
  fi

done

# Generate index
DOC_INDEX=${DOCS_TMP}/index.html
cat <<EOF > ${DOC_INDEX}
<html>
<body>
<h1>AWS Mobile SDK for iOS v${SDK_VERSION}</h1>
<p><a href="${GITHUB_SOURCE_ROOT}">View source on GitHub</a></p>
<section>
List of SDKs:
<ul>
EOF

for sdkRoot in $( echo $SWIFT_SDK_LIST ) ; do
  sdkName=$( basename "$sdkRoot" )
  echo "<li><a href=\"${sdkName}/index.html\">${sdkName}</a></li>" >> ${DOC_INDEX}
done

for sdkRoot in $( echo $OBJC_SDK_LIST ) ; do
  sdkName=$( basename "$sdkRoot" )
  echo "<li><a href=\"${sdkName}/index.html\">${sdkName}</a></li>" >> ${DOC_INDEX}
done

cat <<EOF >> ${DOC_INDEX}
</ul>
</section>
</body>
</html>
EOF

set +x
