import Felgo 3.0
import QtQuick 2.0

EntityBase {
  entityType: "border"

  BoxCollider {
    width: parent.width
    height: parent.height
    bodyType: Body.Static
    fixture.onBeginContact: {
      player.gameOver()
    }
  }
}
