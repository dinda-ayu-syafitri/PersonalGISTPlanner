//
//  GoalViewController.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 23/05/25.
//

import UIKit

class GoalItemCell: UITableViewCell {
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var title: UILabel!
    @IBOutlet var progressText: UILabel!

    let containerView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        SetUpUI()
        setUpConstraint()
    }

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

    let activeItems: [String] = [
        "Get a fulltime job as iOS Dev ",
        "Become an expert in iOS Dev",
        "Understanding the basic of Kotlin",
    ]

    let completedItem: [String] = [
        "Get repeated freelance client",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.rowHeight = UITableView.automaticDimension
        goalTableView.estimatedRowHeight = 100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return category.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activeItems.count
        } else if section == 1 {
            return completedItem.count
        }
        return 0
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

        cell.progressView.progress = 0.8
        cell.title.numberOfLines = 0

        if indexPath.section == 0 {
            cell.title.text = activeItems[indexPath.row]
        } else if indexPath.section == 1 {
            cell.title.text = completedItem[indexPath.row]
        }

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") {
            _, _, _ in

            print("Delete ACTION")
        }

        deleteAction.backgroundColor = .clear

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemView = UIStoryboard(name: "CategorizedListView", bundle: nil)
        if let targetVC = itemView.instantiateViewController(withIdentifier: "CategorizedListView") as? CategorizedListViewController {
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}
