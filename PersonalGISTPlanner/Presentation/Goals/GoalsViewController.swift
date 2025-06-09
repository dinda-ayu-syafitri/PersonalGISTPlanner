//
//  GoalViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 23/05/25.
//

import Combine
import RealmSwift
import UIKit

class GoalItemCell: UITableViewCell {
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var title: UILabel!
    @IBOutlet var progressText: UILabel!

    let containerView = UIView()

    // MARK: - LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
        SetUpUI()
        setUpConstraint()
    }

    // MARK: - SETUP

    func SetUpUI() {
        containerView.backgroundColor = .lightBlueAccent
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true

        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        selectionStyle = .none
        selectionStyle = .none

        containerView.addSubview(title)
        containerView.addSubview(progressView)
        containerView.addSubview(progressText)
    }

    func setUpConstraint() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            progressView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            progressText.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            progressText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            progressText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            progressText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
    }
}

class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var goalTableView: UITableView!

    let category: [String] = [
        "Active Goals",
        "Completed Goals",
    ]

    let viewModel = GoalsViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.rowHeight = UITableView.automaticDimension
        goalTableView.estimatedRowHeight = 100
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchGoals()
    }

    // MARK: - SETUP

    private func setupBindings() {
        viewModel.$activeGoals
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.goalTableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$completedGoals
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.goalTableView.reloadData()
            }
            .store(in: &cancellables)
    }

    // MARK: - TABLE CONFIG

    func numberOfSections(in tableView: UITableView) -> Int {
        return category.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.activeGoals?.count ?? 0
        case 1:
            return viewModel.completedGoals?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear

        let label = UILabel()
        label.text = category[section]
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .label
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 34)

        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalItemCell", for: indexPath) as! GoalItemCell

        let plan: Plan?
        switch indexPath.section {
        case 0:
            plan = viewModel.activeGoals?[indexPath.row]
        case 1:
            plan = viewModel.completedGoals?[indexPath.row]
        default:
            plan = nil
        }

        guard let item = plan else { return cell }

        let goalId = item.id
        let relatedTasks = viewModel.fetchRelatedTask(goalId)
        let completedTaskCount = viewModel.countCompleteTask(for: goalId)
        let totalTaskCount = relatedTasks?.count ?? 0

        let progress: Float = totalTaskCount == 0 ? 0 : Float(completedTaskCount) / Float(totalTaskCount)

        cell.title.text = item.title
        cell.title.numberOfLines = 0
        cell.progressView.progress = progress
        cell.progressText.text = "\(completedTaskCount)/\(totalTaskCount) Task Completed"

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            let plan: Plan?

            switch indexPath.section {
            case 0:
                plan = self.viewModel.activeGoals?[indexPath.row]
            case 1:
                plan = self.viewModel.completedGoals?[indexPath.row]
            default:
                plan = nil
            }

            guard let plan = plan else { return }

            let planID = plan.id

            self.viewModel.deleteGoal(plan: plan)

            print("Deleted plan with ID: \(planID)")
        }

        deleteAction.backgroundColor = .clear

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemView = UIStoryboard(name: "CategorizedListView", bundle: nil)
        if let targetVC = itemView.instantiateViewController(withIdentifier: "CategorizedListView") as? CategorizedListViewController {
            targetVC.goalsVM = viewModel
            targetVC.vm.selectedItem = indexPath.section == 0
                ? viewModel.activeGoals?[indexPath.row]
                : viewModel.completedGoals?[indexPath.row]
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
