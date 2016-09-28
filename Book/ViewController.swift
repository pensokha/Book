//
//  ViewController.swift
//  Book
//
//  Created by LiuRon on 2016/9/24.
//  Copyright © 2016年 LiuRon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let identifierBookCell = "NormalCell"
    let url = "https://api.douban.com/v2/movie/search"
    let tag = "爱情"
    var books:JSON = []
    
    func hello(){
        print ("hello")
    }
    
//    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        let loadingNotification:MBProgressHUD
        loadingNotification = MBProgressHUD.showAdded(to: self.view!, animated: true)
        loadingNotification.label.text = "Loading"
        
        Alamofire.request(url, method: .get, parameters: ["tag":tag,"start":0,"count":100],encoding: URLEncoding.default).responseJSON {
            response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                self.books = JSON(response.result.value)["subjects"]
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return self.books != nil ? self.books.count : 0
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: identifierBookCell, for: indexPath) as! BookCell;
        bookCell.configureWithBook(book: books[indexPath.row])
        
        return bookCell
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
