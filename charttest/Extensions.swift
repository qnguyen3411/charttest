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
