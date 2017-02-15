//
//  RUITableViewCell.swift
//  Hospital
//
//  Created by Shridhar on 2/4/17.
//
//

import UIKit

class RUITableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeRUITableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
    }

}
