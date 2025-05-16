//
//  Extensions.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 14/05/2025.
//

import UIKit

final class PaddingLabel: UILabel {
    var insets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + insets.left + insets.right,
            height: size.height + insets.top + insets.bottom
        )
    }
}

enum BorderPlacement {
    case top
    case bottom
    case none
}

func dismissKeyboard() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}

final class InsetLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIButton {
    @objc func scaleDown(
        to scale: CGFloat = 0.95,
        duration: TimeInterval = 0.1
    ) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.allowUserInteraction],
            animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        )
    }

    @objc func scaleUp(
        duration: TimeInterval = 0.2
    ) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.allowUserInteraction],
            animations: {
                self.transform = .identity
            }
        )
    }
}
