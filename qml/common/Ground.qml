import VPlay 1.0
import QtQuick 1.1

Item {
  width: spriteSequence.width
  height: spriteSequence.height

  SpriteSequenceFromFile {
    id: spriteSequence
    anchors.centerIn: parent
    filename: "../img/images-sd.json"

    Sprite {
      name: "running"
      frameNames: [
        "land.png",
        "land1.png",
      ]
      frameCount: 2
      frameRate: 4
    }
  }

  function reset() {
    spriteSequence.running = true
  }

  function stop() {
    spriteSequence.running = false
  }
}
