import QtQuick

Image {
  id: root
  property real implicitSize: 24
  property real sourceResolution: 1024
  width: implicitSize
  height: implicitSize
  fillMode: Image.PreserveAspectFit
  sourceSize.height: sourceResolution
  sourceSize.width: sourceResolution
  smooth: true
}
