//
//  UnselectedPagingDotCollectionViewCell.swift
//
//  Created by Eray Alparslan on 16.03.2020.
//

import UIKit

public class UnselectedPagingDotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftDotView: UIView!
    @IBOutlet weak var rightDotView: UIView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        leftDotView.layer.cornerRadius  = leftDotView.frame.height/2
        rightDotView.layer.cornerRadius = rightDotView.frame.height/2
    }
    
    public func updateCellWith(value: Int, isDarkFontEnabled: Bool = false, isFirst: Bool = false, isLast: Bool = false){
        titleLabel.text = "\(value)"
        leftDotView.alpha = isFirst ? 0 : 1
        rightDotView.alpha = isLast ? 0 : 1
        if isDarkFontEnabled {
            titleLabel.textColor = .black
            leftDotView.backgroundColor = #colorLiteral(red: 0.2307935251, green: 0.5, blue: 0.2447534152, alpha: 0.35)
            rightDotView.backgroundColor = #colorLiteral(red: 0.2307935251, green: 0.5, blue: 0.2447534152, alpha: 0.35)
        }
    }
}
