pragma Singleton
import Quickshell
import QtQuick
Singleton {
  id: root
  property bool enabled: clock.enabled
  property var rawDate: clock.date
  property int hours: clock.hours
  property int minutes: clock.minutes
  property int seconds: clock.seconds
  property string time: Qt.formatDateTime(rawDate, "h:mm:ss AP")
  property string date: Qt.formatDate(rawDate, "dddd / dd MMM")
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

