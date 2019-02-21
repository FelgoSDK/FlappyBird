import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
  id: scene

  property alias gameNetwork: gameNetwork

  property alias initialStateBeforeShow: gameNetworkView.initialStateBeforeShow

  GameNetworkView {
    id: gameNetworkView
    anchors.fill: scene.gameWindowAnchorItem

    // no achievements used yet, so do not show the achievements icon
    showAchievementsHeaderIcon: false

    onBackClicked: {
      scene.backButtonPressed()
    }
  }

  FelgoGameNetwork {
    id: gameNetwork
    // received from the GameNetwork dashboard at https://cloud.felgo.com
    gameId: 105
    secret: "flappyBirdDevPasswordForVPlayGameNetwork"
    gameNetworkView: gameNetworkView

    onNewHighscore: {
      if(!isUserNameSet(userName)) {
        nativeUtils.displayTextInput("Congratulations!", "You achieved a new highscore. What is your player name for comparing your scores?", "")
      }
    }
  }

  Connections {
    target: nativeUtils
    onTextInputFinished: {
      if(accepted) {
        var validUserName = gameNetwork.updateUserName(enteredText)
      }
    }
  }
}
