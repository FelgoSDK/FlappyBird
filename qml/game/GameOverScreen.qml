import VPlay 1.0
import QtQuick 1.1
import "../scenes"
import "../common"

Item {
  anchors.centerIn: parent
  anchors.fill: parent
  opacity: 0

  signal playPressed()
  signal networkPressed()

  SingleSpriteFromFile {
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
    source: "gameOver.png"
    anchors.bottom: scoreBoard.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30
  }

  SingleSpriteFromFile {
    id: scoreBoard
    translateToCenterAnchor: false
    anchors.centerIn: parent
    filename: "../img/images-sd.json"
    source: "scoreBoard.png"
  }

  SingleSpriteFromFile {
    id: medal
    translateToCenterAnchor: false
    filename: "../img/images-sd.json"
    source: (highscore >= 5 && highscore <10) ? "medalBronze.png" :
            (highscore >= 10 && highscore <15) ? "medalSilver.png" :
            (highscore >= 15 && highscore <20) ? "medalGold.png" :
            (highscore >= 20) ? "medalPlatin.png" : ""
    anchors.left: scoreBoard.left
    anchors.leftMargin: 26
    anchors.top: scoreBoard.top
    anchors.topMargin: 42
  }

  Numbers {
    anchors.right: scoreBoard.right
    anchors.rightMargin: 15
    anchors.top: scoreBoard.top
    anchors.topMargin: 45
    scale: 0.5
    number: gameScene.score
  }

  Numbers {
    anchors.right: scoreBoard.right
    anchors.rightMargin: 15
    anchors.top: scoreBoard.top
    anchors.topMargin: 85
    scale: 0.5
    number: highscore
  }

  Menu {
    anchors.top: scoreBoard.bottom
    anchors.topMargin: 35
    onPlayPressed: parent.playPressed()
    onNetworkPressed: parent.networkPressed()
  }

  VPlayNote {}

}
