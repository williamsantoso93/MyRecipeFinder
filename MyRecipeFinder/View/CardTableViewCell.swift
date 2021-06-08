//
//  CardTableViewCell.swift
//  MyRecipeFinder
//
//  Created by iOS Dev on 6/7/21.
//

import UIKit

protocol CardOnTapDelegate {
    func cardOnTap(index: Int)
}

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var delegate: CardOnTapDelegate?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardBackgroundView.layer.cornerRadius = 10
        cardImageView.layer.cornerRadius = cardImageView.layer.frame.width/2
        indicator.startAnimating()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        cardBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        delegate?.cardOnTap(index: index)
    }
    
}
