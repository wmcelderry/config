#!/bin/bash

target=$1

i3-msg  'move scratchpad; [con_mark="'${target}'"] focus ; scratchpad show ;  floating disable ; mode "default"'
