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
    
    override func viewDidLoad() {
        let unityView = UnityGetGLView()
        
        unityView!.translatesAutoresizingMaskIntoConstraints = false;
        let value = UIInterfaceOrientation.landscapeLeft.rawValue;
        UIDevice.current.setValue(value, forKey: "orientation")
        
        self.view.addSubview(unityView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    private func shouldAutorotate() -> Bool {
        return true
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
