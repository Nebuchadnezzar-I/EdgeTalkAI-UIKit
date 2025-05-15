//
//  Preferences.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Preferences: UIView {

    // MARK: - Properties

    // MARK: - UI Elements

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
        label.text = "General"
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
        label.text = "Notes"
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
        label.text = "Timeline"
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
        label.text = "Questions"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var mapLink: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.text = "Parties interests blockades"
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    private lazy var chatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Chat", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center

        button.isUserInteractionEnabled = true
        button.backgroundColor = .label
        button.layer.cornerRadius = 24
        button.clipsToBounds = true

        button.addTarget(
            self, action: #selector(scaleDownTap), for: .touchDown)

        button.addTarget(
            self, action: #selector(scaleUpTap),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])

        return button
    }()

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
        addSubview(chatButton)
        stackView.addArrangedSubview(generalLink)
        stackView.addArrangedSubview(notesLink)
        stackView.addArrangedSubview(timelineLink)
        stackView.addArrangedSubview(questionsLink)
        stackView.addArrangedSubview(mapLink)
    }

    func setupView() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(170)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        [generalLink, notesLink, timelineLink, questionsLink, mapLink].forEach {
            label in
            label.snp.makeConstraints { make in
                make.height.equalTo(48)
            }
        }

        stackView.layer.cornerRadius = 24
        stackView.clipsToBounds = true

        chatButton.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }

    // MARK: - Actions

    @objc private func scaleDownTap(_ sender: UIButton) {
        sender.scaleDown(to: 0.98, duration: 0.1)
    }

    @objc private func scaleUpTap(_ sender: UIButton) {
        sender.scaleUp(duration: 0.1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Carousel.shared.scrollToPage(index: 2)
        }
    }
}
