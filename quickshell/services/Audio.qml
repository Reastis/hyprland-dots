pragma Singleton

import Quickshell.Services.Pipewire
import Quickshell
import QtQuick



Singleton {
  id: root
  property PwNode defaultAudioSource: Pipewire.defaultAudioSource
  property PwNode defaultAudioSink: Pipewire.defaultAudioSink
  property var nodes: Pipewire.nodes

  PwObjectTracker {
    objects: [defaultAudioSource, defaultAudioSink]
  }

  property PwNodeAudio audioProperties: defaultAudioSink?.audio
  property string soundSymbolName: "volume_off"

  onDefaultAudioSourceChanged: console.log(defaultAudioSink.nickname)
  Connections {
    target: audioProperties ?? null
    
    function onMutedChanged() {
      soundSymbolName = audioProperties.muted ? "volume_off" :
      !audioProperties.volume ? "volume_off":"volume_up"
      root.soundSymbolName = soundSymbolName

    }
    function onVolumeChanged() {
      soundSymbolName = !audioProperties.volume? "volume_off" : "volume_up"
      root.soundSymbolName = soundSymbolName

    }
  }
}
