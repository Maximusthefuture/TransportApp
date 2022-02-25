//
//  PassThroughtView.swift
//  TransportApp
//
//  Created by Maximus on 25.02.2022.
//

import Foundation
import UIKit


class PassThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
}
