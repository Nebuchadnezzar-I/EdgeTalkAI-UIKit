//
//  Negotiation.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import SnapKit
import UIKit

final class Negotiation: UIButton, UIGestureRecognizerDelegate {
    var onTap: (() -> Void)?

    // MARK: - UI Elements

    private lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "Negotiation"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()

    private lazy var subText: UILabel = {
        let label = UILabel()
        label.text =
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    // MARK: - Setup Methods

    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupView()
        addGestureRecognizer(gesture)

        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }

    func setupHierarchy() {
        addSubview(mainText)
        addSubview(subText)
    }

    func setupView() {
        mainText.snp.makeConstraints { make in
            make.top.equalTo(self).offset(24)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }

        subText.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }
    }

    // MARK: - Actions

    private lazy var gesture: UILongPressGestureRecognizer = {
        let g = UILongPressGestureRecognizer(
            target: self, action: #selector(handlePress(_:)))
        g.minimumPressDuration = 0.05
        g.delegate = self
        g.cancelsTouchesInView = false
        return g
    }()

    @objc private func handlePress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        scaleDown(to: 0.98, duration: 0.1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.scaleUp(duration: 0.1)
            self.onTap?()
        }
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
            UIGestureRecognizer
    ) -> Bool {
        return true
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return otherGestureRecognizer is UIPanGestureRecognizer
    }
}
