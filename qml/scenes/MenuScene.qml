import QtQuick 1.1
import VPlay 1.0
import "../common"
import "../entities"

SceneBase {
  id: scene

  signal gamePressed()
  signal networkPressed()

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
  }

  SingleSpriteFromFile {
    anchors.top: parent.top
    anchors.topMargin: 100
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    filename: "../img/images-sd.json"
    source: "logo.png"
  }

  Ground {
    id: ground
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    anchors.bottom: scene.gameWindowAnchorItem.bottom
  }

  Player {
    resetX: scene.gameWindowAnchorItem.width/2
    resetY: scene.gameWindowAnchorItem.height/2
  }

  Menu {
    anchors.bottom: ground.top

    onNetworkPressed: parent.networkPressed()
    onPlayPressed: gamePressed()
  }

  VPlayNote {}

  onEnterPressed: {
    gamePressed()
  }
}
