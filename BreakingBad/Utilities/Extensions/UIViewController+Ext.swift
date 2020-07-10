//
//  UIViewController+Ext.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlertOnMainThread(message: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }

}
