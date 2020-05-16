//
//  ViewController.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import Firebase
import SafariServices
class NewsViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var newsArr : [NewsData] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabelView()
        listenFirebase()
        setNavigation()
    }
    func setNavigation() {
        self.title = ""
    }
    func setTabelView() {
        view.addSubview(tableView)
        tableView.layer.zPosition = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 100
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsTableViewCell()
        cell.message = newsArr[indexPath.row].message
        cell.setIndicator(prob: newsArr[indexPath.row].prob!)
        cell.layoutSubviews()
        cell.addImage(urlStr: newsArr[indexPath.row].imageUrl!)
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let url = URL(string: newsArr[indexPath.row].link!) else {
                return
            }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
    }
    
    func listenFirebase() {
        db.collection("News").addSnapshotListener { querySnapshot, error in
        
        guard let documents = querySnapshot?.documents else {
            print("Error fetching documents: \(error!)")
            return
        }
        self.newsArr = []
        for i in documents {
            let message = i["title"] as! String
            let link = i["link"] as! String
            let imageUrl = i["image"] as! String
            let prob = Double(i["prob"] as! String)
            let  news = NewsData(imageUrl: imageUrl, message: message,  link : link, prob: prob)
            self.newsArr.append(news)
            }
            self.tableView.reloadData()
        }
    }
    
}

