//
//  InputViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 20/05/25.
//

import Combine
import UIKit

class InputViewController: UIViewController {
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var descInput: UITextView!
    @IBOutlet var categorySelection: UIView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dueDateView: UIView!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!

    let viewModel = InputViewModel()
    var cancellables = Set<AnyCancellable>()

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestureRecognizers()

        viewModel.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateUI()
            }
            .store(in: &cancellables)
    }

    // MARK: - SETUP

    private func setupView() {
        dueDatePicker.isHidden = true
        dueDateLabel.text = viewModel.selectedDueDate.formatted(date: .long, time: .omitted)
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

        let tapToDismissKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tapToDismissKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapToDismissKeyboard)
    }

    // MARK: - UPDATE

    private func updateUI() {
        dueDateLabel.text = viewModel.selectedDueDate.formatted(date: .long, time: .omitted)
        categoryLabel.text = viewModel.selectedCategory.rawValue
    }

    // MARK: - ACTION

    @objc func submit() {
        print("Submit")
        viewModel.title = titleInput.text ?? ""
        viewModel.desc = descInput.text ?? ""

        viewModel.savePlan()
    }

    @objc func pushToCategoryView() {
        let categoryView = UIStoryboard(name: "CategorySelectionView", bundle: nil)
        let categoryVC = categoryView.instantiateViewController(withIdentifier: "CategorySelectionView") as! CategorySelectionViewController
        categoryVC.viewModel = viewModel
        navigationController?.pushViewController(categoryVC, animated: true)
    }

    // DATE PICKER
    @objc func toggleDueDatePicker() {
        dueDatePicker.isHidden.toggle()
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        viewModel.selectedDueDate = sender.date
    }
}
