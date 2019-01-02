#!/bin/bash

function listAudioOutputs()
{
	pacmd list-sinks | grep "index\|alsa.name\|alsa.card_name\|alsa.mixer_name"

}
function listAudioSources()
{
	pacmd list-sink-inputs | grep 'index\|sink:\|properties:\|name\|application.process.binary'
}


function moveAudioSource()
{
	echo "Select a sink-input to move:"
	listAudioSources
	read -p "Enter the sink-input index: " sink_input_idx

	eco "select a sink to move to:"
	listAudioOutputs
	read -p "Enter the sink index: " sink_idx

	pacmd move-sink-input ${sink_input_idx} ${sink_idx}
}


moveAudioSource
