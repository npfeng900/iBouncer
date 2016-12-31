//
//  ViewController.swift
//  iBouncer
//
//  Created by Niu Panfeng on 31/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // for expediency sake
    
    /** bouncer */
    lazy var animator: UIDynamicAnimator = {UIDynamicAnimator(referenceView: self.view)}()
    let bouncer = BouncerBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }
    
    /** Block */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if redBlock == nil {
            redBlock = addBlock()
            bouncer.addBlockView(redBlock!)
        }
        
        let motionManager = AppDelegate.Motion.Manager
        if motionManager.accelerometerAvailable {
            motionManager.accelerometerUpdateInterval = Constant.IntervalTime
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, _) -> Void in
                self.bouncer.gravity.gravityDirection = CGVector(dx: data!.acceleration.x, dy: -data!.acceleration.y)
            }
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    
    var redBlock: UIView? { didSet{ redBlock?.backgroundColor = UIColor.redColor() } }
    
    struct Constant {
        static let BlockSize = CGSize(width: 40, height: 40)
        static let IntervalTime = 1.0/30.0
    }
    
    private func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPointZero, size: Constant.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(block)
        return block
    }

}

