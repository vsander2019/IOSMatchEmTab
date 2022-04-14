//
//  ConfigSceneViewController.swift
//  MatchEmTab
//
//  Created by Guest User on 4/13/22.
//

import UIKit

class ConfigSceneViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print("ConfigVC:\(#function)") // Adjust the message for green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConfigSceneVC: \(#function)")

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var orangeSubView: UIView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
