//
//  MatchEmSceneControllerViewController.swift
//  MatchEmTab
//
//  Created by Guest User on 4/13/22.
//

import UIKit

class MatchEmSceneControllerViewController: UIViewController {
    
    var seeBadge = false
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print("MatchEmSceneVC:\(#function)") // Adjust the message for green
    }

    @IBAction func toggleBadge(_ sender: Any) {
        if seeBadge == false {
        seeBadge = true
        tabBarItem.badgeValue = "Hi"
        }
        else {
        seeBadge = false
        tabBarItem.badgeValue = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MatchEmSceneVC: \(#function)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
