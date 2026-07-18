pragma Singleton

import Quickshell.Services.Pipewire
import Quickshell
import QtQuick
import qs.common


Singleton {
  id: root
  property PwNode defaultAudioSource: Pipewire.defaultAudioSource
  property PwNode defaultAudioSink: Pipewire.defaultAudioSink
  property var nodes: Pipewire.nodes

  PwObjectTracker {
    objects: [defaultAudioSource, defaultAudioSink]
  }

  property var audioProperties: defaultAudioSink?.audio
  property string soundSymbolName: "volume-4"
  onAudioPropertiesChanged: updateMaterialSymbol ()

  function updateMaterialSymbol() {
    soundSymbolName = audioProperties.muted? "volume-3" : audioProperties.volume? "volume" : "volume-3"
  }
  Connections {
    target: audioProperties ?? null
    
    function onMutedChanged() {
      soundSymbolName = audioProperties.muted? "volume-3" :
      !audioProperties.volume? "volume-3" : "volume"
    }
    function onVolumeChanged() {
      soundSymbolName = !audioProperties.volume? "volume-3" : "volume"
    }
  }
}
