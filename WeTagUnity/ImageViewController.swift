//
//  ImageViewController.swift
//  WeTagUnity
//
//  Created by 冯丽文 on 2017/6/13.
//  Copyright © 2017年 cs. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    public var pickedImage: UIImage!
    var ratio: CGFloat = 0.0
    var celebraty: String = ""
    var wikiInfo: String = ""
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = pickedImage;
        //        searchWiki(name: "Jack%20Ma");
        recognize(image: pickedImage)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    // ============ Web API Functions ===========
    
    private var mediaWikiURL = "http://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrlimit=10&prop=extracts&exintro&explaintext&gsrsearch=";
    
    private var cognitiveURL =  "https://api.cognitive.azure.cn/vision/v1.0/models/celebrities/analyze"
    
    private var auth = "974c0cbdf8b244c28024aaab33ab2fdb"
    
    
    func searchWiki(name: String) {
        let url = mediaWikiURL + name;
        
        
        var request = URLRequest(url: URL(string: url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data, error == nil else{
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            print("c")
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            if let json = try? JSONSerialization.jsonObject(with: (responseString?.data(using: .utf8))!) as? [String:Any]
                ,let query = json?["query"] as? [String:Any]
                ,let pages = query["pages"] as? [String:Any]
            {
                //                print("response json = \(pages)")
                
                for (key, _value) in pages{
                    let value = _value as? [String:Any]
//                    print("_value = \(_value)")
                    
                    let index = value?["index"] as? Int
//                    print("key = \(key)")
                    if index == 1 {
                        // 异步函数不方便返回值，因此暂时把查询结果直接写到对象的私有成员里，之后修改UI显示的文字为wikiInfo字符串
                        self.wikiInfo = (value?["extract"] as? String)!
                        print("wiki:\(self.wikiInfo)")
                        
                        
                        
                    }
                }
            } else {
                print("bad json - do some recovery")
            }
            
        }
        
        task.resume()
    }
    
    public func recognize(image: UIImage){
        let quality: CGFloat = 0.3
        if let imageData = UIImageJPEGRepresentation(image, quality) {
            
            var request = URLRequest(url: URL(string: cognitiveURL)!)
            request.addValue(auth, forHTTPHeaderField: "Ocp-Apim-Subscription-Key");
            request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
            //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = imageData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else{
                    print("error=\(error)")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                // TODO: 解析response字符串获取celebrities数组内容并更新显示tag
                
                if let json = try? JSONSerialization.jsonObject(with: (responseString?.data(using: .utf8))!) as? [String:Any]{
                    if let result = json?["result"] as? [String:Any]
                        ,let celebrities = result["celebrities"] as? [[String:Any]]{
                        //                print("response json = \(pages)")
                        for object in celebrities {
                            /*
                             {
                             "name": "ROBERT DOWNEY JR.",
                             "faceRectangle": {
                             "left": 483,
                             "top": 174,
                             "width": 52,
                             "height": 52
                             }
                             }
                             */
                            
                            let name = object["name"] as? String
                            self.celebraty = name!
                            let faceRectangle = object["faceRectangle"] as? [String:Any]
                            var top = faceRectangle?["top"] as? CGFloat
                            var left = faceRectangle?["left"] as? CGFloat
                            var width = faceRectangle?["width"] as? CGFloat
                            var height = faceRectangle?["height"] as? CGFloat
                            
                            //calculate the actual number
                            self.ratio = self.photoImageView.frame.width / self.pickedImage.size.width
                            top = top! * self.ratio
                            left = left! * self.ratio
                            width = width! * self.ratio
                            height = height! * self.ratio
                            
                            //框住人脸
//
                            let labelX = self.photoImageView.center.x + left! - self.photoImageView.frame.width / 2
                            let labelY = self.photoImageView.center.y + top! - self.pickedImage.size.height * self.ratio / 2
                            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: width!, height: height!))
                            label.layer.borderWidth = 2
                            label.layer.borderColor = UIColor.red.cgColor
                                                        label.backgroundColor = UIColor.clear
                            self.view.addSubview(label)
                                                        //显示tag
                            let buttonY = labelY - 60
                            let buttonX = labelX
                            let button = UIButton(frame: CGRect(x: buttonX, y: buttonY , width: 200, height: 50))
                            //let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
                            button.setTitle(name, for: .normal)
                            button.backgroundColor = UIColor.gray
                            button.setTitleColor(UIColor.black, for: .normal)
                            button.addTarget(self, action: #selector(self.tapped(sender:)), for: .touchUpInside)
                            
                            self.view.addSubview(button)
                        }
                    }else{
                        if let message = json?["message"] as? String{   // 请求的错误信息，如"Input image is too large."
                            print("request error = \(message)")
                        }else{
                            print("bad json - do some recovery")
                        }
                    }
                } else {
                    print("bad json - do some recovery")
                }
                
            }
            task.resume()
        }
        
    }
    
    func tapped(sender: UIButton) {
        let labelY = Int(self.view.frame.maxY) - 200
        let labelWidth = Int(self.view.frame.width)
        let label = UILabel(frame: CGRect(x: 0, y: labelY, width: labelWidth, height: 200))
        label.backgroundColor = UIColor.white
        searchWiki(name: celebraty)
//        print("wiki:\(self.wikiInfo)")
        label.text = self.wikiInfo
        
        self.view.addSubview(label)
    }
    
    
}


