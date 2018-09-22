//
//  ViewController.swift
//  charttest
//
//  Created by Quang Nguyen on 9/21/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addButton: TouchTrackingButton!
    
    var elementBeingDragged: ChartElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = 0.1
        scrollView.canCancelContentTouches = false
        imageView.isExclusiveTouch = false
        imageView.isUserInteractionEnabled = true
        scrollView.delegate = self
        addButton.delegate = self
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension ViewController: TouchTrackingButtonDelegate {
    
    func buttonTouched(with touch: UITouch) {
        let location = touch.location(in: imageView)
        let origin = CGPoint(x: location.x + 50, y: location.y + 50)
        let element = ChartElement(frame: CGRect(origin: origin, size: CGSize(width: 100, height: 100)))
        element.isExclusiveTouch = true
        elementBeingDragged = element
        self.imageView.addSubview(element)
    }
    
    func buttonTouchMoved(_ touch: UITouch) {
        if let element = elementBeingDragged {
            let translation  = touch.location(in: imageView)
            element.center = CGPoint(x: translation.x, y: translation.y)
        }
    }
    
    func buttonTouchEnded(_ touch: UITouch) {
        elementBeingDragged = nil
    }
    
}

protocol TouchTrackingButtonDelegate: class {
    func buttonTouched(with touch: UITouch)
    
    func buttonTouchMoved(_ touch: UITouch)
    
    func buttonTouchEnded(_ touch: UITouch)
}

class TouchTrackingButton: UIButton {

    var delegate: TouchTrackingButtonDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        delegate?.buttonTouched(with: touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        delegate?.buttonTouchEnded(touch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        delegate?.buttonTouchMoved(touch)
    }
    
}
