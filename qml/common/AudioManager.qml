import VPlay 1.0
import QtQuick 1.1

Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idBUTTON)
  property int idDIE: 11
  property int idHIT: 22
  property int idPOINT: 33
  property int idSWOOSHING: 44
  property int idWING: 55


  function play(clipID) {

    switch(clipID) {
    case idDIE:
      clip.source = "../audio/sfx_die.wav"
      break
    case idHIT:
      clip.source = "../audio/sfx_hit.wav"
      break
    case idPOINT:
      clip.source = "../audio/sfx_point.wav"
      break
    case idSWOOSHING:
      clip.source = "../audio/sfx_swooshing.wav"
      break
    case idWING:
      clip.source = "../audio/sfx_wing.wav"
      break
    }

    clip.play()
  }

  Sound {
    id: clip
    volume: 1
  }
}
