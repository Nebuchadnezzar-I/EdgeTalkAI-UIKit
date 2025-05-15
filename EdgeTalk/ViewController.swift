//
//  ViewController.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 13/05/2025.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties

    // MARK: - UI Elements

    private lazy var header: Header = {
        let header = Header.shared
        return header
    }()

    private lazy var carousel: Carousel = {
        let carousel = Carousel.shared
        return carousel
    }()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.initialize()
    }

    private func initialize() {
        setupHierarchy()
        setupView()
        setupEventHandlers()
    }

    // MARK: - Setup Methods

    func setupEventHandlers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    func setupHierarchy() {
        view.addSubview(header)
        view.addSubview(carousel)

        // Fixes
        view.bringSubviewToFront(header)
    }

    func setupView() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(128)
        }

        carousel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func handleKeyboard(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[
                UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[
                UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let keyboardVisibleHeight =
            UIScreen.main.bounds.height - keyboardFrame.origin.y

        carousel.chat.textFieldBottomConstraint?.update(
            offset: -keyboardVisibleHeight)

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
}
