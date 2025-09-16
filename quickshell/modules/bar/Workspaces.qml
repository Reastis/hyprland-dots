import qs.services
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.modules.widgets
Item {
  id: root
  property real padding: 10
  implicitWidth: workspacesLayout.implicitWidth + padding
  property var workspaces: HyprHandler.workspaces
  property list<string> workspacesShown: Array.from({ length:10}, (_, i) => `${i+1}`)
  property var focusedWorkspace: HyprHandler.focusedWorkspace 
  property real wsButtonWidth: 24
  property real wsButtonHeight: 24
  property real contentMargin: 6
  Connections {
    target: workspaces
    function onObjectInsertedPost(addedWorkspace, index){
      if (!workspacesShown.includes(addedWorkspace.name)){
      } 
    }
  }
  Rectangle { 
    z:1
    id: activeWorkspaceBg
    x: (padding+contentMargin)/2 + wsButtonWidth*(focusedWorkspace?.id-1)
    anchors.verticalCenter:parent.verticalCenter
    color:"#EA5B6F"
    implicitWidth:wsButtonWidth-contentMargin
    implicitHeight:wsButtonHeight-contentMargin
    radius:implicitWidth/2
    Behavior on x {
      NumberAnimation {
        duration: 200
        easing.type: Easing.OutSine
      }
    }
  }
  RowLayout {
    z:2
    id: workspacesLayout
    anchors.centerIn: parent
    implicitHeight: 30
    spacing: 0
    Repeater {
      id: workspacesList
      model: workspacesShown
      Button {
        id: workspace
        required property int index
        implicitWidth:root.wsButtonWidth
        implicitHeight:root.wsButtonHeight
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
