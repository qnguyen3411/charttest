//
//  Extensions.swift
//  charttest
//
//  Created by Quang Nguyen on 9/22/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    func isContained(in view: UIView) -> Bool {
        let frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
        return frame.contains(self.location(in: view))
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(),
                                                      metrics: nil, views: viewsDictionary))
    }
}

extension CGRect {
    enum Edge {
        case left
        case top
        case right
        case bottom
    }
    
    func getMidpoint(forEdge edge: Edge) -> CGPoint {
        switch edge {
        case .left:
            return CGPoint(x: self.origin.x, y: self.origin.y + self.height / 2)
        case .top:
            return CGPoint(x: self.origin.x + self.width / 2, y: self.origin.y)
        case .right:
            return CGPoint(x: self.origin.x + self.width, y: self.origin.y + self.height / 2)
        default:
            return CGPoint(x: self.origin.x + self.width / 2, y: self.origin.y + self.height)
        }
    }
}
