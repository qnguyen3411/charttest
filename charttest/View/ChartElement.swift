//
//  ChartElement.swift
//  charttest
//
//  Created by Quang Nguyen on 9/22/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//
import UIKit

class ChartElement: UIView {
    
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(detectTap))
        self.gestureRecognizers = [panRecognizer, tapRecognizer]
        
        //randomize view color
        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    @objc func detectTap(recognizer: UITapGestureRecognizer) {
        print("TAPPED")
    }
    
    @objc func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.location(in: self.superview)
        self.center = CGPoint(x: translation.x,y: translation.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
