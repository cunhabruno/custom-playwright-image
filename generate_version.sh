#!/bin/bash

VERSION_REGEX="v[0-9]+\.[0-9]+(\.+[0-9])*\-(focal|bionic)"
if [[ "$1" != "--playwright_version"* ]]
then
  >&2 echo "Required argument --playwright_version=PLAYWRIGHT_VERSION"
  exit 1
fi

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        --playwright_version)
            if [[ $VALUE =~ $VERSION_REGEX ]]
            then
              SELECTED_PLAYWRIGHT_VERSION=$VALUE
            else
              >&2 echo "Wrong version format"
              exit 1
            fi
            ;;
        *)
            >&2 echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

CURTAG=`git describe --match "$SELECTED_PLAYWRIGHT_VERSION*"`;

IFS='-' read -a vers <<< "$CURTAG"
CURRENT_PLAYWRIGHT_VERSION="${vers[0]}-${vers[1]}"
AVST_VERSION=${vers[2]}
((AVST_VERSION+=1))

NEWTAG="$SELECTED_PLAYWRIGHT_VERSION-$AVST_VERSION"
echo "$NEWTAG";
