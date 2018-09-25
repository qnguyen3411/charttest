//
//  ChartElement.swift
//  charttest
//
//  Created by Quang Nguyen on 9/22/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//
import UIKit

protocol ChartElementDelegate {
    func elementTapped(_ element: ChartElement)
}


class ChartElement: UIView {
    
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    var links: [ChartLink] = []
    var delegate: ChartElementDelegate?
    
    let defaultEmptyView: DottedVertical = {
        let dotted = DottedVertical()
        dotted.translatesAutoresizingMaskIntoConstraints = true
        return dotted
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(detectTap))
        self.gestureRecognizers = [panRecognizer, tapRecognizer]
        self.backgroundColor = .clear
        
        addSubview(defaultEmptyView)
        addConstraintsWithFormat("V:|[v0]|", views: defaultEmptyView)
        addConstraintsWithFormat("H:|[v0]|", views: defaultEmptyView)

    }
    
    @objc func detectTap(recognizer: UITapGestureRecognizer) {
        delegate?.elementTapped(self)
    }
    
    @objc func detectPan(recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.location(in: self.superview)
        self.center = CGPoint(x: translation.x,y: translation.y)
        
        for link in links {
            link.updateLine()
        }
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
