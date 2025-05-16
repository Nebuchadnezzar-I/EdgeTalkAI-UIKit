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

    lazy var negotiations: Negotiations = {
        let negotiations = Negotiations()
        return negotiations
    }()

    lazy var preferences: Preferences = {
        let preferences = Preferences()
        return preferences
    }()

    lazy var preferencesConfig: PreferencesConfig = {
        let preferencesConfig = PreferencesConfig()
        return preferencesConfig
    }()

    lazy var chat: Chat = {
        let chat = Chat()
        return chat
    }()

    lazy var aiTools: AITools = {
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
        dismissKeyboard()

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
        dismissKeyboard()

        let xOffset = CGFloat(index) * scrollView.bounds.width
        let targetOffset = CGPoint(x: xOffset, y: 0)
        scrollView.setContentOffset(targetOffset, animated: animated)
    }

    // Preferences

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

    // Preferences Config

    @objc func removePreferencesConfig() {
        guard
            stackView.arrangedSubviews.firstIndex(of: preferencesConfig) != nil
        else { return }
        stackView.removeArrangedSubview(preferencesConfig)
        preferencesConfig.removeFromSuperview()
    }

    @objc func addPreferencesConfigBack() {
        guard !stackView.arrangedSubviews.contains(preferencesConfig) else {
            return
        }
        stackView.insertArrangedSubview(preferencesConfig, at: 2)

        preferencesConfig.snp.makeConstraints { make in
            make.width.equalTo(self)
        }
    }

    // Chat

    @objc func removeChat() {
        guard
            stackView.arrangedSubviews.firstIndex(of: chat) != nil
        else { return }
        stackView.removeArrangedSubview(chat)
        chat.removeFromSuperview()
    }

    @objc func addChatBack() {
        guard !stackView.arrangedSubviews.contains(chat) else {
            return
        }
        stackView.insertArrangedSubview(chat, at: 2)

        chat.snp.makeConstraints { make in
            make.width.equalTo(self)
        }
    }

    // AI Options

    @objc func removeAIOptions() {
        guard
            stackView.arrangedSubviews.firstIndex(of: aiTools) != nil
        else { return }
        stackView.removeArrangedSubview(aiTools)
        aiTools.removeFromSuperview()
    }

    @objc func addAIOptionsBack() {
        guard !stackView.arrangedSubviews.contains(aiTools) else {
            return
        }
        stackView.insertArrangedSubview(aiTools, at: 3)

        aiTools.snp.makeConstraints { make in
            make.width.equalTo(self)
        }
    }
}
