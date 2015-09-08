//
//  DealCell.swift
//  Yelp
//
//  Created by Matt Rucker on 9/7/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    optional func dealCell(switchCell: DealCell, didChangeValue value: Bool)
}

class DealCell: UITableViewCell {
    weak var delegate: DealCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var dealSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dealSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        delegate?.dealCell?(self, didChangeValue: dealSwitch.on)
    }

}
