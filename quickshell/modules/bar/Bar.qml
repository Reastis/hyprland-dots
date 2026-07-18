import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.services
import qs.common

PanelWindow {
  id: root

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Top

  property var configSettings: Settings.config.barSettings
  property ShellScreen mainWindow: this.screen

  property string anchor: configSettings.anchor
  property string barOrientation: anchor === "top" || anchor === "bottom"? "horizontal" : "vertical"
  property bool barIsHorizontal: barOrientation === "horizontal"



  implicitHeight: barOrientation === "horizontal"? configSettings.barSizeHorizontal : mainWindow?.height
  implicitWidth: barOrientation === "vertical"? configSettings.barSizeVertical : mainWindow?.width

  anchors {
    left: anchor === "right"? false : true
    top: anchor === "bottom"? false : true
    right: anchor === "left"? false : true
    bottom: anchor === "top"? false : true
  }
  margins {
    top: barIsHorizontal? configSettings.marginsHorizontal : Appearance.margins.marginM
    bottom: barIsHorizontal? configSettings.marginsHorizontal : Appearance.margins.marginM
    left: !barIsHorizontal? configSettings.marginsVertical : Appearance.margins.marginM
    right: !barIsHorizontal? configSettings.marginsVertical : Appearance.margins.marginM
  }

  BarContent {
    isHorizontal: root.barIsHorizontal
    anchor: root.anchor
  }
}
