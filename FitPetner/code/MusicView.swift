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
    var soundEffectPlayer: AVAudioPlayer!
    var music: Bool = false
    var mute: Bool = false
    
    
    func playMusic() {
        let path = Bundle.main.path(forResource: "background.mp3", ofType:nil)!
        let urlBackground = URL(fileURLWithPath: path)
        
        backgroundMusicPlayer = try!AVAudioPlayer(contentsOf: urlBackground)
        if backgroundMusicPlayer == nil {
//            print("Could not create audio player: \(error!)")
            return
        }

        if(!mute){
            if(!music) {
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                music = true
            }
        }
    }
    
    func pauseMusic() {
        if (backgroundMusicPlayer != nil) {
            backgroundMusicPlayer.pause()
        }
        music = false
    }
    
    func playSoundEffect(filename: String) {
        //bark, coin, food
        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        
        soundEffectPlayer = try!AVAudioPlayer(contentsOf: url!)
        if soundEffectPlayer == nil {
            //print("Could not create audio player: \(error!)")
            return
        }
        if(!mute){
            backgroundMusicPlayer.numberOfLoops = 1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        }
    }
}

