#!/bin/bash
set -e

echo "Installing node_modules"
echo "**************************"

npm install

echo "Building app"
echo "**************************"

npm run build

echo "Remove deploy script from build"
echo "**************************"

rm ./_book/deploy.sh

echo "Committing build to git"
echo "**************************"

git add ./_book

git commit -m "automated build of gitbook for deployment"

current_branch=$(git rev-parse --abbrev-ref HEAD)

echo "Pushing changes to $current_branch on GitHub"
echo "**************************"

git push origin $current_branch
