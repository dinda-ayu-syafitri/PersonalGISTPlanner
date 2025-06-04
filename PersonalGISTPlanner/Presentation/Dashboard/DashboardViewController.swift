//
//  DashboardViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 17/05/25.
//

import Combine
import Foundation
import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet var goalActiveView: UIView!
    @IBOutlet var taskCompleteView: UIView!
    @IBOutlet var taskCompleteProgress: CircularProgressView!
    @IBOutlet var goalCountLabel: UILabel!
    @IBOutlet var totalGoalLabel: UILabel!
    @IBOutlet var completeGoalLabel: UILabel!

    let viewModel = DashboardViewModel()
    var cancellables: Set<AnyCancellable> = []

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupBinding()
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    // MARK: - SETUP

    private func setupBinding() {
        viewModel.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateUI()
                self?.setUpView()
            }
            .store(in: &cancellables)
    }

    private func setUpView() {
        goalActiveView.layer.borderWidth = 1
        goalActiveView.layer.borderColor = UIColor.blueAccent.cgColor
        taskCompleteView.layer.borderWidth = 1
        taskCompleteView.layer.borderColor = UIColor.blueAccent.cgColor
    }

    // MARK: - UPDATE

    private func updateUI() {
        goalCountLabel.text = String(viewModel.plans?.count ?? 0)
        totalGoalLabel.text = " / \(viewModel.totalTask)"
        completeGoalLabel.text = "\(viewModel.completedTask)"

        let progress: CGFloat = viewModel.totalTask > 0
            ? CGFloat(viewModel.completedTask) / CGFloat(viewModel.totalTask)
            : 0

        taskCompleteProgress.setProgress(progress)
    }
}
