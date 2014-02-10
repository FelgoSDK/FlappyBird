import VPlay 1.0
import QtQuick 1.1
import "../entities"
import "../common"

Item {
  id: level

  Background {
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y-20
    width: scene.gameWindowAnchorItem.width
    height: 20
  }

  BorderElement {
    y: ground.y
    x: scene.gameWindowAnchorItem.x
    width: scene.gameWindowAnchorItem.width
    height: 20
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x-20
    y: scene.gameWindowAnchorItem.y
    width: 20
    height: scene.gameWindowAnchorItem.height
  }

  BorderElement {
    x: scene.gameWindowAnchorItem.x+scene.gameWindowAnchorItem.width
    y: scene.gameWindowAnchorItem.y
    width: 20
    height: scene.gameWindowAnchorItem.height
  }

  Pipes {
    id: pipes1
    delay: 0
  }

  Pipes {
    id: pipes2
    delay: 1.5
  }

  Ground {
    id: ground
    anchors.horizontalCenter: parent.horizontalCenter
    y: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height-height
  }

  function reset() {
    pipes1.reset()
    pipes2.reset()
    ground.reset()
  }

  function stop() {
    pipes1.stop()
    pipes2.stop()
    ground.stop()
  }

  function start() {
    pipes1.start()
    pipes2.start()
  }
}
