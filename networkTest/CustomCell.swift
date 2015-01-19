//
//  CustomCell.swift
//  networkTest
//
//  Created by oky on 2015/01/17.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire


class CustomCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var salesDateLabel: UILabel!
    
    var request:Alamofire.Request?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
        titleLabel.textColor = UIColor.brownColor()
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
