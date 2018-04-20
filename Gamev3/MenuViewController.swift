//
//  MenuViewController.swift
//  Gamev3
//
//  Created by ep15aam on 19/04/2018.
//  Copyright © 2018 Eduard. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func play(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : ViewController=mainStoryboard.instantiateViewController(withIdentifier: "mainstory") as! ViewController
        gameScore = 0
        self.present(vc, animated: true, completion: nil)
    }

    @IBOutlet weak var lastScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastScore.text = String(gameScore)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
