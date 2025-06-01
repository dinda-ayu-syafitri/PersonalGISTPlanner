//
//  InputPlacementViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import UIKit

class RelatedItemCell: UITableViewCell {
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
}

class InputPlacementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var relateditemTable: UITableView!

    var viewModel: InputViewModel!
//    var selectedCategory: PlanCategory?
//    var selectedGoal: Plan?
//    var selectedIdea: Plan?
//    var selectedStep: Plan?

    var relatedItem: [String] {
        let selectedCategory = viewModel.selectedCategory

        switch selectedCategory {
        case .idea:
            return ["Goals"]
        case .step:
            return ["Goals", "Ideas"]
        default:
            return ["Goals", "Ideas", "Steps"]
        }
    }

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        relateditemTable.dataSource = self
        relateditemTable.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        print("Selected Goal: \(String(describing: viewModel.selectedGoal))")
        print("Selected Idea: \(String(describing: viewModel.selectedIdea))")
        print("Selected Step: \(String(describing: viewModel.selectedStep))")
    }

    // MARK: - TABLE VIEW

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relatedItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "relatedItemCell", for: indexPath) as! RelatedItemCell

        cell.categoryLabel.text = relatedItem[indexPath.row]

        if relatedItem[indexPath.row] == "Goals" {
            cell.contentLabel.text = viewModel.selectedGoal?.title ?? "-"
        } else if relatedItem[indexPath.row] == "Ideas" {
            cell.contentLabel.text = viewModel.selectedIdea?.title ?? "-"
        } else {
            cell.contentLabel.text = viewModel.selectedStep?.title ?? "-"
        }

        cell.layer.cornerRadius = 12
        cell.layer.maskedCorners = []
        cell.layer.masksToBounds = true

        if relatedItem.count == 1 {
            cell.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner,
            ]
        } else if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == relatedItem.count - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryView = UIStoryboard(name: "InputSelectionView", bundle: nil)
        if let targetVC = categoryView.instantiateViewController(withIdentifier: "ItemSelectionView") as? InputSelectionViewController {
            targetVC.inputVM = viewModel
            targetVC.onItemSelected = { [weak self] item, category in
                guard let self = self else { return }

                switch category {
                case .goal:
                    viewModel.selectedGoal = item as? Plan
                case .idea:
                    viewModel.selectedIdea = item as? Plan
                case .step:
                    viewModel.selectedStep = item as? Plan
                case .task:
                    return
                case .none:
                    return
                }
                self.relateditemTable.reloadData()
            }

            if relatedItem[indexPath.row] == "Goals" {
                targetVC.selectedCategory = .goal
            } else if relatedItem[indexPath.row] == "Ideas" {
                targetVC.selectedCategory = .idea
            } else if relatedItem[indexPath.row] == "Steps" {
                targetVC.selectedCategory = .step
            }
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
