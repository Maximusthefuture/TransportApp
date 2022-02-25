//
//  ButtonWithLabel.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation
import UIKit


class ButtomWithLabel: UIButton {
    
    
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label?.textAlignment = .center
    }
    
    func setLabel(label: UILabel) {
        addSubview(label)
//        label.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil)
//        label.frame = CGRect(origin: .init(x: 0, y: 100), size: .zero)
        label.bounds.insetBy(dx: 0, dy: 30)
        
    }
    
    
}
