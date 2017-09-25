//
//  CascadingCell.swift
//  Yelp
//
//  Created by Di Wang on 9/24/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

@objc protocel CascadingCellDelegate {
    @objc optional func onDropDownMenuItemSelected(CascadingCell: cascadingCell, didChangeValue  value:Int)
}

class CascadingCell: UITableViewCell {

    @IBOutlet weak var cascadingLabel: UILabel!
    weak var delegate : CascadingCellDelegate;
    
    @IBAction func onDropDownClicked(_ sender: Any) {
        //TODO: expand the corresponding drop down table view.
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
