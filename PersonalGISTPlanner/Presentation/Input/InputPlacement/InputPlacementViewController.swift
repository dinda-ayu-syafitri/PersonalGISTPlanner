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

    var selectedCategory: PlanCategory?
    var relatedItem: [String] {
        guard let selectedCategory = selectedCategory else {
            return []
        }

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

    // MARK: - TABLE VIEW

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relatedItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "relatedItemCell", for: indexPath) as! RelatedItemCell

        cell.categoryLabel.text = relatedItem[indexPath.row]
        cell.contentLabel.text = "TEST 123"

        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == relatedItem.count - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.maskedCorners = []
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryView = UIStoryboard(name: "InputSelectionView", bundle: nil)
        if let targetVC = categoryView.instantiateViewController(withIdentifier: "ItemSelectionView") as? InputSelectionViewController {
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
