
//
//  ViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: MusicView {
    
    @IBOutlet weak var sound_button: UIButton!
    var timer_duration = 30
    
    @IBAction func SoundControl(_ sender: UIButton) {
        if mute{
            mute = false
            super.playMusic()
            sound_button.isSelected = false
            music = true
        }
        else{
            super.pauseMusic()
            music = false
            mute = true
            sound_button.isSelected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.playMusic()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.pauseMusic()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "game"{
            let destinationVC = segue.destination as! GameViewController
            destinationVC.timer_duration = timer_duration
        }
        // Pass the selected object to the new view controller.
    }
    
}
