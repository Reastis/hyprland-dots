pragma Singleton
import Quickshell
import QtQuick
Singleton {
  id: root
  property bool enabled: clock.enabled
  property var rawDateTime: clock.date
  property int hours: clock.hours
  property int minutes: clock.minutes
  property int seconds: clock.seconds
  property string time: Qt.formatDateTime(rawDateTime, "H:mm:ss")
  property string date: Qt.formatDate(rawDateTime, "dddd / dd MMMM")
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

