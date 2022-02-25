//
//  TrasportStopDetailVC.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation
import UIKit


class TransportStopDetailVC: ResizableViewController {
    
    override init(initialHeight: CGFloat) {
        super.init(initialHeight: initialHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
