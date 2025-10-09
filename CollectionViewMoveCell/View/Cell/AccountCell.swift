//
//  AccountCell.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import UIKit

class AccountCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel   : UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containView  : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containView.layer.cornerRadius = 15
    }
    func configCell(data: HomeData.Account){
        titleLabel.text     = data.title
        iconImageView.image = UIImage(named: data.icon ?? "")
    }

}
