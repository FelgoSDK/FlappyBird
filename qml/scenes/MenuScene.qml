import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"

SceneBase {
  id: scene

  signal gamePressed()
  signal networkPressed()

  Background {
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    anchors.bottom: scene.gameWindowAnchorItem.bottom
  }

  MultiResolutionImage {
    anchors.top: parent.top
    anchors.topMargin: 60
    anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    source: "../../assets/img/logo.png"
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

  onEnterPressed: {
    gamePressed()
  }
}
