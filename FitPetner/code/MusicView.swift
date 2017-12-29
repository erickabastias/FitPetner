//
//  ExtensionUI.swift
//  FitPetner
//
//  Created by Ericka Bastias on 29/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MusicView: UIViewController {
    
    var backgroundMusicPlayer: AVAudioPlayer!
    var music: Bool = false
    var mute: Bool = false
    
    
    func playMusic() {
        backgroundMusicPlayer = try!AVAudioPlayer(contentsOf: background.mp3!)
        if backgroundMusicPlayer == nil {
            print("Could not create audio player: \(error!)")
            return
        }
        else{
            if(mute == false){
                if(music == false){
                    backgroundMusicPlayer.numberOfLoops = -1
                    backgroundMusicPlayer.prepareToPlay()
                    backgroundMusicPlayer.play()
                    music = true
                }
            }
        }
    }
    
    func playSoundEffect(filename: String) {
        //bark, coin, food
        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        if (url == nil) {
            print("Could not find the file \(filename)")
        }
        else{
            let error: NSError? = nil
            
        soundEffectPlayer = try!AVAudioPlayer(contentsOf: bark.mp3!)
        if soundEffectPlayer == nil {
            print("Could not create audio player: \(error!)")
            return
        }
        else{
            if(mute == false){
                soundEffectPlayer.numberOfLoops = 1
                soundEffectPlayer.prepareToPlay()
                soundEffectPlayer.play()
                }
            }
        }
    }
}

