//
//  DottedVerticalView.swift
//  charttest
//
//  Created by Quang Nguyen on 9/22/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit

@IBDesignable class DottedVertical: UIView {
    
    @IBInspectable var dotColor: UIColor = UIColor.lightGray
    @IBInspectable var lowerHalfOnly: Bool = false
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        // say you want 8 dots, with perfect fenceposting:
        let totalCount = 8 + 8 - 1
        let fullHeight = bounds.size.height
        let itemLength = fullHeight / CGFloat(totalCount)
        
        let path = UIBezierPath(rect: self.bounds)

        path.lineWidth = 4
        
        let dashes: [CGFloat] = [itemLength, itemLength]
        path.setLineDash(dashes, count: dashes.count, phase: 0)
        
        // for ROUNDED dots, simply change to....
        //let dashes: [CGFloat] = [0.0, itemLength * 2.0]
        //path.lineCapStyle = CGLineCap.round
        
        dotColor.setStroke()
        path.stroke()
        
    }
}
