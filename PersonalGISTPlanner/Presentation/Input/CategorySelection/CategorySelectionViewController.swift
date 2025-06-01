//
//  CategorySelectionViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import UIKit

class CategorySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var categoryTableView: UITableView!

    var viewModel: InputViewModel!

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }

    // MARK: - TABLE VIEW

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanCategory.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = PlanCategory.allCases[indexPath.row].rawValue

        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == PlanCategory.allCases.count - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.maskedCorners = []
        }

        cell.contentConfiguration = content

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = PlanCategory.allCases[indexPath.row]

        if selectedCategory == .goal {
            viewModel.selectedCategory = selectedCategory
            navigationController?.popViewController(animated: true)
        } else {
            viewModel.selectedCategory = selectedCategory
            let categoryView = UIStoryboard(name: "InputPlacementView", bundle: nil)
            if let targetVC = categoryView.instantiateViewController(withIdentifier: "InputPlacementView") as? InputPlacementViewController {
                targetVC.viewModel = viewModel
//                targetVC.selectedCategory = selectedCategory
                navigationController?.pushViewController(targetVC, animated: true)
            }
        }
    }
}
