//
//  CategorySelectionViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import UIKit

class CategorySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var categoryTableView: UITableView!

    let categories = ["Goals", "Ideas", "Steps", "Tasks", "Uncategorized"]

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }

    // MARK: - TABLE VIEW

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = categories[indexPath.row]

        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == categories.count - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.maskedCorners = []
        }

        cell.contentConfiguration = content
        return cell
    }
}
