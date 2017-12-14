//
//  Popup.swift
//  Fitpetner
//
//  Created by Arnaud DELLINGER on 12/12/2017.
//  Copyright © 2017 Xenia Lin. All rights reserved.
//

import Foundation
import UIKit

class Popup {
    var dialog: UIAlertController!
    var parent: UIViewController!
    
    init(parent: UIViewController, title: String, content: String, okActionTitle: String) {
        self.parent = parent
        
        self.dialog = UIAlertController(
            title: title,
            message: content,
            preferredStyle: UIAlertControllerStyle.actionSheet
        )
        
        let cancelAction = UIAlertAction(title: okActionTitle, style: UIAlertActionStyle.cancel)
        self.dialog.addAction(cancelAction)
    }
    
    func show() {
        self.parent.present(self.dialog, animated: true, completion: nil)
    }
}
