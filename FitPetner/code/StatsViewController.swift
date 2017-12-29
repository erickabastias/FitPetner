//
//  StatsViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class StatsViewController: MusicView {
    
    @IBOutlet weak var coinslbl: UILabel!
    @IBOutlet weak var pointslbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var level_lbl: UILabel!
    @IBOutlet weak var sound_button: UIButton!
    
    @IBAction func SoundControl(_ sender: UIButton) {
        if mute{
            mute = false
            backgroundMusicPlayer.play()
            sound_button.isSelected = false
            music = true
        }
        else{
            backgroundMusicPlayer.pause()
            music = false
            mute = true
            sound_button.isSelected = true
        }
    }
    
    var firstVCtext = "NAME"
    var level = 0
    var coins = 0
    var points = 0
    var savedcoins = 0
    var savedlevel = 0
    var savedpoints = 0
    var timer_duration = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelbl.text = firstVCtext
        level_lbl.text = String(savedlevel+level)
        pointslbl.text = String(savedpoints + points)
        coinslbl.text = String(savedcoins+coins)
        savevalues()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func savevalues(){
        savedlevel = savedlevel+level
        savedpoints = savedpoints + points
        savedcoins = savedcoins + coins
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "home"{
        let destinationVC = segue.destination as! ViewController
        destinationVC.timer_duration = timer_duration
        destinationVC.mute = mute
        }
    }

    

}
