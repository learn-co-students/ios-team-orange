//
//  CompletionCell.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class CompletionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = BlurView(blurEffect: .dark)
        self.backgroundView?.alpha = 0.5
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
