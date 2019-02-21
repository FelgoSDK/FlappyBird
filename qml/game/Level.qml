import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../common"

Item {
  id: level

  Background {
    anchors.horizontalCenter: parent.horizontalCenter
    y: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height-height
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
