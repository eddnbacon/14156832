//
//  ViewController.swift
//  Gamev3
//
//  Created by Eduard on 18/04/2018.
//  Copyright © 2018 Eduard. All rights reserved.
//

import UIKit
protocol shipDelegate {
    func changeShipMovement()
}


class ViewController: UIViewController, shipDelegate, UICollisionBehaviorDelegate{
    
    func changeShipMovement(){
        
    }
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var shipImage: ShipMovement!
    @IBOutlet weak var bgImage1: UIImageView!
    @IBOutlet weak var bgImage2: UIImageView!
    
    var timer = Timer()
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var collision:UICollisionBehavior!
    var itemBehavior:UIDynamicItemBehavior!
    var meteor = UIImageView(image:nil)
    var meteor2 = UIImageView(image:nil)
    var number = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgAnimation()
        meteorFalling()
        meteorTimer()
        
        hitboxTimer()
        hitboxSpawn()
        
        
        
        shipImage.shipDel = self
      
    
      
        
        // Do any additional setup after loading the view, typically from a nib.
    }

   

    
    
    //Background Animation loop
    func bgAnimation(){
        UIView.animate(withDuration: 5, delay:0.0, options:[UIViewAnimationOptions.repeat, .curveLinear], animations: {
            
            self.bgImage1.center.y += self.view.bounds.height
            self.bgImage2.center.y += self.view.bounds.height
            
        })
    }
    
    func meteorTimer(){
        timer = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(ViewController.meteorFalling),userInfo:nil, repeats: true )
        collision.removeAllBoundaries()
    }
    
    
    func meteorFalling(){
        
        let num = Int(randomNrGen(firstNum: 1, secondNum: 4))
        
        meteor.image = UIImage(named:"Meteor \(num)")
        meteor.frame = CGRect(x:randomNrGen(firstNum: 5, secondNum: 300), y:-50, width:50, height: 50)

        self.view.addSubview(meteor)
        
        meteor2.image = UIImage(named:"Meteor \(num)")
        meteor2.frame = CGRect(x:randomNrGen(firstNum: 5, secondNum: 300), y:-70, width:50, height: 50)
        
        self.view.addSubview(meteor2)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [meteor, meteor2])
        gravity.magnitude = 0.5
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [meteor, meteor2])
        animator.addBehavior(collision)
        collision.collisionDelegate = self
        
        itemBehavior = UIDynamicItemBehavior(items:[meteor, meteor2])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
        
    }
    
    func hitboxTimer(){
        timer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(ViewController.hitboxSpawn),userInfo:nil, repeats: true )
        
    }
    
    func hitboxSpawn(){
        let barrier = UIView(frame: CGRect(x: shipImage.center.x-25, y: shipImage.center.y-50, width:50, height: 100))
        //barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        self.view.bringSubview(toFront: shipImage)
        
        
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        animator.addBehavior(collision)
        collision.collisionDelegate = self
        
        if(barrier.frame.intersects(meteor.frame)){
            
        }else if(barrier.frame.intersects(meteor2.frame)){
            
        }
      
    }
    
    
    func gameTimer(){
        timer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(ViewController.gameLength),userInfo:nil, repeats: true )    }
    
    func gameLength(){
        number = 20 - 1
        if number == 0{
            present
        }
    }
    
    func randomNrGen (firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs (firstNum - secondNum) + min(firstNum,secondNum);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}//end

