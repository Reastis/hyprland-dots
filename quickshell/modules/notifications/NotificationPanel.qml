import qs.modules.widgets
import qs.services
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland


Scope {
  id: notifications
  property var notifs: NotificationDaemon.popupNotifications
  PanelWindow {
    id: root
    WlrLayershell.namespace: "quickshell:notifications"
    WlrLayershell.layer: WlrLayer.Overlay
    implicitWidth: 300
    exclusiveZone:0
    property real padding: 10
    color:"transparent"
    anchors {
      top: true
      right: true
      bottom: true
    }

    mask: Region {
      item: listView.contentItem
    }

    NotificationListView {
      id: listView
      implicitWidth: parent.width - root.padding*2
      anchors {
        top: parent.top
        bottom: parent.bottom
        right: parent.right
        rightMargin: root.padding
        topMargin: root.padding
        leftMargin: root.padding
      }
    }
  }
}
