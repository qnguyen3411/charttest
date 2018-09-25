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
    
    var currTool = ""
    var elementBeingDragged: ChartElement?
    var elementPairToJoin: [ChartElement] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = UIScreen.main.bounds.height / imageView.frame.height
        scrollView.canCancelContentTouches = false
        imageView.isExclusiveTouch = false
        imageView.isUserInteractionEnabled = true
        scrollView.delegate = self
        addButton.delegate = self
        
        let element1 = ChartElement(frame: CGRect(origin: CGPoint(x: 300, y: 100), size: CGSize(width: 100, height: 150)))
        let element2 = ChartElement(frame: CGRect(origin: CGPoint(x: 100, y: 150), size: CGSize(width: 100, height: 150)))
        element1.delegate = self
        element2.delegate = self
        element1.backgroundColor = .orange
        element2.backgroundColor = .green
        self.imageView.addSubview(element1)
        self.imageView.addSubview(element2)
        link(element1, element2)
    }
    
    
    @IBAction func linkButtonPressed(_ sender: UIButton) {
        currTool = "link"
    }
    
    func link(_ elementA: ChartElement, _ elementB: ChartElement) {
        let newLink = ChartLink(srcView: elementA, destView: elementB)
        newLink.layer.zPosition = -1
        self.imageView.addSubview(newLink)
        elementA.links.append(newLink)
        elementB.links.append(newLink)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

extension ViewController: ChartElementDelegate {
    
    func elementTapped(_ element: ChartElement) {
        guard currTool == "link" else { return }
        elementPairToJoin.append(element)
        if elementPairToJoin.count == 2 {
            if elementPairToJoin[0] !== elementPairToJoin[1] {
                link(elementPairToJoin[0], elementPairToJoin[1])
                elementPairToJoin = []
            } else {
                _ = elementPairToJoin.popLast()
            }
        }
    }
    
}

extension ViewController: TouchTrackingButtonDelegate {
    
    func buttonTouched(with touch: UITouch) {
        let location = touch.location(in: imageView)
        let origin = CGPoint(x: location.x + 50, y: location.y + 50)
        let element = ChartElement(frame: CGRect(origin: origin, size: CGSize(width: 100, height: 150)))
        element.delegate = self
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

