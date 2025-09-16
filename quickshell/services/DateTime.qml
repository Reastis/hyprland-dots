pragma Singleton
import Quickshell
import QtQuick
Singleton {
  id: root
  property bool enabled: clock.enabled
  property var fullDate: clock.date
  property int hours: clock.hours
  property int minutes: clock.minutes
  property int seconds: clock.seconds
  property string time: Qt.formatDateTime(fullDate, "h:mm:ss AP")
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

