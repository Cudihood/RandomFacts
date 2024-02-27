//
//  ViewController.swift
//  RandomFacts
//
//  Created by Даниил Циркунов on 01.02.2024.
//

import UIKit

final class ViewController: UIViewController {

    private var facts: [FactModel] = []
    private var network = NetworkManager()

    @IBOutlet private weak var getFactsButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func getButtonAction(_ sender: Any) {
        isStartAnimating(true)
        network.getFact { fact, error in
            DispatchQueue.main.async {
                self.isStartAnimating(false)
                if let error {
                    print(error.localizedDescription)
                    self.presentAlert()
                }

                if let fact {
                    self.facts.insert(fact, at: 0)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier) as? TableViewCell
        else {
            return UITableViewCell()
        }
        if let model = facts.getValue(at: indexPath.row) {
            cell.setText(text: model.fact)
        }
        return cell
    }
}

private extension ViewController {
    func configure() {
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        getFactsButton.layer.cornerRadius = 10
        isStartAnimating(false)
    }

    func isStartAnimating(_ value: Bool) {
        if value {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = !value
        getFactsButton.isUserInteractionEnabled = !value
    }

    func presentAlert() {
        let alert = UIAlertController(title: "Error", message: "An error occurred, please try later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}
