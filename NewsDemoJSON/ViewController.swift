//
//  ViewController.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 18.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    let networkService = NetworkService()
    var searchResponse: SearchResponse? = nil
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let urlString = "https://newsapi.org/v2/top-headlines?"+"country=us&"+"apiKey=0949157ff9884ddcbe0d8b7f881c6afd"

        networkService.request(urlString: urlString, completion: {[weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searchResponse = searchResponse
                self?.table.reloadData()
            case .failure(let error):
                print("error:", error)
            }
        })
    }

    
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.articles.count ?? 0
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let news = searchResponse?.articles[indexPath.row]
//        cell.headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
//        cell.headlineLabel.adjustsFontForContentSizeCategory = true
        cell.textLabel?.text = news?.title
//        cell.imageView?.image = UIImage(data: news?.urlToImage)
        return cell
    }
}
