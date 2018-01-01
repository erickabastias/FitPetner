//
//  ChangeNameViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class ChangeNameViewController: MusicView, UITextFieldDelegate {
    
    @IBOutlet weak var changename_txtfield: UITextField!
    var timerduration = 30
    @IBOutlet weak var timer: UIStepper!
    @IBOutlet weak var timer_label: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changename_txtfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func change_timer(_ timer: UIStepper) {
        timer_label.text = Int(timer.value).description + " minutes"
    }
    
    func textFieldShouldReturn(_ changename_txtfield: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationVC = segue.destination as! StatsViewController
        destinationVC.firstVCtext = changename_txtfield.text!
        destinationVC.timer_duration = (Int(timer.value)*60)
        // Pass the selected object to the new view controller.
    }
    
}
