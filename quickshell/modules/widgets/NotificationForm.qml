import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.modules.widgets

Item {
  id: root
  property real padding: 5
  property real contentMargins: 5
  property real notificationSpacing: 2
  implicitWidth: 245
  height: contentColumnLayout.height + padding * 2

  required property var notifObject
  property string icon: notifObject?.appIcon == "" ? notifObject?.appName : notifObject?.appIcon
  Component.onCompleted: notifObject?.bind(this)
  Component.onDestruction: notifObject?.unbind(this)
  Rectangle {
    id: background
    anchors.left: parent.left
    width: parent.width
    height: contentColumnLayout.height + padding * 2
    color: "#CF0F47"
    radius: 10
  }
  ColumnLayout {
    id: contentColumnLayout
    spacing: notificationSpacing
    implicitWidth: root.implicitWidth
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: padding
    }
    Item {
      id: summaryContainer
      width: root.implicitWidth-padding * 2
      height: summaryLayout.height
      RowLayout {
        id: summaryLayout
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2
        IconImage {
          id: appIconImage
          implicitSize: 24
          source: Quickshell.iconPath(icon, "image-missing")
        }
        StyledText {
          id: summary
          Layout.preferredWidth: parent.width - appIconImage.implicitSize - contentMargins * 2
          height: parent.implicitHeight
          font.pixelSize: 18
          text: notifObject?.summary ?? notifObject?.appName
          elide: Text.ElideRight
        }
      }
    }
    Item {
      id: contentContainer
      width: root.width - padding * 2
      Layout.preferredHeight: content.height + 2 * contentMargins
      Rectangle {
        anchors.fill: parent
        color: "#EA5B6F"
        radius: background.radius - padding
      }
      StyledListView {
        id: content
        model: ScriptModel {
          values: notifObject?.notifs
        }
        anchors.centerIn: parent
        implicitHeight: contentHeight
        implicitWidth: parent.width - 2 * contentMargins
        delegate: Item {
          required property int index
          required property var modelData
          width: ListView.view.width
          height: message.height
          StyledText {
            id: message
            property var notif: modelData
            width: parent.width
            font.pixelSize: 16
            text: modelData.body
            wrapMode: Text.Wrap
            elide: Text.ElideRight
          }
        }
      }
    }
  }
}
