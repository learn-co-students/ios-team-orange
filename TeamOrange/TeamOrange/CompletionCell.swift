//
//  CompletionCell.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class CompletionCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let blurView = BlurView(blurEffect: .dark)
        blurView.alpha = 0.5
        blurView.addAndConstrainToEdges(of: self.contentView)
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.textLabel?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
