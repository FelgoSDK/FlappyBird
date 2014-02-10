import QtQuick 1.1
import VPlay 1.0
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
      scene.backPressed()
    }
  }

  VPlayGameNetwork {
    id: gameNetwork
    // received from the GameNetwork dashboard at http://gamenetwork.v-play.net
    gameId: 20
    secret: "gameNetworkSecretFlappyBird"
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
        // we may show a messagebox if the user name was not valid
      }
    }
  }
}
