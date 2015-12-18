import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase {
  id: scene

  property alias gameNetwork: gameNetwork

  property alias initialStateBeforeShow: gameNetworkView.initialStateBeforeShow

  VPlayGameNetworkView {
    id: gameNetworkView
    anchors.fill: scene.gameWindowAnchorItem

    // no achievements used yet, so do not show the achievements icon
    showAchievementsHeaderIcon: false

    onBackClicked: {
      scene.backButtonPressed()
    }
  }

  VPlayGameNetwork {
    id: gameNetwork
    // received from the GameNetwork dashboard at http://gamenetwork.v-play.net
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
