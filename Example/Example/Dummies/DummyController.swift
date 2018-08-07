//
//  DummyController.swift
//  NavigationToolbar
//
//  Created by Artem P. on 22/05/2018.
//  Copyright © 2018 Ramotion. All rights reserved.
//

import UIKit

class DummyController: UIViewController {
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DummyCell.self, forCellReuseIdentifier: String(describing: DummyCell.self))
        tableView.separatorColor = .clear
        tableView.bounces = false
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension DummyController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DummyCell.self), for: indexPath) as! DummyCell
        cell.setData(avatar: UIImage(named: "image14")!, title: "Jellyfish Cam offers Stunning Views", subtitle: "3k views • 5 days ago", content: UIImage(named: "image13")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
