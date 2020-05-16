//
//  NewsCustomCell.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {

    var indView = UIImageView()
    var message : String?
    var mainImage : UIImage?
    var link : String?
    
    var messageView : UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont(name:"AppleSDGothicNeo-Medium", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

  
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style : style, reuseIdentifier : reuseIdentifier)
        
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        
      
      
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:5).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        messageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        
        if let image  = mainImage {
            mainImageView.image = image
               }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init not implemented")
    }
    func setIndicator(prob : Double) {
        let manSize: CGFloat = 17.5
        indView.image = UIImage(named: "good_new")
//        indView.backgroundColor = .green
        if prob > 0.5 {
            indView.image = UIImage(named: "bad_new")
//            indView.backgroundColor = .red
        }
        indView.frame.size = CGSize(width: manSize, height: manSize)
        indView.layer.masksToBounds = true
        indView.layer.cornerRadius =  manSize/2
        self.addSubview(indView)
        indView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        indView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indView.rightAnchor.constraint(equalTo: self.leftAnchor, constant:10).isActive = true
        indView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
    }
    
    func addImage(urlStr : String) {
        self.mainImageView.image = UIImage(named: "rbc")
        guard let url = URL(string: urlStr) else {return }
        
          let task = URLSession.shared.dataTask(with: url) { (data, response, erorr) in
            guard let data = data else {
                return}
            DispatchQueue.main.async {
                print("downloadImage")
                self.mainImageView.image =  UIImage(data: data)
            }
        }
        task.resume()
    }
}
