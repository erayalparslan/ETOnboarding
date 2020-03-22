//
//  StandartButton.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 21.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

protocol StandartButtonDelegate {
    func didButtonClicked()
}

class StandartButton: UIView{
    @IBOutlet weak var button: UIButton!
    var delegate: StandartButtonDelegate?
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        loadView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }

    fileprivate func loadView() {
        let bundle = Bundle(for: StandartButton.self)
        let view = bundle.loadNibNamed(StandartButton.className, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        sendSubviewToBack(view)
    }
    
    
    //MARK: Helper Methods
    public func setTitle(value: String){
        guard button != nil else { return }
        button.setTitle(value, for: .normal)
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        delegate?.didButtonClicked()
    }
}
