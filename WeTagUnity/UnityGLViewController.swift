//
//  UnityGLViewController.swift
//  WeTagUnity
//
//  Created by cs on 2017/6/2.
//  Copyright © 2017年 cs. All rights reserved.
//

import UIKit
import GLKit
class UnityGLViewController: UIViewController {

    @IBOutlet var glVIew: GLKView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        let unityView = UnityGetGLView()
        
        unityView!.translatesAutoresizingMaskIntoConstraints = false;
        let value = UIInterfaceOrientation.landscapeLeft.rawValue;
        UIDevice.current.setValue(value, forKey: "orientation")
        
        self.view.addSubview(unityView!)
    }
    
    @IBAction func PopUnityView(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
//    
    
    
    private func shouldAutorotate() -> Bool {
        return false
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
