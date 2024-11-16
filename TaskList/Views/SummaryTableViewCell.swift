//
//  SummaryTableViewCell.swift
//  TaskList
//
//  Created by made reihan on 16/11/24.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.backgroundColor = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        return stackView
    }()

    lazy var complatedLabel: UILabel = {
        let complatedLabel = UILabel()
        complatedLabel.font = .boldSystemFont(ofSize: 20)
        return complatedLabel
    }()
    
    
    lazy var inComplatedLabel: UILabel = {
        let inComplatedLabel = UILabel()
        inComplatedLabel.font = .boldSystemFont(ofSize: 20)
        return inComplatedLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        stackView.addArrangedSubview(inComplatedLabel)
        stackView.addArrangedSubview(complatedLabel)
        
        contentView.addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    
    func configure(completed: String, incompleted: String) {
        complatedLabel.text = "Completed: \(completed)"
        inComplatedLabel.text = "Todo: \(incompleted)"
    }
    
}
