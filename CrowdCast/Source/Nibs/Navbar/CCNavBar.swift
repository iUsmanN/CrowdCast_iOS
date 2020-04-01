//
//  CCNavBar.swift
//  CrowdCast
//
//  Created by Usman on 31/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit

class CCNavBar: UIView {

    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        LoadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        LoadNib()
    }

    private func LoadNib(){
        Bundle.main.loadNibNamed("CCNavBar", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
