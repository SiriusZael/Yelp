//
//  DropdownCell.swift
//  Yelp
//
//  Created by Matt Rucker on 9/8/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class DropdownCell: UITableViewCell {

    @IBOutlet weak var unSelectImageView: UIImageView!
    @IBOutlet weak var downPointerImageView: UIImageView!
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var section: Int = -1
    var row: Int = -1
    var sectionExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
