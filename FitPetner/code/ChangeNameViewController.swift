//
//  ChangeNameViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController {
    
    @IBOutlet weak var changename_txtfield: UITextField!
    
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
        destinationVC.firstVCtext = changename_txtfield.text!
        // Pass the selected object to the new view controller.
    }
    
}
