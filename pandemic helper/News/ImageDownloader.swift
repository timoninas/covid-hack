//
//  ImageDownloader.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import Foundation
import UIKit
func downloadImage(urlStr : String) -> UIImage {
    var image = UIImage(named: "rbc")
    
    guard let url = URL(string: urlStr) else {return image!}
    let task = URLSession.shared.dataTask(with: url) { (data, response, erorr) in
        guard let data = data else {return}
        print("chicl = dskfm")
        image =  UIImage(data: data)
        }
    task.resume()
    return image!
}
