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
        
        
        //self.dismiss(animated: true, completion:nil)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : ViewController=mainStoryboard.instantiateViewController(withIdentifier: "mainstory") as! ViewController
        gameScore = 0
        self.present(vc, animated: true, completion: nil)
        
        
    }

    @IBOutlet weak var lastScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastScore.text = String(gameScore)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
