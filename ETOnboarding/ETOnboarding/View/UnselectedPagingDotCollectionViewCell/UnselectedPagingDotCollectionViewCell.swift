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
    
    public func updateCellWith(value: Int, isFirst: Bool = false, isLast: Bool = false){
        titleLabel.text = "\(value)"
        leftDotView.alpha = isFirst ? 0 : 1
        rightDotView.alpha = isLast ? 0 : 1
    }
}
