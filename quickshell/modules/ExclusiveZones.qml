import Quickshell
import qs.services
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland


Item {
  id: root


  property var barSettings: Settings.config.barSettings
  property string anchor: barSettings.anchor
  property string mode: barSettings.mode
  property real borderThickness: mode == "framed"? barSettings.borderThickness : 0
  property real frameMargin: barSettings.frameMargin
  property real barSizeHorizontal: barSettings.barSizeHorizontal
  property real barSizeVertical: barSettings.barSizeVertical

  component ExclusiveZone: PanelWindow {
    WlrLayershell.layer: WlrLayer.Background
    color: "transparent"
  }

  ExclusiveZone {
    id: topZone
    anchors.top: true
    implicitHeight: anchor === "top"? barSizeHorizontal + frameMargin + 2*barSettings.marginsHorizontal : borderThickness + frameMargin
  }
  ExclusiveZone {
    id: bottomZone
    anchors.bottom: true
    exclusiveZone: anchor === "bottom"? barSizeHorizontal + frameMargin + 2*barSettings.marginsHorizontal : borderThickness + frameMargin
  }
  ExclusiveZone {
    id: rightZone
    anchors.right: true
    exclusiveZone: anchor === "right"? barSizeVertical + frameMargin + 2*barSettings.marginsVertical : borderThickness + frameMargin
  }
  ExclusiveZone {
    id: leftZone
    anchors.left: true
    exclusiveZone: anchor === "left"? barSizeVertical + frameMargin + 2*barSettings.marginsVertical : borderThickness + frameMargin
  }
}
