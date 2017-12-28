//
//  PUViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 28/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import UIKit

class PUViewController: UIViewController{
    var coins = 0
    var level = 0
    var points = 0
    var mute: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //send data to stats screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! StatsViewController
        destination.level = level
        destination.coins = coins
        destination.points = points
        destination.mute = mute
        // Pass the selected object to the new view controller.
    }
    
}

