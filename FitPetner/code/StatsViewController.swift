//
//  StatsViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 12/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var coinslbl: UILabel!
    @IBOutlet weak var pointslbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
    
    var firstVCtext = "NAME"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelbl.text = firstVCtext
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
