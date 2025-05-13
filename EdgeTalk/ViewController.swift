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
    }

    // MARK: - Setup Methods

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

}
