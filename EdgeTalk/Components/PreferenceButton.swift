//
//  PreferenceButton.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 16/05/2025.
//

import SnapKit
import UIKit

final class PreferenceButton: UIView {

    // MARK: - Properties

    private var title: String
    private var borderPlacement: BorderPlacement = .none

    // MARK: - UI Elements

    private lazy var wrapperView: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemBackground

        if self.borderPlacement == .top {
            view.layer.cornerRadius = 24
            view.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
            ]
        }

        if self.borderPlacement == .bottom {
            view.layer.cornerRadius = 24
            view.layer.maskedCorners = [
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner,
            ]
        }

        view.addTarget(self, action: #selector(scaleDownTap), for: .touchDown)
        view.addTarget(
            self, action: #selector(scaleUpTap),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])

        view.clipsToBounds = true
        return view
    }()

    private lazy var label: InsetLabel = {
        let label = InsetLabel()
        label.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .left
        label.layer.cornerRadius = 4
        label.text = title
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()

    // MARK: - Initializers

    init(frame: CGRect, title: String, borderPlacement: BorderPlacement) {
        self.title = title
        self.borderPlacement = borderPlacement
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        self.title = "NSCoder"
        self.borderPlacement = .none
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
        addSubview(wrapperView)
        wrapperView.addSubview(label)
    }

    func setupView() {
        wrapperView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(48)
        }

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc private func scaleDownTap(_ sender: UIButton) {
        sender.scaleDown(to: 0.98, duration: 0.1)
    }

    @objc private func scaleUpTap(_ sender: UIButton) {
        sender.scaleUp(duration: 0.1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Carousel.shared.removeChat()
            Carousel.shared.removeAIOptions()
            Carousel.shared.addPreferencesConfigBack()

            Header.shared.updateTitles([
                "Negotiations",
                "Preferences",
                self.title,
            ])

            Carousel.shared.scrollToPage(index: 2)
        }
    }
}
