//
//  ViewController.swift
//  NewsDemoJSON
//
//  Created by Иван Новиков on 18.10.2019.
//  Copyright © 2019 Иван Новиков. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    let networkService = NerworkService()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let urlString = "https://newsapi.org/v2/top-headlines?" +
        "country=us&" +
        "apiKey=0949157ff9884ddcbe0d8b7f881c6afd"

        networkService.request(urlString: urlString, completion: {(result) in
            switch result {
            case .success(let searchResponse):
                searchResponse.results.map({(news) in
                    print("news.newsTitle:", news.newsTitle)
                })
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
        return 3
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        return cell
    }
}
