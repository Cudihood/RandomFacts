//
//  TableViewCell.swift
//  RandomFacts
//
//  Created by Даниил Циркунов on 01.02.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "CustomCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
        config()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    func setText(text: String) {
        textLabel?.text = text
    }
}

private extension TableViewCell {
    func config() {
        textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textLabel?.numberOfLines = 0
    }
}
