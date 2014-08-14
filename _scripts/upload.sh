#! /bin/bash

function getBranch() {
	echo ${TRAVIS_BRANCH//[/]/-}
}

function getFolder() {
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	if [ "${TRAVIS_BRANCH}" = "master" ]; then
		echo "public_html"
	else
		echo "dev_html/`getBranch`"
	fi
else
	echo "PR-${TRAVIS_PULL_REQUEST}-`getBranch`"
fi
}

if ["${TRAVIS_REPO_SLUG}" != "JamOORev" ]; then
	echo "Not uploading fork of website."
	exit 0
fi

curl --ftp-create-dirs -T _site/* -u $FTP_USER:$FTP_PASSWORD ftp://jamoorav.com/`getFolder`