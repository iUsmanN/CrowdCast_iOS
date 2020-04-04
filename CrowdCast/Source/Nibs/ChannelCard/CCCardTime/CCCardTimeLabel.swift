//
//  CCCardTimeLabel.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCCardTimeLabel: UILabel {
    
    @IBOutlet var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CCCardTimeLabel", owner: self, options: nil)
        addSubview(timeLabel)
        timeLabel.frame = self.bounds
        timeLabel.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setView(inputColor: UIColor?) {
        timeLabel.textColor = inputColor
    }

}
