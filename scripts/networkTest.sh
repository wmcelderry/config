#!/bin/bash

ONLINE_SERVER=8.8.8.8
GW=

function getDefaultGW()
{
	ip route ls | sed -n '/default/s/.*via \([^ ]\+\).*/\1/p'
}



GW=$(getDefaultGW)

echo contacting default gateway: ${GW} - $(ping -c 1 ${GW} >&/dev/null  && echo success || echo failed)
echo contacting online server: $(ping -c 1 ${ONLINE_SERVER} >&/dev/null  && echo success || echo failed)
echo dns test: $(nslookup google.com >&/dev/null&& echo success || echo failed)



