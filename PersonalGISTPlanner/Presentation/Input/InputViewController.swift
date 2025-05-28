//
//  InputViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var descInput: UITextView!
    @IBOutlet var categorySelection: UIView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dueDateView: UIView!

    let viewModel = InputViewModel()
    var selectedCategory: PlanCategory = .none

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
    }

    // MARK: - SETUP

    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushToCategoryView))
        categorySelection.addGestureRecognizer(tapGesture)
        categorySelection.isUserInteractionEnabled = true

        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }

    // MARK: - ACTION

    @objc func submit() {
        print("Submit")
        let plan = Plan()
        plan.title = titleInput.text ?? ""
        plan.desc = descInput.text ?? ""
        plan.dueDate = Date().addingTimeInterval(60 * 60 * 24 * 2)
        plan.category = selectedCategory

        print("title: \(plan.title)")
        print("desc: \(plan.desc)")
        print("category: \(plan.category)")

        viewModel.savePlan(plan)
    }

    @objc func pushToCategoryView() {
        let categoryView = UIStoryboard(name: "CategorySelectionView", bundle: nil)
        let categoryVC = categoryView.instantiateViewController(withIdentifier: "CategorySelectionView") as! CategorySelectionViewController

        categoryVC.onCategorySelected = { [weak self] selectedCategory in
            self?.selectedCategory = selectedCategory
            self?.categoryLabel.text = selectedCategory.rawValue
        }

        navigationController?.pushViewController(categoryVC, animated: true)
    }
}
