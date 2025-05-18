//
//  CircularProgressView.swift
//  PersonalGISTPlanner
//
//  Created by Dinda Ayu Syafitri on 18/05/25.
//

import UIKit

final class CircularProgressView: UIView {
    // MARK: - CONSTANT

    private enum Appearance {
        static let lineWidth: CGFloat = 20
        static let bgColor: UIColor = .white
        static let progressColor: UIColor = .blueAccent
    }

    // MARK: - LAYERS

    private lazy var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .butt
        layer.strokeStart = 0
        layer.strokeEnd = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = Appearance.progressColor.cgColor

        return layer
    }()

    private lazy var bgLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = Appearance.lineWidth
        layer.lineCap = .square
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = Appearance.bgColor.cgColor

        return layer
    }()

    // MARK: - LIFECYCLE

    init() {
        super.init(frame: .zero)
        loadLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadLayout()
    }

    // MARK: - LAYOUT

    func loadLayout() {
        layer.addSublayer(bgLayer)
        layer.addSublayer(progressLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: (bounds.width - Appearance.lineWidth) / 2,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 3 / 2,
            clockwise: true
        ).cgPath

        bgLayer.path = circlePath
        progressLayer.path = circlePath
    }

    // MARK: - PUBLIC

    func setProgress(_ progress: CGFloat) {
        let clampedProgress = min(max(progress, 0), 1)

        progressLayer.strokeEnd = clampedProgress
    }
}
