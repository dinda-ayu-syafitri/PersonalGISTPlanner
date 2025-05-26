//
//  PlanBasketViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//

import UIKit

class PlanBasketCell: UITableViewCell {
    @IBOutlet var itemText: UILabel!
    @IBOutlet var chevronIcon: UIImageView!
}

class PlanBasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    let items: [String] = ["Buy milk", "Buy bread", "Buy eggs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanBasketCell") as! PlanBasketCell

        cell.itemText.text = items[indexPath.row]

        return cell
    }
}
