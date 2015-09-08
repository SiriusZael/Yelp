//
//  BusinessCell.swift
//  Yelp
//
//  Created by Matt Rucker on 9/7/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            avatarImageView.setImageWithURL(business.imageURL)
            ratingImageView.setImageWithURL(business.ratingImageURL)
            reviewsLabel.text = business.reviewCount!.stringValue + " reviews"
            categoryLabel.text = business.categories
            distanceLabel.text = business.distance
            addressLabel.text = business.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        addressLabel.preferredMaxLayoutWidth = addressLabel.frame.size.width
        categoryLabel.preferredMaxLayoutWidth = categoryLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        addressLabel.preferredMaxLayoutWidth = addressLabel.frame.size.width
        categoryLabel.preferredMaxLayoutWidth = categoryLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
