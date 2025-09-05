pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root
  property var monitors: Hyprland.monitors
  property var workspaces: Hyprland.workspaces
  property var topLevels: Hyprland.toplevels

  property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
  property HyprlandToplevel activeTopLevel: Hyprland.activeTopLevel
  property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
  
  Connections {
    target: Hyprland
    function onRawEvent(event: HyprlandEvent) {
      if (event.name.endsWith("v2")){
        return
      }
      const name = event.name 
    }
  }
}
