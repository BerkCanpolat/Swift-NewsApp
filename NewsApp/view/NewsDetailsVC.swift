//
//  NewsDetailsVC.swift
//  NewsApp
//
//  Created by Berk Canpolat on 7.01.2024.
//

import UIKit
import SDWebImage

class NewsDetailsVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UITextView!
    
    var news:NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = news {
            text.text = n.description
            image.sd_setImage(with: URL(string: n.urlToImage!))
        }
    }

}
