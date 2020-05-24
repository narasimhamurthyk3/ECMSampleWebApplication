#!/bin/bash
echo "Changing DOCKER TAG "
sed "s/tagVersion/$1/g" deployment-template.yml > deployment.yml
