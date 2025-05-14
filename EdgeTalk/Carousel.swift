//
//  Carousel.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Carousel: UIView, UIScrollViewDelegate {
    static let shared = Carousel()

    // MARK: - Properties

    var currentIndex: Int = 0

    // MARK: - UI Elements

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    // Scenes

    private lazy var negotiations: Negotiations = {
        let negotiations = Negotiations()
        return negotiations
    }()

    private lazy var preferences: Preferences = {
        let preferences = Preferences()
        return preferences
    }()

    private lazy var chat: Chat = {
        let chat = Chat()
        return chat
    }()

    private lazy var aiTools: AITools = {
        let aiTools = AITools()
        return aiTools
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
        scrollView.delegate = self

        setupHierarchy()
        setupView()
    }

    // MARK: - Setup Methods

    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.insertArrangedSubview(negotiations, at: 0)
        stackView.insertArrangedSubview(preferences, at: 1)
        stackView.insertArrangedSubview(chat, at: 2)
        stackView.insertArrangedSubview(aiTools, at: 3)
    }

    func setupView() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.trailing.equalToSuperview()
        }

        negotiations.snp.makeConstraints { make in
            make.width.equalTo(self)
        }

        preferences.snp.makeConstraints { make in
            make.width.equalTo(self)
        }

        chat.snp.makeConstraints { make in
            make.width.equalTo(self)
        }

        aiTools.snp.makeConstraints { make in
            make.width.equalTo(self)
        }
    }

    // MARK: - Actions

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.bounds.width

        guard width != 0 else { return }

        let currentPage = floor(offset / width)
        let progress = (offset.truncatingRemainder(dividingBy: width)) / width
        let roundedProgress = round(progress * 100) / 100

        let fromPage = Int(currentPage)
        currentIndex = fromPage
        let toPage = fromPage + 1

        Header.shared.animateLabel(
            from: fromPage, to: toPage, progress: roundedProgress)
    }

    func scrollToPage(index: Int, animated: Bool = true) {
        let xOffset = CGFloat(index) * scrollView.bounds.width
        let targetOffset = CGPoint(x: xOffset, y: 0)
        scrollView.setContentOffset(targetOffset, animated: animated)
    }

    @objc func removePreferences() {
        guard stackView.arrangedSubviews.firstIndex(of: preferences) != nil
        else { return }
        stackView.removeArrangedSubview(preferences)
        preferences.removeFromSuperview()
    }

    @objc func addPreferencesBack() {
        guard !stackView.arrangedSubviews.contains(preferences) else { return }
        stackView.insertArrangedSubview(preferences, at: 1)

        preferences.snp.makeConstraints { make in
            make.width.equalTo(self)
        }
    }
}
