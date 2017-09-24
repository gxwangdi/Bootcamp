//
//  BusinessCell.swift
//  Yelp
//
//  Created by Di Wang on 9/24/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    // MARK: Outlet definitions
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name;
            thumbImageView.setImageWith(business.imageURL! as URL)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsCountLabel.text = "\(business.reviewCount!)Reviews"
            ratingImageView.setImageWith(business.ratingImageURL! as URL)
            distanceLabel.text = business.distance;
        }
    }
    
    // MARK: inherited fucntions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 5;
        thumbImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
