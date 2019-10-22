//
//  NewsDetailViewController.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 22.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var selectedNews: News!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDescriptionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedNews.description != nil {       newsDescriptionLabel.text = "\(selectedNews.description!)\r\n\(selectedNews.url)"
        } else {
            newsDescriptionLabel.text = "\(selectedNews.url)"
        }
    }
}

//extension NewsDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        print("\(selectedNews.description) + \r\n\(selectedNews.url)")
//            cell.textLabel?.text = "\(selectedNews.description) + \r\n\(selectedNews.url)"
//        return cell
//    }
    
//}
