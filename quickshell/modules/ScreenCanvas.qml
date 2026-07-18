import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.backgrounds
Variants {
  model: Quickshell.screens
  delegate: Item {
    id: canvasTreeRoot

    required property ShellScreen modelData

    Loader {
      id: exclusiveZonesLoader
      asynchronous: false
      sourceComponent: ExclusiveZones {}
    }

    Loader {
      id: barContentLoader
      asynchronous: false
      sourceComponent: Bar {}
    }

    Loader {
      id: unifiedBackgroundLoader
      asynchronous: false
      sourceComponent: UnifiedBackground {
        exclusiveZone: exclusiveZonesLoader.item
        bar: barContentLoader.item
      }
    }
  }
}
