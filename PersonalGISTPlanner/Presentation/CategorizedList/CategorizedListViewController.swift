//
//  CategorizedListViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 26/05/25.
//

import Combine
import UIKit

class CategorizedItemCell: UITableViewCell {
    @IBOutlet var checkMark: UIImageView!
    @IBOutlet var chevronIcon: UIImageView!
    @IBOutlet var contentText: UILabel!
}

class CategorizedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemDescLabel: UILabel!

    let vm = CategorizedListViewModel()
    var goalsVM: GoalsViewModel!

    var category: PlanCategory = .goal
    private var cancellables = Set<AnyCancellable>()

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupBinding()
        setupView()

        if category == .goal {
            vm.fetchIdeas()
        } else if category == .idea {
            vm.fetchSteps()
        } else if category == .step {
            vm.fetchTasks()
        }
    }

    override func viewWillAppear(_ animated: Bool) {}

    // MARK: - SETUP

    private func setupBinding() {
        vm.$items
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        itemTitleLabel.text = vm.selectedItem?.title ?? ""
        itemDescLabel.text = vm.selectedItem?.desc ?? ""
    }

    // MARK: - TABLE CONFIG

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorizedItemCell") as! CategorizedItemCell

        cell.contentText.text = vm.items?[indexPath.row].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemView = UIStoryboard(name: "CategorizedListView", bundle: nil)
        if let targetVC = itemView.instantiateViewController(withIdentifier: "CategorizedListView") as? CategorizedListViewController {
            targetVC.goalsVM = goalsVM
            targetVC.category = vm.items?[indexPath.row].category ?? .idea
            targetVC.vm.selectedItem = vm.items?[indexPath.row]
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
