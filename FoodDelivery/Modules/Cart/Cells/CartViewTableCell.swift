//
//  CartViewTableCell.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 6/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class CartViewTableCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.productImage.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    // MARK: Class Methods
    @objc
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: CartViewTableCell.classForCoder()),
                     bundle: .main)
    }
    
    @objc
    class func reuseIdentifier() -> String {
        return String(describing: CartViewTableCell.classForCoder())
    }
}
