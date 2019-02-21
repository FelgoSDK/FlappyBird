import Felgo 3.0
import QtQuick 2.0
import "../scenes"
import "../common"

Item {
  width: parent.width
  height: parent.height
  y: -30
  opacity: 0
  visible: opacity === 0 ? false : true
  enabled: visible

  signal playPressed()
  signal networkPressed()
  signal useCoinsPressed()

  MultiResolutionImage {
    source: "../../assets/img/gameOver.png"
    anchors.bottom: scoreBoard.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }

  MultiResolutionImage {
    id: scoreBoard
    anchors.centerIn: parent
    source: "../../assets/img/scoreBoard.png"
  }

  Numbers {
    anchors.right: scoreBoard.right
    anchors.rightMargin: -10
    anchors.top: scoreBoard.top
    anchors.topMargin: 35
    scale: 0.5
    number: gameScene.score
  }

  Numbers {
    anchors.right: scoreBoard.right
    anchors.rightMargin: -10
    anchors.top: scoreBoard.top
    anchors.topMargin: 75
    scale: 0.5
    number: highscore
  }

  Numbers {
    color: "_gold"
    anchors.left: scoreBoard.left
    anchors.leftMargin: 30
    anchors.top: scoreBoard.top
    anchors.topMargin: 50
    number: coins
  }

  Menu {
    anchors.top: scoreBoard.bottom
    anchors.topMargin: 15
    onPlayPressed: parent.playPressed()
    onNetworkPressed: parent.networkPressed()
  }

}
