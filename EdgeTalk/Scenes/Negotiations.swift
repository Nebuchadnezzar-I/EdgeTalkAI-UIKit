//
//  Negotiations.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Negotiations: UIView {

    // MARK: - Properties

    // MARK: - UI Element s

    private lazy var mainSearch: InsetTextField = {
        let label = InsetTextField()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.placeholder = "Search"
        label.layer.cornerRadius = 24
        label.clipsToBounds = true
        return label
    }()

    private lazy var backIconContainer: UIButton = {
        let view = UIButton()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true

        view.addTarget(
            self, action: #selector(scaleDownTap), for: .touchDown)

        view.addTarget(
            self, action: #selector(scaleUpTap),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])

        return view
    }()

    private lazy var backIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
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
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
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
        addSubview(mainSearch)
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        addSubview(backIconContainer)
        backIconContainer.addSubview(backIcon)

        for _ in 0..<10 {
            let negotiation = Negotiation()
            stackView.addArrangedSubview(negotiation)

            negotiation.addTarget(
                self, action: #selector(scaleDownTapList), for: .touchDown)

            negotiation.addTarget(
                self, action: #selector(scaleUpTapList),
                for: [.touchUpInside, .touchUpOutside, .touchCancel])

            negotiation.snp.makeConstraints { make in
                make.height.equalTo(145)
            }
        }
    }

    func setupView() {
        mainSearch.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(backIconContainer.snp.leading).offset(-16)
            make.height.equalTo(48)
        }

        backIconContainer.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }

        backIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.center.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(mainSearch.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc private func scaleDownTap(_ sender: UIButton) {
        sender.scaleDown(to: 0.95, duration: 0.1)
    }

    @objc private func scaleUpTap(_ sender: UIButton) {
        sender.scaleUp(duration: 0.1)
        Carousel.shared.addPreferencesBack()
        Header.shared.updateTitles([
            "Negotiations",
            "Preferences",
            "Chat",
            "AI Options",
        ])
        Carousel.shared.scrollToPage(index: 1)
    }

    @objc private func scaleDownTapList(_ sender: UIButton) {
        sender.scaleDown(to: 0.98, duration: 0.1)
    }

    @objc private func scaleUpTapList(_ sender: UIButton) {
        sender.scaleUp(duration: 0.1)
        Carousel.shared.removePreferences()
        Header.shared.updateTitles([
            "Negotiations",
            "Chat",
            "AI Options",
        ])
        Carousel.shared.scrollToPage(index: 1)
    }
}

final class InsetTextField: UITextField {
    var textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom)
    }
}
