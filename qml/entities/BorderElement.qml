import VPlay 1.0
import QtQuick 1.1

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
