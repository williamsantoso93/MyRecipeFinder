//
//  CardTableViewCell.swift
//  MyRecipeFinder
//
//  Created by iOS Dev on 6/7/21.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardBackgroundView.layer.cornerRadius = 10
        cardImageView.layer.cornerRadius = cardImageView.layer.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
