//
//  SelectedPagingDotCollectionViewCell.swift
//
//  Created by Eray Alparslan on 16.03.2020.
//

import UIKit

public class SelectedPagingDotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftArrowImageView: UIImageView!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }

    
    public func updateCellWith(value: Int, isDarkFontEnabled: Bool = false){
        titleLabel.text = "\(value)"
        
        if isDarkFontEnabled{
            titleLabel.textColor = .black
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1955532962)
            leftArrowImageView.tintColor = .white
            rightArrowImageView.tintColor = .white
        }
        else{
            titleLabel.textColor = .white
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
            leftArrowImageView.tintColor = .lightGray
            rightArrowImageView.tintColor = .lightGray
        }
    }
}
