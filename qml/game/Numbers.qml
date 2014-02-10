import VPlay 1.0
import QtQuick 1.1
import "../entities"

Item {
  id: numbers
  width: row.width
  height: row.heigth
  property int number: 0

  function truncate(_value)
  {
    if (_value<0) return Math.ceil(_value);
    else return Math.floor(_value);
  }

  onNumberChanged: {
    var trailingZero = true
    var unit = truncate((number / 100) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position100.frameNames = []
      position100.visible = false
    } else {
      trailingZero = false
      position100.visible = true
      position100.frameNames = [unit+"_big.png"]
    }

    unit = truncate((number / 10) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position10.frameNames = []
      position10.visible = false
    } else {
      position10.visible = true
      position10.frameNames = [unit+"_big.png"]
    }

    unit = truncate(number % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position1.frameNames = []
    } else {
      position1.frameNames = [unit+"_big.png"]
    }

    if(number <= 0) {
      position1.frameNames = ["0_big.png"]
      position1.visible = true
      position10.visible = false
      position100.visible = false
    }
  }

  Row {
    id: row
    height: position1.height

    SpriteSequenceFromFile {
      running: false

      filename: "../img/images-sd.json"

      Sprite {
        id: position100
      }
    }
    SpriteSequenceFromFile {
      running: false

      filename: "../img/images-sd.json"

      Sprite {
        id: position10
      }
    }

    SpriteSequenceFromFile {
      id: test
      running: false

      filename: "../img/images-sd.json"

      Sprite {
        id: position1
        frameNames: [
          "0_big.png"
        ]
      }
    }
  }
}
