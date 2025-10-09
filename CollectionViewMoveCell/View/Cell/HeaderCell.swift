//
//  HeaderCell.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var containView  : UIView!
    @IBOutlet weak var nameLabel    : UILabel!
    @IBOutlet weak var sendButton   : UIButton!
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var eyeButton    : UIButton!
    @IBOutlet weak var amountLabel  : UILabel!
    
    private var headerData: HomeData.Header?
    private var blurView: UIVisualEffectView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containView.layer.cornerRadius = 15
        
        eyeButton.addTarget(self, action: #selector(toggleAmountVisibility), for: .touchUpInside)
    }
    
    func configCell(data: HomeData.Header) {
        self.headerData = data
        
        nameLabel.text = data.name
        amountLabel.text = data.amount
        containView.backgroundColor = UIColor(hexString: data.color ?? "#FFFFFF")
        
        // Update UI for amount blur and eye icon
        updateAmountBlur(isHidden: data.hideAmount)
    }
    
    @objc private func toggleAmountVisibility() {
        guard var data = headerData else { return }
        data.hideAmount.toggle()
        headerData = data
        
        // Update blur and icon
        updateAmountBlur(isHidden: data.hideAmount)
    }
    
    private func updateAmountBlur(isHidden: Bool) {
        // Update eye icon
        let imageName = isHidden ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        if isHidden {
            addBlurOverAmount()
        } else {
            removeBlur()
        }
    }
    
    private func addBlurOverAmount() {
        // Avoid duplicate blur layers
        removeBlur()
        
        // Create blur effect
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.layer.cornerRadius = 5
        blur.clipsToBounds = true
        amountLabel.addSubview(blur)
        blurView = blur
        
        // Pin blur to amount label
        NSLayoutConstraint.activate([
            blur.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
            blur.topAnchor.constraint(equalTo: amountLabel.topAnchor),
            blur.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor)
        ])
    }
    
    private func removeBlur() {
        blurView?.removeFromSuperview()
        blurView = nil
    }
}
