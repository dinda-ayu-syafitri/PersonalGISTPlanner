//
//  CategorizedListViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//

import UIKit

class CategorizedItemCell: UITableViewCell {
    @IBOutlet var checkMark: UIImageView!
    @IBOutlet var chevronIcon: UIImageView!
    @IBOutlet var contentText: UILabel!
}

class CategorizedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    let items: [String] = [
        "Test 123",
        "Test 123",
        "Test 123",
        "Test 123",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorizedItemCell") as! CategorizedItemCell

        cell.contentText.text = items[indexPath.row]

        return cell
    }
}
