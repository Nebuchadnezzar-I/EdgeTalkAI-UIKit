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

    // MARK: - UI Elements

    private lazy var placeholder: UILabel = {
        let view = UILabel()
        view.text = "Chat"
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
        addSubview(placeholder)
    }

    func setupView() {
        placeholder.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }

    // MARK: - Actions

}
