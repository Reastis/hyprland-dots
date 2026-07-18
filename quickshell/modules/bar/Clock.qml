import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  width: componentLoader.item?.width
  height: componentLoader.item?.height
  property bool isHorizontal: true
  Loader {
    id: componentLoader
    anchors.centerIn: parent
    sourceComponent: isHorizontal? clockHorizontal : clockVertical
  }
  Component {
    id: clockHorizontal
    StyledText {
      id: localTime
      Layout.alignment: Qt.AlignCenter
      text: Qt.formatDateTime(DateTime.rawDateTime, "hh:mm AP")
    }
  }
  Component {
    id: clockVertical
    StyledText {
      id: localTime
      Layout.alignment: Qt.AlignCenter
      text: Qt.formatDateTime(DateTime.rawDateTime, "hh\nmm\nAP")
    }
  }
}
