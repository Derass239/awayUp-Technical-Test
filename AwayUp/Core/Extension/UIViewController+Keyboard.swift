//
//  UIViewController+Keyboard.swift
//  AwayUp
//
//  Created by Valentin Limagne on 15/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedArroud() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
