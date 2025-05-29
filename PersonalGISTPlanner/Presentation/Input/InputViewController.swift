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
    @IBOutlet var dueDatePicker: UIDatePicker!

    let viewModel = InputViewModel()
    var selectedCategory: PlanCategory = .none
    var selectedDueDate: Date?
    var selectedGoalId: UUID?
    var selectedIdeaId: UUID?
    var selectedStepId: UUID?
    var selectedTaskId: UUID?

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestureRecognizers()
    }

    // MARK: - SETUP

    private func setupView() {
        dueDatePicker.isHidden = true
    }

    private func setupGestureRecognizers() {
        let tapCategorySelectionGesture = UITapGestureRecognizer(target: self, action: #selector(pushToCategoryView))
        categorySelection.addGestureRecognizer(tapCategorySelectionGesture)
        categorySelection.isUserInteractionEnabled = true

        let tapDueDateViewGesture = UITapGestureRecognizer(target: self, action: #selector(toggleDueDatePicker))
        dueDateView.addGestureRecognizer(tapDueDateViewGesture)
        dueDateView.isUserInteractionEnabled = true

        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)

        dueDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }

    // MARK: - ACTION

    @objc func submit() {
        print("Submit")
        let plan = Plan()
        plan.title = titleInput.text ?? ""
        plan.desc = descInput.text ?? ""
        plan.dueDate = selectedDueDate ?? Date()
        plan.category = selectedCategory

        print("title: \(plan.title)")
        print("desc: \(plan.desc)")
        print("category: \(plan.category)")
        print("Due Date: \(plan.dueDate)")

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

    // DATE PICKER
    @objc func toggleDueDatePicker() {
        dueDatePicker.isHidden.toggle()
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        selectedDueDate = sender.date
    }
}
