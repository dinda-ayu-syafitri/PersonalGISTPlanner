//
//  InputSelectionViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//
import RealmSwift
import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var itemContent: UILabel!
}

class InputSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var itemTable: UITableView!

    var onItemSelected: ((Any, PlanCategory) -> Void)?
    var selectedCategory: PlanCategory?
    let viewModel = ItemSelectionViewModel()
    var inputVM: InputViewModel!
    var items: Results<Plan>?

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.dataSource = self
        itemTable.delegate = self

        guard let selectedCategory = selectedCategory else { return }

        switch selectedCategory {
        case .goal:
            items = viewModel.fetchGoal()

        case .idea:
            guard let goalID = inputVM.selectedGoal?.id else {
                print("selectedGoal is nil. Cannot fetch ideas.")
                return
            }
            items = viewModel.fetchIdeas(goalID)

        case .step:
            guard let ideaID = inputVM.selectedIdea?.id else {
                print("selectedIdea is nil. Cannot fetch steps.")
                return
            }
            items = viewModel.fetchSteps(ideaID)

        case .task:
            return

        default:
            return
        }
    }

    // MARK: - TABLE CONFIG

    func numberOfSections(in tableView: UITableView) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        cell.itemContent.text = items?[indexPath.section].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem = items?[indexPath.section] {
//            onItemSelected?(selectedItem, selectedCategory ?? .goal)
            if selectedCategory == .goal {
                inputVM.selectedGoal = selectedItem
                print("Selected Goal: \(selectedItem.title)")
            } else if selectedCategory == .idea {
                inputVM.selectedIdea = selectedItem
                print("Selected Idea: \(selectedItem.title)")
            } else if selectedCategory == .step {
                inputVM.selectedStep = selectedItem
                print("Selected Step: \(selectedItem.title)")
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
