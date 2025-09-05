import qs.services
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.modules.widgets
Item {
  id: workspacesRoot 
  property real padding: 10
  implicitWidth: workspacesList.implicitWidth + padding
  property var workspaces: HyprHandler.workspaces
  property var focusedWorkspace: HyprHandler.focusedWorkspace 
  property real wsButtonWidth: 25
  property real wsButtonHeight: 25

  Rectangle {
    x: padding/2 + wsButtonWidth*(focusedWorkspace.id-1)
    z:1
    id: activeWorkspaceBg
    anchors {
      verticalCenter:parent.verticalCenter
    }
    color:"blue"
    implicitWidth:wsButtonWidth
    implicitHeight:wsButtonHeight
    radius:implicitWidth/2
  }
  RowLayout {
    z:2
    id: workspacesList
    anchors.centerIn: parent
    implicitHeight: 30
    spacing: 0 
    Repeater {
      model: 10

      Button {
        id: workspace
        implicitWidth:workspacesRoot.wsButtonWidth
        implicitHeight:workspacesRoot.wsButtonHeight
        background: Item {
          id: workspaceBackground
          Rectangle {
            anchors.centerIn: parent
            width: 6
            height: width
            radius: width/2
            opacity: 0.7
            color: "white"
          }
        }
      }
    }
  }
}
