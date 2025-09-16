pragma Singleton
import Quickshell
import QtQuick
Singleton {
  id: root
  property bool enabled: clock.enabled
  property int hours: clock.hours
  property int minutes: clock.minutes
  property int seconds: clock.seconds
  property string time: Qt.formatTime(`${hours}:${minutes}`)
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}

