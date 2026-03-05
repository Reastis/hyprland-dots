import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  implicitWidth: content.implicitWidth

  property bool showDate: true
  
  RowLayout {
    id: content
    anchors.centerIn: parent
    StyledText {
      id: localTime
      text: DateTime.time
    }
    StyledText {
      id: separator
      enabled: showDate
      text: "•"
    }
    StyledText {
      id: localDate
      enabled: showDate
      text: DateTime.date
    }
  }
}
