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
      position100.frameNames = ["empty_big.png"]
    } else {
      trailingZero = false
      position100.frameNames = [unit+"_big.png"]
    }

    unit = truncate((number / 10) % 10)
    if((trailingZero && unit <= 0) || unit >= 10) {
      position10.frameNames = ["empty_big.png"]
    } else {
      position10.frameNames = [unit+"_big.png"]
    }

    unit = truncate(number % 10)
    // test also if there is remainder, if no remainder it might be 10 and the first number is needed, otherwise a fragment is displayed.
    if(number % 10 && ((trailingZero && unit <= 0) || unit >= 10)) {
      position1.frameNames = ["empty_big.png"]
    } else {
      position1.frameNames = [unit+"_big.png"]
    }

    if(number <= 0) {
      position1.frameNames = ["0_big.png"]
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
        frameNames: [
          "empty_big.png"
        ]
      }
    }
    SpriteSequenceFromFile {
      running: false

      filename: "../img/images-sd.json"

      Sprite {
        id: position10
        frameNames: [
          "empty_big.png"
        ]
      }
    }

    SpriteSequenceFromFile {
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
