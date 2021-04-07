//
//  FoodItemTableViewCell.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 4/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.priceButton.roundedConrner(radius: 20.0)
        self.foodImage.contentMode = UIView.ContentMode.scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Class Methods
    @objc
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: FoodItemTableViewCell.classForCoder()),
                     bundle: .main)
    }

    @objc
    class func reuseIdentifier() -> String {
        return String(describing: FoodItemTableViewCell.classForCoder())
    }
}
