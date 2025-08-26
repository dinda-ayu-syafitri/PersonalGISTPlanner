//
//  PlanBasketViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//

import Combine
import UIKit

class PlanBasketCell: UITableViewCell {
    @IBOutlet var itemText: UILabel!
    @IBOutlet var chevronIcon: UIImageView!
}

class PlanBasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    let vm = PlanBasketViewModel()
    var cancellables = Set<AnyCancellable>()

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        vm.fetchUncategorizedPlans()

        vm.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    // MARK: - TABLE CONFIG

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanBasketCell") as! PlanBasketCell

        cell.itemText.text = vm.items?[indexPath.row].title

        return cell
    }

    // MARK: - SEARCH BAR DELEGATE

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.fetchPlansByKeyword(searchText)
        tableView.reloadData()
    }
}
