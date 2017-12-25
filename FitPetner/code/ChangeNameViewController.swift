//
//  ChangeNameViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var changename_txtfield: UITextField!
    var timerduration = 0
    
    @IBAction func updatetimer(_ sender: UIDatePicker) {
        timerduration = Int(self.datepicker.countDownDuration)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let destinationVC2 = segue.destination as! GameViewController
        destinationVC.firstVCtext = changename_txtfield.text!
        destinationVC2.timer_duration = timerduration
        // Pass the selected object to the new view controller.
    }
    
}
