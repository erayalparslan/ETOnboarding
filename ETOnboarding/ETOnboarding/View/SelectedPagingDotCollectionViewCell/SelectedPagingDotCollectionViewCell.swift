//
//  SelectedPagingDotCollectionViewCell.swift
//
//  Created by Eray Alparslan on 16.03.2020.
//

import UIKit

public class SelectedPagingDotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }

    
    public func updateCellWith(value: Int){
        titleLabel.text = "\(value)"
    }
}
