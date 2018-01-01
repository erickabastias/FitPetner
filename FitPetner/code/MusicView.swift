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
        let path = Bundle.main.path(forResource: "sound.assets/background.mp3", ofType:nil)!
        let urlBackground = URL(fileURLWithPath: path)
        
        backgroundMusicPlayer = try!AVAudioPlayer(contentsOf: urlBackground)
        if backgroundMusicPlayer == nil {
//            print("Could not create audio player: \(error!)")
            return
        }
        else {
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
            
            if(!music) {
                music = true
            }
            
            if(mute == false){
                
            }
        }
    }
    
    func pauseMusic() {
        if (backgroundMusicPlayer != nil) {
            backgroundMusicPlayer.pause()
        }
        music = false
    }
    
//    func playSoundEffect(filename: String) {
//        //bark, coin, food
//        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
//        if (url == nil) {
//            print("Could not find the file \(filename)")
//        }
//        else{
//            let error: NSError? = nil
//
//            let path = Bundle.main.path(forResource: "sound.assets/bark.mp3", ofType:nil)!
//            let urlBark = URL(fileURLWithPath: path)
//
//            let soundEffectPlayer = try!AVAudioPlayer(contentsOf: urlBark)
//            if soundEffectPlayer == nil {
//                print("Could not create audio player: \(error!)")
//                return
//            }
//            else{
//                if(mute == false){
//                    soundEffectPlayer.numberOfLoops = 1
//                    soundEffectPlayer.prepareToPlay()
//                    soundEffectPlayer.play()
//                }
//            }
//        }
//    }
    
    func playSoundEffect(filename: String) {
        let path = Bundle.main.path(forResource: filename, ofType:nil)!
        let urlSoundEffect = URL(fileURLWithPath: path)
        
        let soundEffectPlayer = try!AVAudioPlayer(contentsOf: urlSoundEffect)
        if soundEffectPlayer == nil {
            //            print("Could not create audio player: \(error!)")
            return
        }
        else {
            if(mute == false){
                soundEffectPlayer.numberOfLoops = 1
                soundEffectPlayer.prepareToPlay()
                soundEffectPlayer.play()
            }
        }
    }
}

