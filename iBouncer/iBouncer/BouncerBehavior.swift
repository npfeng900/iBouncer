//
//  BouncerBehavior.swift
//  iBouncer
//
//  Created by Niu Panfeng on 31/12/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class BouncerBehavior: UIDynamicBehavior {
    /** UIGravityBehavior */
    let gravity = UIGravityBehavior()
    /** UICollisionBehavior */
    lazy var collider: UICollisionBehavior = {     // 闭包用来设置Behavior的属性
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true //reference view的bounds为Behavior的Boundary
        return lazilyCreatedCollider
    }()
    /** UIDynamicItemBehavior */
    lazy var blocker: UIDynamicItemBehavior = {
        let lazilyCreatedBlocker = UIDynamicItemBehavior()
        lazilyCreatedBlocker.allowsRotation = true
        lazilyCreatedBlocker.elasticity = 1  //碰撞的弹性
        lazilyCreatedBlocker.friction = 0    //摩擦
        lazilyCreatedBlocker.resistance = 0  //线性阻力
        return lazilyCreatedBlocker
    }()
 
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(blocker)
    }
    
    func addBlockView(block: UIView) {
        dynamicAnimator?.referenceView?.addSubview(block)
        gravity.addItem(block)
        collider.addItem(block)
        blocker.addItem(block)
    }
    
    func removeBlockView(block: UIView) {
        gravity.removeItem(block)
        collider.removeItem(block)
        blocker.removeItem(block)
        block.removeFromSuperview()
    }
    
    func addBarrierPath(path: UIBezierPath, named name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
}
