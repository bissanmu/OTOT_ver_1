//
//  TableViewController.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 9. 28..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    var messageArray : [Message] = [Message]()
    var filterMessages : [Message] = [Message]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        filterMessages = messageArray.filter{ message in
            return message.content.contains(searchText)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image : UIImage(named : "bg.png"))
        self.title = "소식 보기"
        open.target = revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        retrievemessages()
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.orange
        refreshControl?.backgroundColor = UIColor.darkGray
        refreshControl?.attributedTitle = NSAttributedString(string: "Fetching More Data...", attributes: [NSAttributedStringKey.foregroundColor : refreshControl?.tintColor])
        refreshControl?.addTarget(self, action: #selector(TableViewController.refreshData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search here ..."
        tableView.tableHeaderView = searchController.searchBar
        //tableView.tableFooterView = searchController.searchBar
        
    }
    
    @objc func refreshData(){
        tableView.reloadData()
        print("reload")
        refreshControl?.endRefreshing()
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < -150 {
            refreshControl?.attributedTitle = NSAttributedString(string: "불러오기가 완료되었습니다. 이제 놓으셔도 됩니다 :)", attributes: [NSAttributedStringKey.foregroundColor : refreshControl?.tintColor])
        } else {
            refreshControl?.attributedTitle = NSAttributedString(string: "Fetcing More Data...", attributes: [NSAttributedStringKey.foregroundColor : refreshControl?.tintColor])
        }
        refreshControl?.backgroundColor = UIColor.darkGray
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
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterMessages.count
        }
        return messageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PreviewMessageCell
        var urlImage:String = ""
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.previewDate.text = filterMessages[indexPath.row].insDate
            cell.location.text = filterMessages[indexPath.row].location
            cell.previewTitle.text = filterMessages[indexPath.row].title
            cell.previewContent.text = filterMessages[indexPath.row].previewMessage
            urlImage = filterMessages[indexPath.row].image
            cell.messageBoxImage.image =  UIImage(named : "msg.png")
            cell.titleImage.layer.cornerRadius = cell.titleImage.frame.size.width/2
            cell.titleImage.clipsToBounds = true
        } else {
            cell.previewDate.text = messageArray[indexPath.row].insDate
            cell.location.text = messageArray[indexPath.row].location
            cell.previewTitle.text = messageArray[indexPath.row].title
            cell.previewContent.text = messageArray[indexPath.row].previewMessage
            urlImage = messageArray[indexPath.row].image
            cell.messageBoxImage.image =  UIImage(named : "msg.png")
            cell.titleImage.layer.cornerRadius = cell.titleImage.frame.size.width/2
            cell.titleImage.clipsToBounds = true
        }
        
        //cell.titleImage.image = UIImage(named : messageArray[indexPath.row].image)
        let URL_IMAGE = URL(string : urlImage)
        let session = URLSession(configuration : .default)
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    //checking if the response contains an image
                    if let imageData = data {
                        //getting the image
                        let image = UIImage(data: imageData)
                        //displaying the image
                        DispatchQueue.main.async(execute: {
                        cell.titleImage.image = image
                            })
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        //starting the download task
        getImageFromUrl.resume()

        return cell
    }
    
    func retrievemessages(){
        
        let messageDB = FIRDatabase.database().reference().child("Messages")
        
        messageDB.observe(.childAdded, with : {(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let title = snapshotValue["title"]!
            let content = snapshotValue["content"]!
            let writer = snapshotValue["writer"]!
            let email = snapshotValue["email"]!
            let image = snapshotValue["image"]!
            let insDate = snapshotValue["insDate"]!
            let location = snapshotValue["location"]!
            
            let message = Message()
            
            message.title = title
            message.content = content
            message.email = email
            message.image = image
            message.writer = writer
            message.insDate = insDate
            message.location = location
            message.previewMessage = content
            
            self.messageArray.append(message)
            self.tableView.reloadData()
            
        })
    }
    
    // MARK: - Segues
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let candy = candies[indexPath.row]
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailCandy = candy
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var insDate:String = ""
        var location:String = ""
        var previewTitle:String = ""
        var previewContent:String = ""
        var url_image:String = ""
        
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if searchController.isActive && searchController.searchBar.text != "" {
                     insDate = filterMessages[indexPath.row].insDate
                     location = filterMessages[indexPath.row].location
                     previewTitle = filterMessages[indexPath.row].title
                     previewContent = filterMessages[indexPath.row].previewMessage
                     url_image = filterMessages[indexPath.row].image
                } else {
                     insDate = messageArray[indexPath.row].insDate
                     location = messageArray[indexPath.row].location
                     previewTitle = messageArray[indexPath.row].title
                     previewContent = messageArray[indexPath.row].previewMessage
                     url_image = messageArray[indexPath.row].image
                }
                
                if let controller = segue.destination as? DetailViewController {
                   controller.pmessageTitle = previewTitle
                   controller.pinsDate = insDate
                   controller.plocation = location
                   controller.ptitleImage = url_image
                   controller.pmessageContent = previewContent
                    
                }
                
            }
        }
    }
}

class Message {
    var writer:String = ""
    var title:String = ""
    var previewMessage:String = ""
    var content:String = ""
    var email:String = ""
    var image:String = ""
    var insDate:String = ""
    var location:String = ""
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
