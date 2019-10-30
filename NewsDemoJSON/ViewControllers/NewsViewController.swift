//
//  ViewController.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 18.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController  {
    
    let networkService = NetworkService()
    var searchResponse: SearchResponse? = nil
    @IBOutlet var tableView: UITableView!
    
    
    let urlString = "https://newsapi.org/v2/top-headlines?"+"country=us&"+"apiKey=0949157ff9884ddcbe0d8b7f881c6afd"
    override func viewDidLoad() {
        super.viewDidLoad()
            networkService.request(urlString: urlString, completion: {[weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searchResponse = searchResponse
                self?.tableView.reloadData()
            case .failure(let error):
                print("error:", error)
            }
        })
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsDetailViewController,
          let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedNews = searchResponse?.articles[indexPath.row]
        }
      }

    
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.articles.count ?? 0
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.totalResults ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let news = searchResponse?.articles[indexPath.row]
        let imageCache = NSCache<NSString, UIImage>()
        cell.newsImageView.image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            cell.newsImageView?.image = imageFromCache
        }
        cell.newsLabel?.text = news?.title
        DispatchQueue.global(qos: .userInteractive).async {
            if news?.urlToImage != nil {
                if let url = URL(string:(news?.urlToImage)!) {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if data != nil {
                            let imageToCache = UIImage(data: data!)
//                        cell.newsImageView?.image = UIImage(data: data!)
                            cell.newsImageView?.image = imageToCache
                            imageCache.setObject(imageToCache!, forKey: self.urlString as NSString)
                        } else {
                            cell.newsImageView?.image = nil
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    cell.newsImageView?.image = nil
                }
            }
        }
        return cell
    }
}
