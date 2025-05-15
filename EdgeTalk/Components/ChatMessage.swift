//
//  ChatMessage.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 15/05/2025.
//

import SnapKit
import UIKit

final class ChatMessage: UIView {
    private let messageData: NegotiationGuidance = getGuidance()

    // MARK: - UI

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupLayout()
        setupData()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupLayout()
        setupData()
    }

    // MARK: - Setup

    private func createPaddedLabel(text: String, fontSize: CGFloat = 16)
        -> UIView
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: fontSize)
        label.text = text
        return label
    }

    private func setupHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(
            createPaddedLabel(
                text:
                    "\(messageData.clarifyValue.question):\n\n\(messageData.clarifyValue.advice)"
            )
        )
        stackView.addArrangedSubview(
            createPaddedLabel(
                text:
                    "\(messageData.setup.question):\n\n\(messageData.setup.advice)"
            )
        )
        stackView.addArrangedSubview(
            createPaddedLabel(
                text:
                    "\(messageData.dealDesign.advice):\n\n\(messageData.dealDesign.suggestion)"
            )
        )
        stackView.addArrangedSubview(
            createPaddedLabel(
                text:
                    "\(messageData.tactics.advice):\n\n\(messageData.tactics.suggestion)"
            )
        )
        stackView.addArrangedSubview(
            createPaddedLabel(
                text:
                    "\(messageData.warning.caution):\n\n\(messageData.warning.note)"
            )
        )
    }

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    private func setupData() {

    }

    // MARK: - Label Builders

}
