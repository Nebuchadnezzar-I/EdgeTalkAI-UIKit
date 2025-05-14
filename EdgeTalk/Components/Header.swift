//
//  Header.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Header: UIView {
    static let shared = Header()

    // MARK: - Properties

    private var chatPageIndex: Int = 2
    private var labelCenterX: Constraint?
    private var buttonCenterX: Constraint?

    private var lastPage: Int = 0
    private var titles = [
        "Negotiations",
        "Preferences",
        "Chat",
        "AI Options",
    ]

    // MARK: - UI Elements

    private lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemMaterial))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0
        return blurView
    }()

    private lazy var mainLabel: UILabel = {
        let view = UILabel()
        view.text = "Negotiations"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        return view
    }()

    private lazy var backIconContainer: UIButton = {
        let view = UIButton()
        view.backgroundColor = .label
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true

        view.addTarget(
            self, action: #selector(scaleDownTap), for: .touchDown)

        view.addTarget(
            self, action: #selector(scaleUpTap),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])

        return view
    }()

    private lazy var backIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.left"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBackground
        return imageView
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
        addSubview(mainLabel)
        insertSubview(blurView, at: 0)

        addSubview(backIconContainer)
        backIconContainer.addSubview(backIcon)
    }

    func setupView() {
        mainLabel.snp.makeConstraints { make in
            labelCenterX = make.centerX.equalToSuperview().constraint
            make.bottom.equalToSuperview().offset(-16)
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backIconContainer.snp.makeConstraints { make in
            buttonCenterX = make.centerX.equalToSuperview().constraint
            make.bottom.equalTo(self)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }

        backIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.center.equalToSuperview()
        }

        let labelOffset = labelXOffset(for: 0)
        labelCenterX?.update(offset: labelOffset)

        let buttonOffset = buttonXOffset(for: 0)
        buttonCenterX?.update(offset: buttonOffset)
    }

    // MARK: - Actions

    func animateLabel(from: Int, to: Int, progress: CGFloat) {
        if progress < 0.0001 { return }

        // Label

        let labelFromOffset = labelXOffset(for: from)
        let labelToOffset = labelXOffset(for: to)

        let labelInterpolatedOffset =
            labelFromOffset * (1 - progress) + labelToOffset * progress

        labelCenterX?.update(offset: labelInterpolatedOffset)

        let labelClosestPage = progress < 0.5 ? from : to
        if labelClosestPage != lastPage {
            lastPage = labelClosestPage
            mainLabel.text = titles[safe: labelClosestPage] ?? ""
        }

        // Button

        let buttonFromOffset = buttonXOffset(for: from)
        let buttonToOffset = buttonXOffset(for: to)

        let buttonInterpolatedOffset =
            buttonFromOffset * (1 - progress) + buttonToOffset * progress

        buttonCenterX?.update(offset: buttonInterpolatedOffset)

        let buttonClosestPage = progress < 0.5 ? from : to
        if buttonClosestPage != lastPage {
            lastPage = buttonClosestPage
            mainLabel.text = titles[safe: buttonClosestPage] ?? ""
        }

        // Blur

        let isEnteringBlurPage = (from == chatPageIndex || to == chatPageIndex)
        if isEnteringBlurPage {
            let fadeInProgress: CGFloat =
                to == chatPageIndex ? progress : 1 - progress
            blurView.alpha = fadeInProgress
        } else {
            blurView.alpha = 0
        }

        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.3,
            options: [.curveEaseInOut, .allowUserInteraction],
            animations: {
                self.layoutIfNeeded()
            },
            completion: nil
        )
    }

    private func labelXOffset(for page: Int) -> CGFloat {
        let isLeft = (page == 0 || page == chatPageIndex)
        let screenWidth = UIScreen.main.bounds.width
        let labelWidth = mainLabel.intrinsicContentSize.width
        let sideInset: CGFloat = 16

        return isLeft
            ? -(screenWidth / 2 - labelWidth / 2 - sideInset)
            : (screenWidth / 2 - labelWidth / 2 - sideInset)
    }

    private func buttonXOffset(for page: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonWidth: CGFloat = 64
        let sideInset: CGFloat = 16

        let isVisible = (page != chatPageIndex && page != 0)

        return isVisible
            ? -(screenWidth / 2 - (sideInset + buttonWidth / 2))
            : -(screenWidth / 2 + buttonWidth + sideInset)
    }

    @objc private func scaleDownTap(_ sender: UIButton) {
        sender.scaleDown(to: 0.95, duration: 0.1)
    }

    @objc private func scaleUpTap(_ sender: UIButton) {
        sender.scaleUp(duration: 0.1)

        if Carousel.shared.currentIndex == 1 {
            Carousel.shared.scrollToPage(index: 0)
        }

        if Carousel.shared.currentIndex == 3 {
            Carousel.shared.scrollToPage(index: 2)
        }
    }

    @objc func updateTitles(_ newTitles: [String]) {
        self.titles = newTitles

        if let chatIndex = newTitles.firstIndex(where: { $0 == "Chat" }) {
            self.chatPageIndex = chatIndex
        } else {
            self.chatPageIndex = -1
        }

        let currentIndex = Carousel.shared.currentIndex
        lastPage = currentIndex
        mainLabel.text = titles[safe: currentIndex] ?? ""
    }
}
