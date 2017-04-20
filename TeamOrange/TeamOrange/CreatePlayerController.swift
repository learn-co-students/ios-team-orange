//
//  CreatePlayerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/20/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class CreatePlayerController: UIViewController {
    
    let myView = CreatePlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAndConstrain(view: self.myView)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.buildStaticNavBar()
        self.navigationItem.title = "Create Player"
        self.myView.genderPicker.delegate = self
        self.myView.genderPicker.dataSource = self
    }
}

extension CreatePlayerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return row == 0 ? NSAttributedString(string: "Male") : NSAttributedString(string: "Female")
    }
}
