import qs.modules.widgets
import qs.services
import Quickshell
import QtQuick

StyledListView {
  id: root
  spacing: 3
  // reuseItems: true
  model: ScriptModel {
    values: NotificationDaemon.popupNotificationGroups
  }
  delegate: NotificationForm {
    id: notifForm
    required property int index
    required property var modelData
    notifObject: modelData
    implicitWidth: ListView.view.width
    SequentialAnimation {
      id: removeAnimation
      PropertyAction { target: notifForm; property: "ListView.delayRemove"; value:true }
      PropertyAction { target: notifForm; property: "enabled"; value:false }
      PropertyAction { target: notifForm; property: "z"; value:1 }
      NumberAnimation { target: notifForm; property: "x"; to: root.implicitWidth; duration: 1000; easing.type: Easing.InQuart }
      PropertyAction { target: notifForm; property: "ListView.delayRemove"; value:false }
    }
    ListView.onRemove: removeAnimation.start()
  }
  add: Transition {
    NumberAnimation {
      property: "x"
      from:root.implicitWidth
      duration:1000
      easing.type: Easing.OutQuart
    }
  }

  move: Transition {
    NumberAnimation {
      property: "y"
      duration: 800
      easing.type:Easing.InQuint
    }
    NumberAnimation {
      properties: "opacity, scale"
      to: 1
    }
  }
  displaced: Transition {
    NumberAnimation {
      property: "y"
      duration: 800
      easing.type:Easing.InQuint
    }
    // NumberAnimation {
    //   properties: "opacity, scale"
    //   to: 1
    // }
  }
}
