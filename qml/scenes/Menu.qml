import VPlay 1.0
import QtQuick 1.1

Row {
  signal playPressed()
  signal networkPressed()

  spacing: 30
  anchors.horizontalCenter: parent.horizontalCenter
  height: menuItem.height

  ImageButton {
    id: menuItem
    onClicked: {
      playPressed()
    }
    source: "playAgain.png"
  }

  ImageButton {
    onClicked: {
      networkPressed()
    }
    source: "scores.png"
  }
}
