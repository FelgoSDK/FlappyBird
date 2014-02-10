import VPlay 1.0
import QtQuick 1.1

Item {
  id: button

  signal clicked
  signal pressed
  signal released

  width: sprite.width
  height: sprite.height

  property alias source: sprite.source

  SingleSpriteFromFile {
    id: sprite
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
  }

  MouseArea {
    id: mouseArea
    enabled: button.enabled
    anchors.fill: button
    hoverEnabled: true

    onClicked: button.clicked()
    onPressed: button.pressed()
    onReleased: button.released()
  }

  onClicked: {
  }

  onPressed: {
    opacity = 0.5
  }

  onReleased: {
    opacity = 1.0
  }
}
