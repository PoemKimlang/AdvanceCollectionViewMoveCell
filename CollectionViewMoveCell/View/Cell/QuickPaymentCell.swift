//
//  QuickPaymentCell.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import UIKit

class QuickPaymentCell: UICollectionViewCell {

    @IBOutlet weak var icon             : UIImageView!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var backgroundImage  : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImage.layer.cornerRadius = 15
    }
    func configCell(data: HomeData.QuickPayment){
        titleLabel.text         = data.title
        icon.image              = UIImage(named: data.icon ?? "")
        backgroundImage.image   = UIImage(named: data.background ?? "")
    }

}
