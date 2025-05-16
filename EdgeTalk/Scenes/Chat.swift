//
//  Chat.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Chat: UIView {
    // MARK: - Properties

    var textFieldBottomConstraint: Constraint?

    // MARK: - UI Elements

    private lazy var textFieldPlaceholder: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.text = "Ask AI ..."
        view.layer.opacity = 0.6
        return view
    }()

    private lazy var textField: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 16)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.isScrollEnabled = false
        view.textContainerInset = UIEdgeInsets(
            top: 16, left: 16, bottom: 8, right: 16)
        view.text = ""
        return view
    }()

    private lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemMaterial))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 16
        blurView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        blurView.clipsToBounds = true
        return blurView
    }()

    private lazy var sendIconContainer: UIButton = {
        let view = UIButton()
        view.backgroundColor = .label
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true

        // TODO: Event handlers

        return view
    }()

    private lazy var sendIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "paperplane.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBackground
        return imageView
    }()

    private lazy var micIconContainer: UIButton = {
        let view = UIButton()
        view.backgroundColor = .label
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true

        // TODO: Event handlers

        return view
    }()

    private lazy var micIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "microphone.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBackground
        return imageView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var chatMessage: ChatMessage = {
        let chatMessage = ChatMessage()
        return chatMessage
    }()

    private lazy var topSpacer = UIView()
    private lazy var bottomSpacer = UIView()
    private lazy var contentView = UIView()

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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        addSubview(blurView)

        addSubview(textField)
        addSubview(textFieldPlaceholder)

        addSubview(sendIconContainer)
        sendIconContainer.addSubview(sendIcon)

        addSubview(micIconContainer)
        micIconContainer.addSubview(micIcon)

        stackView.addArrangedSubview(topSpacer)

        let message = ChatMessage()
        stackView.addArrangedSubview(message)

        stackView.addArrangedSubview(bottomSpacer)
    }

    func setupView() {
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview()
            make.height.equalTo(130)
        }

        textFieldPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top).offset(16)
            make.leading.equalTo(textField.snp.leading).offset(21)
        }

        sendIconContainer.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top).offset(16)
            make.trailing.equalTo(self).offset(-16)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }

        micIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.center.equalToSuperview()
        }

        micIconContainer.snp.makeConstraints { make in
            make.top.equalTo(sendIconContainer.snp.bottom).offset(8)
            make.trailing.equalTo(self).offset(-16)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }

        sendIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.center.equalToSuperview()
        }

        blurView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }

        topSpacer.snp.makeConstraints {
            $0.height.equalTo(32)
        }

        bottomSpacer.snp.makeConstraints {
            $0.height.equalTo(96)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.frameLayoutGuide)
                .priority(.required)
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    // MARK: - Actions

}
