#!/bin/bash

tag=$1

i3-msg '[con_mark="'${tag}'"] focus'
i3-msg mode "default"


