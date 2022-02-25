//
//  LineUIView.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation
import UIKit


class LineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
