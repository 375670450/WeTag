//
//  InfoTableViewController.swift
//  WeTagUnity
//
//  Created by 冯丽文 on 2017/6/13.
//  Copyright © 2017年 cs. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    var allnames: Dictionary<Int, [String]>?
    var adHeaders:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.allnames = [
         0:[String]([
         "版本号",
         "隐私声明",
         "服务协议"]),
         1:[String]([
         "反馈",
         "关于我们"])
         ]
         
         self.adHeaders = ["产品信息","作者信息"]
         
         self.tableView = UITableView(frame: self.view.frame, style: .grouped)
         self.tableView!.delegate = self
         self.tableView!.dataSource = self
         
         
         self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "InfoTableViewCell")
         self.view.addSubview(self.tableView!)*/
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    /*
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     let data = self.allnames?[section]
     return data!.count
     }
     
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return self.adHeaders?[section]
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     // Table view cells are reused and should be dequeued using a cell identifier.
     let cellIdentifier = "InfoTableViewCell"
     
     let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
     let secno = indexPath.section
     var data = self.allnames?[secno]
     cell.textLabel?.text = data![indexPath.row]
     
     return cell
     }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        let itemString = [
            0:[String]([
                "v1.0",
                "仅限使用",
                "服务协议"]),
            1:[String]([
                "反馈请联系",
                "浙大学生"])
        ];
        let alertController = UIAlertController(title: "提示", message: "\(itemString[indexPath.section]![indexPath.row])", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "yes", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     func tabelView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     self.tableView!.deselectRow(at: indexPath, animated: true)
     let itemString = self.allname
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
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
    
}
