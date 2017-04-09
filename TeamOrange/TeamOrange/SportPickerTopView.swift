//
//  SportPickerTopView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerTopView: BlurView {
    
    let tableView = UITableView(frame: CGRect.zero)
    
    override init(blurEffect: UIBlurEffectStyle) {
        super.init(blurEffect: blurEffect)
        self.buildTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildTableView() {
        self.tableView.register(ChosenSportTableCell.self, forCellReuseIdentifier: "sportCell")
        self.tableView.addAndConstrainToEdges(of: self)
        self.tableView.backgroundColor = UIColor.clear
    }
    
}
