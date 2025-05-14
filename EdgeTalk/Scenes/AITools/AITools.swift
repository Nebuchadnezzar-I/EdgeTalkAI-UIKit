//
//  AITools.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class AITools: UIView {

    // MARK: - Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 1
        return stackView
    }()

    private lazy var generalLink: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.text = "Reframing"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var notesLink: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.text = "Active listening"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var timelineLink: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.text = "Conversation"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var questionsLink: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.text = "Freemode"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    // MARK: - UI Elements

    private lazy var placeholder: UILabel = {
        let view = UILabel()
        view.text = "Preferences"
        view.textAlignment = .center
        return view
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
        addSubview(stackView)
        stackView.addArrangedSubview(generalLink)
        stackView.addArrangedSubview(notesLink)
        stackView.addArrangedSubview(timelineLink)
        stackView.addArrangedSubview(questionsLink)
    }

    func setupView() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(170)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        [generalLink, notesLink, timelineLink, questionsLink].forEach {
            label in
            label.snp.makeConstraints { make in
                make.height.equalTo(48)
            }
        }

        stackView.layer.cornerRadius = 24
        stackView.clipsToBounds = true
    }

    // MARK: - Actions

}
