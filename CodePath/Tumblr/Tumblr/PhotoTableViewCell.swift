//
//  PhotoTableViewCell.swift
//  Tumblr
//
//  Created by Di Wang on 9/13/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            titleLabel.textColor = UIColor.yellow;
            synopsisLabel.textColor = UIColor.yellow;
            self.backgroundColor = UIColor.blue;
        } else {
            titleLabel.textColor = UIColor.white;
            synopsisLabel.textColor = UIColor.white;
            self.backgroundColor = UIColor.black;
        }
    }

}
