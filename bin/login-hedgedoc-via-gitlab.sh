#!/usr/bin/env bash

username=${1}; shift
password=${1}; shift

if [ -z "$username" ]; then
    echo "Please pass the username and password. "
    exit -1
fi
if [ -z "$password" ]; then
    echo "Please pass the password. "
    exit -1
fi

export HEDGEDOC_SERVER=${HEDGEDOC_SERVER}
if [ -z "$HEDGEDOC_SERVER" ]; then
    echo "Please setup the HEDGEDOC_SERVER. " 1>&2
    exit -1
fi
cookie=${HEDGEDOC_COOKIES_FILE}
if [ -z "$HEDGEDOC_COOKIES_FILE" ]; then
    echo "Please setup the HEDGEDOC_COOKIES_FILE. " 1>&2
    exit -1
fi

hedgedochost=$(echo $HEDGEDOC_SERVER | perl -ne 'print "$1" if /(https?:\/\/[^:^\/\\s]+)\//')

function step1() {
    echo
    echo "Step 1:"
    local headers
    headers=$(curl "${HEDGEDOC_SERVER}/auth/gitlab" \
                   -H "authority: ${hedgedochost}" \
                   -H 'pragma: no-cache' \
                   -H 'cache-control: no-cache' \
                   -H 'upgrade-insecure-requests: 1' \
                   -H "referer: ${HEDGEDOC_SERVER}/" \
                   -b $cookie -c $cookie --insecure \
                   -s -o /dev/null \
                   -D - | grep location | cut -c11-)
    export GITLAB_CALLBACK_LOCATION=${headers//[$'\t\r\n']} # need to remove CRLF
    echo "GITLAB_CALLBACK_LOCATION is $GITLAB_CALLBACK_LOCATION"
    # get the host
    export GITLAB_HOST=$(echo $GITLAB_CALLBACK_LOCATION | perl -ne 'print "$1" if /(https?:\/\/[^:^\/\\s]+)\//')
    echo "GITLAB_HOST is $GITLAB_HOST" # with http/https prefix
}

function step2() {
    echo
    echo "Step 2:"

    local body
    body=$(curl $GITLAB_CALLBACK_LOCATION \
                -H 'Connection: keep-alive' \
                -H 'Pragma: no-cache' \
                -H 'Cache-Control: no-cache' \
                -H 'Upgrade-Insecure-Requests: 1' \
                -b $cookie -c $cookie \
                --insecure)
    export GITLAB_LOGIN_LOCATION=$(echo "$body" | perl -ne 'print "$1" if /.*?a href="(.+?)"/')
    echo "GITLAB_LOGIN_LOCATION is $GITLAB_LOGIN_LOCATION"
}

function step3() {
    echo
    echo "Step 3:"
    local body
    local gitlab_token
    local token

    # https://stackoverflow.com/questions/47948887/login-to-gitlab-with-username-and-password-using-curl
    body=$(curl $GITLAB_LOGIN_LOCATION \
                -H 'Connection: keep-alive' \
                -H 'Pragma: no-cache' \
                -H 'Cache-Control: no-cache' \
                -H 'Upgrade-Insecure-Requests: 1' \
                -b $cookie -c $cookie --insecure)
    gitlab_token=$( echo "$body" | grep 'authenticity_token' | perl -ne 'print "$1\n" if /.*?authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p )
    echo
    echo "GET TOKEN"
    echo $gitlab_token
    token=
    if [ -n "$gitlab_token" ]; then
        token="--data-urlencode authenticity_token=${gitlab_token}"
    fi
    local gitlab_login_real=$( echo "$body" | grep 'form' | perl -ne 'print "$1\n" if /.*?action="(.+?)"[[:blank:]]/' | sed -n 1p )

    export GITLAB_LOGIN_REAL_LOCATION="${GITLAB_HOST}${gitlab_login_real}"
    echo "GITLAB_LOGIN_REAL_LOCATION is $GITLAB_LOGIN_REAL_LOCATION" # with http/https prefix

   
    local header
    header=$(curl $GITLAB_LOGIN_REAL_LOCATION \
                  -H 'Connection: keep-alive' \
                  -H 'Pragma: no-cache' \
                  -H 'Cache-Control: no-cache' \
                  -H 'Upgrade-Insecure-Requests: 1' \
                  -H "Origin: ${GITLAB_HOST}" \
                  -H 'Content-Type: application/x-www-form-urlencoded' \
                  -H "Referer: ${GITLAB_LOGIN_LOCATION}" \
                  -H 'Accept-Language: en' \
                  --data "grant_type=password&username=${username}&password=${password}" ${token} \
                  -b $cookie -c $cookie \
                  --insecure -D - | grep -i location | cut -c11-)
    header=${header//[$'\t\r\n']}
    if [ "$header" = "$GITLAB_CALLBACK_LOCATION" ]; then
        echo "same callback $header"
    else
        echo "Mismatch callback: " 1>&2
        echo "header: $header " 1>&2
        echo "callback: $GITLAB_CALLBACK_LOCATION" 1>&2
        exit -1
    fi

}

function step4-5() {
    echo
    echo "Step 4:"
    local body
    local link
    body=$(curl $GITLAB_CALLBACK_LOCATION \
                -H 'Connection: keep-alive' \
                -H 'Pragma: no-cache' \
                -H 'Cache-Control: no-cache' \
                -H 'Upgrade-Insecure-Requests: 1' \
                -b $cookie -c $cookie \
                --insecure)
    echo $body
    link=$(echo $body | grep window.location | perl -ne 'print "$1\n" if /.*?window.location= "(.+?)";/')
    # if not found, try to parse again
    if [ -z "$link" ]; then
        link=$(echo $body | grep window.location | perl -ne 'print "$1\n" if /.*?let redirectUri = "(.+?)";/')
    fi
    echo "WILL REDIRECT TO $link "



    echo
    echo "Step 5:"
    curl $link \
         -H "authority: ${hedgedochost}" \
         -H 'pragma: no-cache' \
         -H 'cache-control: no-cache' \
         -b $cookie -c $cookie \
         --compressed --insecure

    echo
    echo "DONE"

}

# gitlab
# check

if [ ! -f "$cookie" ]; then
    step1
    step2
    step3
    step4-5
fi

