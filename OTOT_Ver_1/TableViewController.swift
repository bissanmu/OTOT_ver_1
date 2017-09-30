//
//  TableViewController.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 9. 28..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var messageArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image : UIImage(named : "bg.png"))
        var message = Message()
        
        message.writer = "안선우"
        message.title = "테스트1입니다."
        message.previewMessage = "언제 다하냐 .."
        messageArray.append(message)
        message = Message()
        message.writer = "최대은"
        message.title = "테스트2입니다."
        message.previewMessage = "서버 좀 해주세여.."
        messageArray.append(message)
        
       self.navigationItem.titleView = UIImageView(image: UIImage(named : "ico-sidebar.png"))
        navigationItem.titleView?.sizeToFit()
        
        
        
    }
    
    func fbButtonPressed() {
        print("Share to fb")
    }
    @objc
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageArray.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named : "ico-sidebar.png"), for: .normal)
//        button.setBackgroundImage(UIImage(named : "ico_sidebar.png"), for: .normal)
//        button.setTitle("Categories", for: .normal)
//        button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
//        button.contentMode = .scaleAspectFit
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        let vw = UIView()
        vw.backgroundColor = UIColor.orange
        let image = UIImageView(image : UIImage(named : "ico-sidebar.png"))
        image.frame = CGRect(x:5, y:5, width :35, height :35)
            
        view.addSubview(image)
        
        return vw
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PreviewMessageCell
        
        
        
        
        cell.writer.text = messageArray[indexPath.row].writer
        cell.previewTitle.text = messageArray[indexPath.row].title
        cell.previewContent.text = messageArray[indexPath.row].previewMessage
        cell.messageBoxImage.image =  UIImage(named : "msg.png")
        //cell.writer.text = "안선우"
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
//        cell.addGestureRecognizer(tapGesture)
        // Configure the cell...

        return cell
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
    {
        let myCell = sender.view as! PreviewMessageCell
        myCell.messageBoxImage.image = UIImage(named: "imageTapped.jpg")
    }

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

class Message {
    var writer:String = ""
    var title:String = ""
    var previewMessage:String = ""
}
