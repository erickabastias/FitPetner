
//
//  ViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var sound_button: UIButton!
    var timer_duration = 30
    var backgroundMusicPlayer: AVAudioPlayer!
    var mute: Bool = false
    var music: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        music = mute
        if music == false{
            playBackgroundMusic(filename: "background")
            music = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        backgroundMusicPlayer.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SoundControl(_ sender: UIButton) {
        if mute{
            backgroundMusicPlayer.play()
            mute = false
            sound_button.isSelected = false
        }
        else{
            backgroundMusicPlayer.pause()
            mute = true
            sound_button.isSelected = true
        }
    }
    
    func playBackgroundMusic(filename: String) {

        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        if (url == nil) {
            print("Could not find the file \(filename)")
        }
        else{
            let error: NSError? = nil
            
            //Assigns the actual music to the music player
            backgroundMusicPlayer = try!AVAudioPlayer(contentsOf: url!)
            if backgroundMusicPlayer == nil {
                print("Could not create audio player: \(error!)")
                return
            }
            else{
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "game"{
            let destinationVC = segue.destination as! GameViewController
            destinationVC.timer_duration = timer_duration
            destinationVC.mute = mute
        }
        // Pass the selected object to the new view controller.
    }
    
}
