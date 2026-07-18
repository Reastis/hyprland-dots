import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
  id: root

  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Top //change to Top
  color: "transparent"

  required property var bar
  required property var exclusiveZone

  mask: Region { item: exclusiveZone }

  anchors {
    left: true
    right: true
    top: true
    bottom: true
  }

  Item {
    id: allBackgrounds
    anchors.fill: parent
    layer.enabled: true

    Shape {
      id: background
      anchors.fill: parent
      asynchronous: true
      preferredRendererType: Shape.CurveRenderer
      enabled:false

      BarBackground {
        id: barBackground
        mainWindow: root.screen
        bar: root.bar
      }
    }

    Item {
      id: shadowContainer
      anchors.fill: parent
      layer.enabled: true
      layer.effect: MultiEffect {
        source: background
        shadowEnabled: true
        shadowColor: "black"
        autoPaddingEnabled: false
      }
    }
  }
}
