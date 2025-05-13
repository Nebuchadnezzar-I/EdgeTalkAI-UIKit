//
//  Negotiation.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Negotiation: UIView {

    // MARK: - Properties

    // MARK: - UI Elements

    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "Negotiation"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    private lazy var subText: UILabel = {
        let label = UILabel()
        label.text =
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
            target: self, action: #selector(handleTap))
        label.addGestureRecognizer(tap)

        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupView()
    }

    // MARK: - Setup Methods

    func setupHierarchy() {
        addSubview(container)
        container.addSubview(mainText)
        container.addSubview(subText)
    }

    func setupView() {
        container.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 16
        container.clipsToBounds = true

        mainText.snp.makeConstraints { make in
            make.top.equalTo(self).offset(24)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        subText.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }
    }

    // MARK: - Actions

    @objc private func handleTap() {
        Carousel.shared.scrollToPage(index: 1)
    }
}
