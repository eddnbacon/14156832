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
    
    @IBOutlet weak var timerLB: UILabel!
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
    var number = Int(20)
    var gameScore = Int()
    
    func changeShipMovement(){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgAnimation()
        meteorFalling()
        meteorTimer()
        
        hitboxTimer()
        hitboxSpawn()
        
        gameTimer()
        gameLength()
        
        gameScoreTimer()
        
        shipImage.shipDel = self
      
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
        
    }

    func meteorFalling(){
        
        let num = Int(randomNrGen(firstNum: 1, secondNum: 4))
        
        meteor.image = UIImage(named:"Meteor \(num)")
        meteor.frame = CGRect(x:randomNrGen(firstNum: 5, secondNum: 300), y:randomNrGen(firstNum: -40, secondNum: -500), width:50, height: 50)
        
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
        
//        itemBehavior = UIDynamicItemBehavior(items:[meteor, meteor2])
//        itemBehavior.elasticity = 0.4
//        animator.addBehavior(itemBehavior)
        
    }
    
    func hitboxTimer(){
        timer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(ViewController.hitboxSpawn),userInfo:nil, repeats: true )
        
        
    }
    
    func hitboxSpawn(){
        collision.removeAllBoundaries()
        
        let barrier = UIView(frame: CGRect(x: shipImage.center.x-25, y: shipImage.center.y-50, width:50, height: 100))
        //barrier.backgroundColor = UIColor.red
        //view.addSubview(barrier)
        //self.view.bringSubview(toFront: shipImage)
        
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        animator.addBehavior(collision)
        collision.collisionDelegate = self
        
        if(barrier.frame.intersects(meteor.frame)) || (barrier.frame.intersects(meteor2.frame)){
            gameScore = gameScore - 50
            score.text = String(gameScore)
        }
        
    }

    func gameScoreTimer(){
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(ViewController.gameScorefn),userInfo:nil, repeats: true )
    }
    
    func gameScorefn(){
        
        let meteory = meteor.convert(meteor.center, to:self.view)
        let meteor2y = meteor2.convert(meteor.center, to:self.view)
        
        let shipy = shipImage.convert(meteor.center, to:self.view)
        if 	meteory.y >= shipy.y{
            gameScore = gameScore + 10
            score.text = String(gameScore)
        }
        
        if 	meteor2y.y >= shipy.y{
            gameScore = gameScore + 10
            score.text = String(gameScore)
        }
    }
    
    func gameTimer(){
        timer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(ViewController.gameLength),userInfo:nil, repeats: true )    }

    func gameLength(){
        number = number - 1
        
        timerLB.text = String(number)
        
        if number == 0{
            present( UIStoryboard(name: "MenuScreen", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as UIViewController, animated: true, completion: nil)
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

