import VPlay 1.0
import QtQuick 1.1

Item {
  anchors.centerIn: parent
  anchors.fill: parent
  opacity: 0

  signal clicked()

  SingleSpriteFromFile {
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
    source: "getReady.png"
    anchors.bottom: tutorial.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }

  SingleSpriteFromFile {
    id: tutorial
    translateToCenterAnchor: false
    anchors.centerIn: parent
    filename: "../img/images-sd.json"
    source: "tutorial.png"
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      parent.clicked()
    }
  }
}
