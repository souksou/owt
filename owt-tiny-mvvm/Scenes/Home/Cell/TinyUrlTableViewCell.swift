//
//  TinyUrlTableViewCell.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit

class TinyUrlTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var orignalUrl: UILabel!
    @IBOutlet var transformUrl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
