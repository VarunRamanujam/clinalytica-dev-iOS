//
//  RUITableViewCell.swift
//  Hospital
//
//  Created by Shridhar on 2/4/17.
//
//

import UIKit

class RUITableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initializeRUITableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initializeRUITableViewCell() {
        self.selectionStyle = .none
    }

}
