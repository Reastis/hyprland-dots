import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.modules.widgets
import qs.services
import qs.common

Item {
  id: root

  required property bool isHorizontal

  property real padding: 0
  property real wsButtonWidth: 26
  property real wsButtonHeight: 26
  property real contentMargin: 4

  implicitWidth: wsLayoutLoader.item?.implicitWidth  // horizontalWorkspacesLayout + padding
  implicitHeight: wsLayoutLoader.item?.implicitHeight + padding

  property var occupiedWorkspaces: HyprHandler.occupiedWorkspaces
  property var occupiedSpecialWorkspaces: HyprHandler.occupiedSpecialWorkspaces
  property var emptyWorkspaces: HyprHandler.emptyWorkspaces

  property var focusedWorkspace: HyprHandler.focusedWorkspace
  property var activeToplevel: HyprHandler.activeToplevel

  property bool focusIsOccupied: occupiedWorkspaces.includes(focusedWorkspace)? true : false

  // Workspace marker
  Rectangle {
    z: 1
    id: activeWsBg
    x: isHorizontal? (padding+contentMargin)/2 + wsButtonWidth * Math.max(occupiedWorkspaces.indexOf(focusedWorkspace), 0) : contentMargin / 2
    y: !isHorizontal? (padding+contentMargin)/2 + wsButtonHeight * Math.max(occupiedWorkspaces.indexOf(focusedWorkspace), 0) : contentMargin / 2
    color: Appearance.colorScheme.cPrimary
    implicitWidth: wsButtonWidth - contentMargin
    implicitHeight: wsButtonHeight - contentMargin
    radius: implicitHeight / 3
    Behavior on x {
      NumberAnimation {
        duration: Appearance.animations.delaySwift
        easing.type: Easing.OutSine
      }
    }
    Behavior on y {
      NumberAnimation {
        duration: Appearance.animations.delaySwift
        easing.type: Easing.OutSine
      }
    }
  }

  Loader {
    z: 2
    id: wsLayoutLoader
    anchors.fill: parent
    sourceComponent: isHorizontal? horizontalLayout : verticalLayout
  }

  Component {
    id: horizontalLayout

    // EmptyWorkspace | Occupied Workspaces | Special Workspaces
    Row {
      id: horizontalWsLayout
      z: 2
      anchors.centerIn: parent
      spacing: contentMargin
      Button {
        id: emptyWsHorizontal
        implicitWidth: 0
        implicitHeight: root.wsButtonHeight

        property bool shouldTransition: false

        background: Item {
          id: wsBackground
          StyledText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: Appearance.colorScheme.cOnPrimary
            text: focusedWorkspace?.id > 0 && !focusIsOccupied? focusedWorkspace.name : ''
          }
        }

        state: !focusIsOccupied? "visible" : "hidden"
        states: [
          State {
            name: "visible"
            PropertyChanges { target: emptyWsHorizontal; opacity: 1; width: root.wsButtonWidth; shouldTransition: true; visible: true }
          },
          State {
            name: "hidden"
            PropertyChanges { target: emptyWsHorizontal; opacity: 0; width: 0; shouldTransition: true }
          },
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            enabled: emptyWsHorizontal.shouldTransition && occupiedWorkspaces?.length != 0? true : false
            SequentialAnimation {
              NumberAnimation { properties: "width, opacity"; duration: Appearance.animations.delaySwifter }
              PropertyAction { properties: "visible, shouldTransition" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            enabled: emptyWsHorizontal.shouldTransition? true : false
            SequentialAnimation {
              PropertyAction { properties: "visible, shouldTransition" }
              NumberAnimation { properties: "width, opacity"; duration: Appearance.animations.delaySwifter }
            }
          },
      ]
      }
      Rectangle {
        id: emptyWsSeparatorH
        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.colorScheme.cOnSurface
        implicitWidth: 1
        implicitHeight: 20

        state: !focusIsOccupied && occupiedWorkspaces?.length > 0? "visible" : "hidden"

        states: [
          State {
            name: "visible"
            PropertyChanges { target: emptyWsSeparatorH; opacity: 1; width: 1; visible: true}
          },
          State {
            name: "hidden"
            PropertyChanges { target: emptyWsSeparatorH; opacity: 0; width: 0; visible: false}
          }
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            enabled: emptyWsHorizontal.shouldTransition && occupiedWorkspaces?.length != 0? true : false
            SequentialAnimation {
              NumberAnimation { property: "width, opacity"; duration: Appearance.animations.delayNormal }
              PropertyAction { property: "visible" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
              PropertyAction { property: "visible" }
              NumberAnimation { property: "width, opacity"; duration: Appearance.animations.delayNormal }
            }
          }
        ]
      }

      // Occupied workspaces row
      Row {
        z: 2
        id: occupiedWsH
        spacing: 0


        add: Transition {
          NumberAnimation {
            properties: "opacity"
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
          }
          NumberAnimation {
            properties: "x, y"
            duration: Appearance.animations.delaySlow
            easing.type: Easing.OutBack
          }
        }

        Behavior on width {
          NumberAnimation {
            properties: "width"
            duration: Appearance.animations.delaySlow
          }
        }
        Repeater {
          id: occupiedWsListH
          model: ScriptModel {
            values: occupiedWorkspaces
          }
          onItemAdded: () => {
            emptyWsHorizontal.shouldTransition = occupiedWorkspaces?.length == 1?  true : false;
          }
          onItemRemoved: () => {
            emptyWsHorizontal.shouldTransition = false;
          }
          Button {
            id: occupiedWs
            required property var modelData

            implicitWidth: root.wsButtonWidth
            implicitHeight: root.wsButtonHeight

            background: Item {
              id: wsBackground
              StyledText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: modelData.id > 0? modelData.name : 'Ex'

                color: focusedWorkspace == modelData? Appearance.colorScheme.cOnPrimary : Appearance.colorScheme.cOnSurface
                Behavior on color {
                  ColorAnimation {
                    duration: Appearance.animations.delaySwifter
                    easing.type: Easing.InOutQuad
                  }
                }
              }
            }
          }
        }
      }

      Rectangle {
        id: specialWsSeparatorH

        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.colorScheme.cOnSurface

        implicitWidth: 0
        implicitHeight: 20
 
        state: occupiedSpecialWorkspaces?.length > 0? "visible" : "hidden"
        states: [
          State {
            name: "visible"
            PropertyChanges { target: specialWsSeparatorH; opacity: 1; width: 1; visible: true}
          },
          State {
            name: "hidden"
            PropertyChanges { target: specialWsSeparatorH; opacity: 0; width: 0; visible: false}
          }
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
              NumberAnimation { property: "width, opacity"; duration: Appearance.animations.delayNormal }
              PropertyAction { property: "visible" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
              PropertyAction { property: "visible" }
              NumberAnimation { property: "width, opacity"; duration: Appearance.animations.delayNormal }
            }
          }
        ]
      }

    //Special workspaces row
      Row {
        z: 2
        id: occupiedSpecialWsLayoutH
        spacing: 0

        add: Transition {
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
          }
        }

        Repeater {
          id: occupiedSpecialWsListH
          model: occupiedSpecialWorkspaces
          Button {
            id: occupiedSpecialWsH
            required property var modelData
            property bool isActive: modelData.name == activeToplevel?.workspace?.name
            implicitWidth: root.wsButtonWidth
            implicitHeight: root.wsButtonHeight
            background: Item {
              id: wsBackground
              Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                opacity: isActive? 1 : 0

                color: Appearance.colorScheme.cPrimary
                implicitWidth: wsButtonWidth-contentMargin
                implicitHeight: wsButtonHeight-contentMargin
                radius: implicitWidth/3

                Behavior on opacity {
                  NumberAnimation {
                    duration: Appearance.animations.delaySwift
                    easing.type: Easing.InOutQuad
                  }
                }
              }

              StyledText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: `${modelData.name.replace("special:", "")[0].toUpperCase()}`

                color: isActive? Appearance.colorScheme.cOnPrimary : Appearance.colorScheme.cOnSurface
                Behavior on color {
                  ColorAnimation {
                    duration: Appearance.animations.delaySwift
                    easing.type: Easing.InOutQuad
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  Component {
    id: verticalLayout
    Column {
    id: verticalWsLayout
      z: 2
      spacing: contentMargin
      anchors.centerIn: parent

      Button {
        id: emptyWsVertical
        implicitWidth: root.wsButtonWidth
        implicitHeight: root.wsButtonHeight

        property bool shouldTransition: false

        background: Item {
          id: wsBackground
          StyledText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: focusedWorkspace?.id > 0 && !focusIsOccupied? focusedWorkspace.name : ''
            color: Appearance.colorScheme.cOnPrimary
          }
        }

        state: !focusIsOccupied? "visible" : "hidden"
        states: [
          State {
            name: "visible"
            PropertyChanges { target: emptyWsVertical; opacity: 1; height: root.wsButtonHeight; shouldTransition: true; visible: true }
          },
          State {
            name: "hidden"
            PropertyChanges { target: emptyWsVertical; opacity: 0; height: 0; shouldTransition: true; }
          },
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            enabled: emptyWsVertical.shouldTransition && occupiedWorkspaces?.length != 0? true : false
            SequentialAnimation {
              NumberAnimation { properties: "height, opacity"; duration: Appearance.animations.delaySwifter }
              PropertyAction { properties: "visible, shouldTransition" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            enabled: emptyWsVertical.shouldTransition? true : false
            SequentialAnimation {
              PropertyAction { properties: "visible, shouldTransition" }
              NumberAnimation { properties: "height, opacity"; duration: Appearance.animations.delaySwifter }
            }
          },
        ]
      }

      Rectangle {
        id: emptyWsSeparatorV
        anchors.horizontalCenter: parent.horizontalCenter
        color: Appearance.colorScheme.cOnSurface
        implicitWidth: 25
        implicitHeight: 1
        state: !focusIsOccupied && occupiedWorkspaces?.length > 0? "visible" : "hidden"
        states: [
          State {
            name: "visible"
            PropertyChanges { target: emptyWsSeparatorV; opacity: 1; height: 1; visible: true}
          },
          State {
            name: "hidden"
            PropertyChanges { target: emptyWsSeparatorV; opacity: 0; height: 0; visible: false}
          }
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            enabled: emptyWsVertical.shouldTransition && occupiedWorkspaces?.length != 0? true : false
            SequentialAnimation {
              NumberAnimation { property: "height, opacity"; duration: Appearance.animations.delayNormal }
              PropertyAction { property: "visible" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
              PropertyAction { property: "visible" }
              NumberAnimation { property: "width, opacity"; duration: Appearance.animations.delayNormal }
            }
          }
        ]
      }

      Column {
        z: 2
        id: occupiedWsVertical
        spacing: 0

        add: Transition {
          NumberAnimation {
            properties: "opacity"
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
          }
          NumberAnimation {
            properties: "x, y"
            duration: Appearance.animations.delaySlow
            easing.type: Easing.OutBack
          }
        }

        Repeater {
          id: occupiedWsListV
          model: ScriptModel {
            values: occupiedWorkspaces
          }
          onItemAdded: () => {
            emptyWsVertical.shouldTransition = occupiedWorkspaces?.length != 1?  true : false;
          }
          onItemRemoved: () => {
            emptyWsVertical.shouldTransition = false;
          }
          Button {
            id: occupiedWs
            required property var modelData

            implicitWidth: root.wsButtonWidth
            implicitHeight: root.wsButtonHeight

            background: Item {
              id: wsBackground
              StyledText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: modelData.id > 0? modelData.name : 'Ex'
                color: focusedWorkspace == modelData? Appearance.colorScheme.cOnPrimary : Appearance.colorScheme.cOnSurface
                Behavior on color {
                  ColorAnimation {
                    duration: Appearance.animations.delaySwifter
                  }
                }
              }
            }
          }
        }
      }

      Rectangle {
        id: specialWsSeparatorV

        anchors.horizontalCenter: parent.horizontalCenter
        color: Appearance.colorScheme.cOnSurface

        implicitWidth: 25
        implicitHeight: 1

        state: occupiedSpecialWorkspaces?.length > 0? "visible" : "hidden"
        states: [
          State {
            name: "visible"
            PropertyChanges { target: specialWsSeparatorV; opacity: 1; height: 1; visible: true}
          },
          State {
            name: "hidden"
            PropertyChanges { target: specialWsSeparatorV; opacity: 0; height: 0; visible: false}
          }
        ]
        transitions: [
          Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
              NumberAnimation { property: "height, opacity"; duration: Appearance.animations.delayNormal }
              PropertyAction { property: "visible" }
            }
          },
          Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
              PropertyAction { property: "visible" }
              NumberAnimation { property: "height, opacity"; duration: Appearance.animations.delayNormal }
            }
          }
        ]
      }

      Column {
        z: 2
        id: occupiedSpecialWsLayoutV
        spacing: 0

        add: Transition {
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            easing.type: Easing.InOutQuad
          }
        }

        Repeater {
          id: occupiedSpecialWsListV
          model: occupiedSpecialWorkspaces
          Button {
            id: occupiedSpecialWsV
            required property var modelData
            property bool isActive: modelData.name == activeToplevel?.workspace?.name
            implicitWidth: root.wsButtonWidth
            implicitHeight: root.wsButtonHeight
            background: Item {
              id: wsBackground
              Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                opacity: isActive? 1 : 0

                Behavior on opacity {
                  NumberAnimation {
                    duration: Appearance.animations.delaySwift
                    easing.type: Easing.InOutQuad
                  }
                }

                color: Appearance.colorScheme.cPrimary
                implicitWidth: wsButtonWidth-contentMargin
                implicitHeight: wsButtonHeight-contentMargin
                radius: implicitWidth/3
              }

              StyledText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text: `${modelData.name.replace("special:", "")[0].toUpperCase()}`

                color: isActive? Appearance.colorScheme.cOnPrimary : Appearance.colorScheme.cOnSurface
                Behavior on color {
                  ColorAnimation {
                    duration: Appearance.animations.delaySwift
                    easing.type: Easing.InOutQuad
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
