import qs.services
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.modules.widgets
Item {
  id: root
  property real padding: 4
  implicitWidth: workspacesLayout.implicitWidth + padding

  property var occupiedWorkspaces: HyprHandler.occupiedWorkspaces
  property var occupiedSpecialWorkspaces: HyprHandler.occupiedSpecialWorkspaces
  property var emptyWorkspaces: HyprHandler.emptyWorkspaces

  property var focusedWorkspace: HyprHandler.focusedWorkspace
  property var activeToplevel: HyprHandler.activeToplevel

  property bool focusIsOccupied: occupiedWorkspaces.includes(focusedWorkspace)? true : false
  property real wsButtonWidth: 24
  property real wsButtonHeight: 24
  property real contentMargin: 4
  
  // Workspace marker
  Rectangle {
    z:1
    id: activeWorkspaceBg
    x: (padding+contentMargin)/2 + wsButtonWidth*Math.max(occupiedWorkspaces.indexOf(focusedWorkspace), 0) 
    anchors.verticalCenter: parent.verticalCenter
    color: "#EA5B6F"
    implicitWidth: wsButtonWidth-contentMargin
    implicitHeight: wsButtonHeight-contentMargin
    radius: implicitHeight/3
    Behavior on x {
      NumberAnimation {
        duration: 200
        easing.type: Easing.OutSine
      }
    }
  }

  // EmptyWorkspace | Occupied Workspaces | Special Workspaces
  Row {
    id: workspacesLayout
    z:2
    anchors.centerIn: parent
    spacing: contentMargin

    Button {
      id: emptyWorkspace
      implicitWidth: 0
      implicitHeight: root.wsButtonHeight
      background: Item {
        id: workspaceBackground
        StyledText {
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
          text: focusedWorkspace?.id > 0? focusedWorkspace.name : 's'
        }
      }

      state: !focusIsOccupied? (occupiedWorkspaces?.length != 0? "visible" : "transitive") : "hidden"
      states: [
        State {
          name: "visible"
          PropertyChanges { target: emptyWorkspace; opacity: 1; width: root.wsButtonWidth; visible: true }
        },
        State {
          name: "hidden"
          PropertyChanges { target: emptyWorkspace; opacity: 0; width: 0; visible: false }
        },
        State {
          name: "transitive"
          PropertyChanges { target: emptyWorkspace; opacity: 1; width: root.wsButtonWidth; visible: true}
        }
      ]
      transitions: [
        Transition {
          from: "visible"
          to: "hidden"
          SequentialAnimation {
            NumberAnimation { properties: "width, opacity"; duration:100 }
            PropertyAction { property: "visible" }
          }
        },
        Transition {
          from: "hidden"
          to: "visible"
          SequentialAnimation {
            PropertyAction { property: "visible" }
            NumberAnimation { properties: "width, opacity"; duration:100 }
          }
        },
        Transition {
          from: "transitive"
          to: "hidden"
          PropertyAction { properties: "visible" }
        },
        Transition {
          from: "hidden"
          to: "transitive"
          PropertyAction { properties: "opacity, width, visible" }
        }
      ]
    }
    Rectangle {
      id: emptyWsSeparator
      anchors.verticalCenter: parent.verticalCenter
      color: "white"
      implicitWidth: 1
      implicitHeight: 20
      state: !focusIsOccupied && occupiedWorkspaces?.length > 0? "visible" : "hidden"
      states: [
        State {
          name: "visible"
          PropertyChanges { target:emptyWsSeparator; opacity: 1; width: 1; visible: true}
        },
        State {
          name: "hidden"
          PropertyChanges { target:emptyWsSeparator; opacity: 0; width: 0; visible: false}
        }
      ]
      transitions: [
        Transition {
          from: "visible"
          to: "hidden"
          SequentialAnimation {
            NumberAnimation { property: "width, opacity"; duration:300 }
            PropertyAction { property: "visible" }
          }
        },
        Transition {
          from: "hidden"
          to: "visible"
          SequentialAnimation {
            PropertyAction { property: "visible" }
            NumberAnimation { property: "width, opacity"; duration:300 }
          }
        }
      ]
    }

    // Occupied workspaces row
    Row {
      z:2
      id: occupiedWorkspacesLayout
      spacing: 0

      add: Transition {
        NumberAnimation {
          property: "opacity"
          from:0
          to:1
          easing.type: Easing.InOutQuad
        }
        NumberAnimation {
          properties: "x, y"
          duration: 400
          easing.type: Easing.OutBack
        }
      }

      Repeater {
        id: occupiedWorkspacesList
        model: occupiedWorkspaces
        Button {
          id: occupiedWorkspace
          required property var modelData

          implicitWidth: root.wsButtonWidth
          implicitHeight: root.wsButtonHeight

          background: Item {
            id: workspaceBackground
            StyledText {
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter
              text: modelData.id > 0? modelData.name : 'Ex'
            }
          }
          Component.onCompleted: {
            Layout.preferredWidth = implicitWidth
          }
        }
      }
    }


    Rectangle {
      id: specialWsSeparator

      anchors.verticalCenter: parent.verticalCenter
      color: "white"
      
      implicitWidth: 1
      implicitHeight: 20
      
      state: occupiedSpecialWorkspaces?.length > 0? "visible" : "hidden"
      states: [
        State {
          name: "visible"
          PropertyChanges { target:specialWsSeparator; opacity: 1; width: 1; visible: true}
        },
        State {
          name: "hidden"
          PropertyChanges { target:specialWsSeparator; opacity: 0; width: 0; visible: false}
        }
      ]
      transitions: [
        Transition {
          from: "visible"
          to: "hidden"
          SequentialAnimation {
            NumberAnimation { property: "width, opacity"; duration:300 }
            PropertyAction { property: "visible" }
          }
        },
        Transition {
          from: "hidden"
          to: "visible"
          SequentialAnimation {
            PropertyAction { property: "visible" }
            NumberAnimation { property: "width, opacity"; duration:300 }
          }
        }
      ]
    }

  //Special workspaces row
    Row {
      z:2
      id: occupiedSpecialWorkspacesLayout
      spacing: 0

      add: Transition {
        NumberAnimation {
          property: "opacity"
          from:0
          to:1
          easing.type:Easing.InOutQuad
        }
        NumberAnimation {
          properties: "x, y"
          duration: 400
          easing.type: Easing.OutBack
        }
      }
      
      Repeater {
        id: occupiedSpecialWorkspacesList
        model: occupiedSpecialWorkspaces
        Button {
          id: occupiedSpecialWorkspace
          required property var modelData
          implicitWidth: root.wsButtonWidth
          implicitHeight: root.wsButtonHeight
          background: Item {
            id: workspaceBackground
            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter

              visible: modelData.name == activeToplevel?.workspace?.name

              color: "#EA5B6F"
              implicitWidth: wsButtonWidth-contentMargin
              implicitHeight: wsButtonHeight-contentMargin
              radius: implicitWidth/3
              Behavior on x {
                NumberAnimation {
                  duration: 200
                  easing.type: Easing.OutSine
                }
              }
            }

            StyledText {
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter
              text: `${modelData.name.replace("special:", "")[0].toUpperCase()}`

            }
          }
        }
      }
    }
  }
}
