//
//  CustomButton.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setTitleColor(.gray, for: .normal)
        tintColor = .gray
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let superRect = super.titleRect(forContentRect: contentRect)
        return CGRect(
            x: 0,
            y: contentRect.height - superRect.height,
            width: contentRect.width,
            height: superRect.height
        )
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let superRect = super.imageRect(forContentRect: contentRect)
        return CGRect(
            x: contentRect.width / 2 - superRect.width / 2,
            y: (contentRect.height - titleRect(forContentRect: contentRect).height) / 2 - superRect.height / 2,
            width: superRect.width,
            height: superRect.height
        )
    }
    
    override var intrinsicContentSize: CGSize {
        _ = super.intrinsicContentSize
        guard let image = imageView?.image else { return super.intrinsicContentSize }
        let size = titleLabel?.sizeThatFits(contentRect(forBounds: bounds).size) ?? .zero
        let spacing: CGFloat = 12
        return CGSize(width: max(size.width, image.size.width), height: image.size.height + size.height + spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
   
    }
    
    private func setup() {
        titleLabel?.textAlignment = .center
    }
}
