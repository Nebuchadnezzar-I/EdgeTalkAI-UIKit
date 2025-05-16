//
//  ChatMessage.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 15/05/2025.
//

import SnapKit
import UIKit

final class ChatMessage: UIView {
    private let messageData: NegotiationPlan = getPlan()

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
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "🔷 Important Info:\n\(messageData.importantInformation)",
                fontSize: 16,
                weight: .medium,
                lineSpacing: 6,
                backgroundColor: UIColor.systemYellow.withAlphaComponent(0.15)
            )
        )

        // Setup Section
        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "🧩 Setup\nEnvironment:\n\(messageData.setup.environment)",
                fontSize: 15,
                weight: .semibold,
                backgroundColor: UIColor.systemBlue.withAlphaComponent(0.08)
            )
        )

        messageData.setup.participants.forEach { participant in
            stackView.addArrangedSubview(
                makeMultilineLabel(
                    text: "• \(participant)",
                    fontSize: 15
                )
            )
        }

        // Deal Design – Terms
        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "📦 Deal Design - Terms:",
                fontSize: 15,
                weight: .semibold,
                backgroundColor: UIColor.systemRed.withAlphaComponent(0.08)
            )
        )

        messageData.dealDesign.terms.forEach { term in
            stackView.addArrangedSubview(
                makeMultilineLabel(
                    text: "• \(term)",
                    fontSize: 15
                )
            )
        }

        // Deal Design – Objectives
        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "🎯 Deal Design - Objectives:",
                fontSize: 15,
                weight: .semibold,
                backgroundColor: UIColor.systemGreen.withAlphaComponent(0.08)
            )
        )

        messageData.dealDesign.objectives.forEach { objective in
            stackView.addArrangedSubview(
                makeMultilineLabel(
                    text: "• \(objective)",
                    fontSize: 15
                )
            )
        }

        // Tactics – Approaches
        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "🧠 Tactics - Approaches:",
                fontSize: 15,
                weight: .semibold,
                backgroundColor: UIColor.systemTeal.withAlphaComponent(0.08)
            )
        )

        messageData.tactics.approaches.forEach { approach in
            stackView.addArrangedSubview(
                makeMultilineLabel(
                    text: "• \(approach)",
                    fontSize: 15
                )
            )
        }

        // Tactics – Counter Strategies
        stackView.addArrangedSubview(
            makeMultilineLabel(
                text: "⚠️ Tactics - Counter Strategies:",
                fontSize: 15,
                weight: .semibold,
                backgroundColor: UIColor.systemPink.withAlphaComponent(0.1)
            )
        )

        messageData.tactics.counterStrategies.forEach { strategy in
            stackView.addArrangedSubview(
                makeMultilineLabel(
                    text: "• \(strategy)",
                    fontSize: 15
                )
            )
        }
    }

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    // MARK: - Methods

    func makeMultilineLabel(
        text: String,
        fontSize: CGFloat = 15,
        weight: UIFont.Weight = .regular,
        lineSpacing: CGFloat = 4,
        backgroundColor: UIColor? = nil
    ) -> UILabel {
        let label = PaddingLabel()
        label.insets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .label
        label.backgroundColor = backgroundColor ?? .clear
        label.layer.cornerRadius = 8
        label.clipsToBounds = true

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .font: label.font!,
            .paragraphStyle: paragraphStyle,
        ]

        label.attributedText = NSAttributedString(
            string: text, attributes: attributes)
        return label
    }
}
