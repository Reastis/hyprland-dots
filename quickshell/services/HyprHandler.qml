pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root
  property var monitors: Hyprland.monitors.values
  property var workspaces: Hyprland.workspaces.values
  property var topLevels: Hyprland.toplevels.values

  //Workspace lists based on their type, to be changed to something that supports element addition
  //without the recreation of an entire property
  property list<HyprlandWorkspace> occupiedWorkspaces: workspaces.filter(workspace => workspace.toplevels.values.length > 0 && workspace.id == workspace.name)
  property list<HyprlandWorkspace> occupiedSpecialWorkspaces: workspaces.filter(workspace => workspace.toplevels.values.length > 0 &&  workspace.id != workspace.name)
  property list<HyprlandWorkspace> emptyWorkspaces: workspaces.filter(workspace => workspace.toplevels.values.length == 0 && workspace.id == workspace.name)
  property list<HyprlandWorkspace> emptySpecialWorkspaces: workspaces.filter(workspace => workspace.toplevels.values.length == 0 && workspace.id != workspace.name)
  
  property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
  property HyprlandToplevel activeToplevel: Hyprland.activeToplevel
  property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
  
  Connections {
    target: Hyprland
    function onRawEvent(event: HyprlandEvent) {
      // console.log(event.name)
      if (event.name.endsWith("v2")){
        return;
      }
    }
  }
}
