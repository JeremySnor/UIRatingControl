//
//  UIRatingControl.swift
//  UIRatingControl
//
//  Created by Artem Eremeev on 06.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
public class UIRatingControl: UIControl {

    @IBOutlet private var view: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private var imageViews: [UIImageView]!
    
    private static let defaultStarImage = UIImage(named: "star", in: Bundle(for: UIRatingControl.self), compatibleWith: nil)
    private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    @IBInspectable public var activeIcon: UIImage! = UIRatingControl.defaultStarImage { didSet { reloadRatingUI() } }
    @IBInspectable public var inactiveIcon: UIImage! = UIRatingControl.defaultStarImage { didSet { reloadRatingUI() } }
    
    @IBInspectable public var activeColor: UIColor! = .systemBlue { didSet { reloadRatingUI() } }
    @IBInspectable public var inactiveColor: UIColor! = UIColor.systemBlue.withAlphaComponent(0.3) { didSet { reloadRatingUI() } }
    
    @IBInspectable public var starsSpacing: CGFloat = 0.0 { didSet { stackView.spacing = starsSpacing } }
    
    @IBInspectable public var currentRating: Int = 5 {
        didSet {
            if oldValue != currentRating {
                reloadRatingUI()
                selectionFeedbackGenerator.selectionChanged()
                sendActions(for: .valueChanged)
            }
        }
    }
    
    public override var contentMode: UIView.ContentMode { didSet { set(contentMode: contentMode) } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadUI()
    }
    
    func loadUI() {
        
        backgroundColor = .clear
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UIRatingControl", bundle: bundle)
        view = nib.instantiate(withOwner: self).first as? UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        set(contentMode: contentMode)
        stackView.spacing = starsSpacing
        reloadRatingUI()
        
    }
    
    private func set(contentMode: UIView.ContentMode) {
        imageViews?.forEach({ $0.contentMode = contentMode })
    }
    
    private func reloadRatingUI() {
        for (index, imageView) in (imageViews ?? []).enumerated() {
            let color = index < currentRating ? activeColor : inactiveColor
            let icon = index < currentRating ? activeIcon : inactiveIcon
            
            imageView.image = color == nil ? icon : icon?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = color
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            self.catchLocation(location)
        }
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            self.catchLocation(location)
        }
    }
    
    private func catchLocation(_ location: CGPoint) {
        for (index, imageView) in (imageViews ?? []).enumerated() {
            let imageViewFrame = imageView.frame.insetBy(dx: starsSpacing / 2, dy: 0)
            if imageViewFrame.contains(location) {
                currentRating = index + 1
                break
            }
        }
    }

}
