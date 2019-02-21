import Felgo 3.0
import QtQuick 2.0

Item {
  id: button

  signal clicked
  signal pressed
  signal released

  width: sprite.width
  height: sprite.height

  property alias source: sprite.source

  MultiResolutionImage {
    id: sprite
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
