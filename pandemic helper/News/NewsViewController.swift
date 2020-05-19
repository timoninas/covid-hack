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
import AMScrollingNavbar

class NewsViewController: ScrollingNavigationViewController {
    var scrollToTop = true
    var tableView = UITableView()
    var newsArr : [NewsData] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabelView()
        listenFirebase()
        setNavigation()
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 0.0, followers: [NavigationBarFollower(view: view, direction: .scrollUp)])
            navigationController.scrollingNavbarDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if scrollToTop {
            scrollToTop = false
            let indexPath = IndexPath(row: 0, section: 0)//IndexPath(forRow: 0, inSection: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func setNavigation() {
        self.navigationItem.title = "Новости"
    }
    
    func setTabelView() {
        //        self.tableView.frame = self.view.frame
        let width = self.view.frame.width
        let height = self.view.frame.height
        self.tableView.frame = CGRect(x: 0, y: -80, width: width, height: height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsCell")
        
        //        tableView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.view.addSubview(tableView)
        //        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 1000).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //tableView.scrollToRow(at: 10, at: UITableView.ScrollPosition.init(rawValue: 1000)!, animated: true)
    }
    
    func listenFirebase() {
        db.collection("News").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            self.newsArr = []
            for document in documents {
                let message = document["title"] as! String
                let link = document["link"] as! String
                let imageUrl = document["image"] as! String
                let prob = Double(document["prob"] as! String)
                let  news = NewsData(imageUrl: imageUrl, message: message,  link : link, prob: prob)
                self.newsArr.append(news)
            }
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: ScrollingNavigationControllerDelegate {
    func scrollingNavigationController(_ controller: ScrollingNavigationController, willChangeState state: NavigationBarState) {
        view.needsUpdateConstraints()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsTableViewCell()
        cell.message = newsArr[indexPath.row].message
        cell.setIndicator(prob: newsArr[indexPath.row].prob!)
        cell.layoutSubviews()
        cell.addImage(urlStr: newsArr[indexPath.row].imageUrl!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsArr.count)
        return newsArr.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: newsArr[indexPath.row].link!) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
