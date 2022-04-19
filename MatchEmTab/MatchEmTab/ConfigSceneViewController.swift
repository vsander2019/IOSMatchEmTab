//
//  ConfigSceneViewController.swift
//  MatchEmTab
//
//  Created by Guest User on 4/13/22.
//

import UIKit

class ConfigSceneViewController: UIViewController {
    
    var MatchEmSceneVC : MatchEmSceneViewController?
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print("ConfigVC:\(#function)") // Adjust the message for green
    }

    
    @IBAction func turnOnDarkMode(_ sender: UISwitch) {
        if let mesvc = MatchEmSceneVC, let messv = mesvc.view {
            if(sender.isOn){
            messv.backgroundColor = .black
            mesvc.gameInfoLabel.textColor = .white
            mesvc.gameInfoLabel.backgroundColor = .blue
            }
            else{
                messv.backgroundColor = .systemTeal
                mesvc.gameInfoLabel.textColor = .black
                mesvc.gameInfoLabel.backgroundColor = .systemGray
            }
        }
    }
    
    @IBAction func changeTimer(_ sender: UISlider) {
        
        if let mesvc = MatchEmSceneVC, let messv = mesvc.view {
            mesvc.adjustableGameSpeed = CGFloat(sender.value)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let mesvc = MatchEmSceneVC, let messv = mesvc.view {
            if let mesvc = MatchEmSceneVC, let messv = mesvc.view {
                mesvc.pauseGameRunning()
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("ConfigSceneVC: \(#function)")
        
        if let mesvc = tabBarController?.viewControllers![0] {
        MatchEmSceneVC = (mesvc as! MatchEmSceneViewController)
        
            
        }
        
        
        

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
