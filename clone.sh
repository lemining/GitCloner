#!/bin/bash

DEST=$2
SRC=$1

if [ -d "repo" ]; then
	echo "Removing existing repo folder..."
	rm -rf repo
fi

echo "Cloning the repo $1"
git clone --mirror $1 repo
cd repo

git remote set-url --push origin $2
git fetch -p origin
git show-ref | cut -d' ' -f2 | grep 'refs/pull/' | xargs -r -L1 git update-ref -d

echo "Pushing to $2"
git push --mirror
