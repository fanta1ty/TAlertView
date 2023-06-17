import AVFoundation
import Foundation
import UIKit

public class TAlertView: UIView {
    public var backgroundVisualEffectView: UIVisualEffectView = .init()
    public var defaultHeight: CGFloat = 0.0
    public var defaultSpacing: CGFloat = 0.0
    public var alertView: UIView = .init()
    public var alertViewContents: UIView = .init()
    public var circleLayer: CAShapeLayer = .init()
    public var alertButtons: [TAlertButton]
    public var alertTextFields: [TAlertTextField]
    public var alertTextFieldHolder: [UITextField]
    public var alertViewWithVector = 0
    public var doneTitle = ""
    public var vectorImage: UIImage?
    public var alertType = ""
    public var alertViewFrame: CGRect = .zero
    public var currentAVCFrames: CGRect = .zero
    public var descriptionLabelFrames: CGRect = .zero
    public var player: AVAudioPlayer = .init()
    public var alertTypeRatingHearts = 0
    public var alertTypeRatingStars = 0
    public var ratingController: UIView = .init()
    public var item1: UIButton = .init()
    public var item2: UIButton = .init()
    public var item3: UIButton = .init()
    public var item4: UIButton = .init()
    public var item5: UIButton = .init()
    public var currentRating = 0

    public weak var delegate: TAlertViewDelegate?
    public var title: String = ""
    public var subTitle: String = ""
    public var attributedTitle: NSAttributedString = .init(string: "")
    public var attributedSubTitle: NSAttributedString = .init(string: "")
    public var titleFont: UIFont
    public var subtitleFont: UIFont?
    public var alertBackground: UIView!
    public var textField: UITextField?
    public var customHeight: CGFloat = 0.0
    public var customSpacing: CGFloat = 0.0
    public var numberOfButtons: Int
    public var autoHideSeconds: Int
    public var cornerRadius: CGFloat
    public var dismissOnOutsideTouch: Bool
    public var overrideForcedDismiss: Bool = false
    public var hideAllButtons: Bool
    public var hideDoneButton: Bool
    public var avoidCustomImageTint: Bool
    public var blurBackground: Bool
    public var bounceAnimations: Bool
    public var darkTheme: Bool
    public var detachButtons: Bool
    public var fullCircleCustomImage: Bool
    public var hideSeparatorLineView: Bool
    public var customImageScale: CGFloat

    public typealias TRatingBlock = (Int) -> Void
    public var ratingBlock: TRatingBlock?

    public typealias TActionBlock = () -> Void
    public var actionBlock: TActionBlock?
    public var doneBlock: TActionBlock?

    public typealias TTextReturnBlock = (String) -> Void
    public var textReturnBlock: TTextReturnBlock?
    public var colorScheme: UIColor?
    public var titleColor: UIColor?
    public var subTitleColor: UIColor?
    public var alertBackgroundColor: UIColor?

    public var doneButtonTitleColor: UIColor?
    public var doneButtonCustomFont: UIFont?
    public var doneButtonHighlightedBackgroundColor: UIColor?

    public var firstButtonTitleColor: UIColor?
    public var firstButtonCustomFont: UIFont?
    public var firstButtonBackgroundColor: UIColor?
    public var firstButtonHighlightedBackgroundColor: UIColor?

    public var secondButtonTitleColor: UIColor?
    public var secondButtonCustomFont: UIFont?
    public var secondButtonBackgroundColor: UIColor?
    public var secondButtonHighlightedBackgroundColor: UIColor?

    public var flatTurquoise: UIColor
    public var flatGreen: UIColor
    public var flatBlue: UIColor
    public var flatMidnight: UIColor
    public var flatPurple: UIColor
    public var flatOrange: UIColor
    public var flatRed: UIColor
    public var flatSilver: UIColor
    public var flatGray: UIColor

    private var animateAlertOutToTop: Bool = false
    private var animateAlertInFromTop: Bool = false

    private var animateAlertInFromRight: Bool = false
    private var animateAlertOutToRight: Bool = false

    private var animateAlertInFromBottom: Bool = false
    private var animateAlertOutToBottom: Bool = false

    private var animateAlertInFromLeft: Bool = false
    private var animateAlertOutToLeft: Bool = false

    public init() {
        self.flatTurquoise = .init(
            red: 26.0 / 255.0,
            green: 188.0 / 255.0,
            blue: 156.0 / 255.0,
            alpha: 1.0
        )
        self.flatGreen = .init(
            red: 39.0 / 255.0,
            green: 174.0 / 255.0,
            blue: 96.0 / 255.0,
            alpha: 1.0
        )
        self.flatBlue = .init(
            red: 41.0 / 255.0,
            green: 128.0 / 255.0,
            blue: 185.0 / 255.0,
            alpha: 1.0
        )
        self.flatMidnight = .init(
            red: 44.0 / 255.0,
            green: 62.0 / 255.0,
            blue: 80.0 / 255.0,
            alpha: 1.0
        )
        self.flatPurple = .init(
            red: 142.0 / 255.0,
            green: 68.0 / 255.0,
            blue: 173.0 / 255.0,
            alpha: 1.0
        )
        self.flatOrange = .init(
            red: 243.0 / 255.0,
            green: 156.0 / 255.0,
            blue: 18.0 / 255.0,
            alpha: 1.0
        )
        self.flatSilver = .init(
            red: 189.0 / 255.0,
            green: 195.0 / 255.0,
            blue: 199.0 / 255.0,
            alpha: 1.0
        )
        self.flatGray = .init(
            red: 127.0 / 255.0,
            green: 140.0 / 255.0,
            blue: 141.0 / 255.0,
            alpha: 1.0
        )
        self.flatRed = .init(
            red: 192.0 / 255.0,
            green: 57.0 / 255.0,
            blue: 43.0 / 255.0,
            alpha: 1.0
        )

        self.alertButtons = [TAlertButton]()
        self.alertTextFields = [TAlertTextField]()
        self.alertTextFieldHolder = [UITextField]()
        self.numberOfButtons = 0
        self.autoHideSeconds = 0
        self.cornerRadius = 18.0

        self.dismissOnOutsideTouch = false
        self.hideAllButtons = false
        self.hideDoneButton = false
        self.avoidCustomImageTint = false
        self.blurBackground = false
        self.bounceAnimations = false
        self.darkTheme = false
        self.detachButtons = false
        self.fullCircleCustomImage = false
        self.hideSeparatorLineView = false

        self.customImageScale = 1
        self.titleFont = .systemFont(
            ofSize: 18.0,
            weight: .medium
        )
        self.subtitleFont = nil
        super.init(frame: .zero)

        let result = UIScreen.main.bounds.size

        frame = .init(
            x: 0,
            y: 0,
            width: result.width,
            height: result.height
        )

        backgroundColor = .clear

        self.alertBackground = .init(frame: .init(
            x: 0,
            y: 0,
            width: result.width,
            height: result.height
        ))
        alertBackground.backgroundColor = .init(
            white: 0,
            alpha: 0.35
        )

        addSubview(alertBackground)

        self.defaultSpacing = configureAVWidth()
        self.defaultHeight = configureAVHeight()

        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                darkTheme = true
            }
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func touchesBegan(
        _ touches: Set<UITouch>,
        with _: UIEvent?
    ) {
        if alertTypeRatingStars != 0 || alertTypeRatingHearts != 0 {
            guard let touch = touches.first else { return }

            if
                item1.point(
                    inside: touch.location(in: item1),
                    with: nil
                )
            {
                rate1Triggered()
            }

            if
                item2.point(
                    inside: touch.location(in: item2),
                    with: nil
                )
            {
                rate2Triggered()
            }

            if
                item3.point(
                    inside: touch.location(in: item3),
                    with: nil
                )
            {
                rate3Triggered()
            }

            if
                item4.point(
                    inside: touch.location(in: item4),
                    with: nil
                )
            {
                rate4Triggered()
            }

            if
                item5.point(
                    inside: touch.location(in: item5),
                    with: nil
                )
            {
                rate5Triggered()
            }
        }
    }

    override public func touchesMoved(
        _ touches: Set<UITouch>,
        with _: UIEvent?
    ) {
        if alertTypeRatingStars != 0 || alertTypeRatingHearts != 0 {
            guard let touch = touches.first else { return }

            if
                item1.point(
                    inside: touch.location(in: item1),
                    with: nil
                )
            {
                rate1Triggered()
            }

            if
                item2.point(
                    inside: touch.location(in: item2),
                    with: nil
                )
            {
                rate2Triggered()
            }

            if
                item3.point(
                    inside: touch.location(in: item3),
                    with: nil
                )
            {
                rate3Triggered()
            }

            if
                item4.point(
                    inside: touch.location(in: item4),
                    with: nil
                )
            {
                rate4Triggered()
            }

            if
                item5.point(
                    inside: touch.location(in: item5),
                    with: nil
                )
            {
                rate5Triggered()
            }
        }
    }

    override public func touchesEnded(
        _ touches: Set<UITouch>,
        with _: UIEvent?
    ) {
        guard let touch = touches.first else { return }

        let touchPoint = touch.location(in: alertBackground)
        let touchPoint2 = touch.location(in: alertViewContents)

        let isPointInsideBackview = alertBackground.point(inside: touchPoint, with: nil)
        let isPointInsideAlertView = alertViewContents.point(inside: touchPoint2, with: nil)

        if dismissOnOutsideTouch, isPointInsideBackview, !isPointInsideAlertView {
            dismissAlertView()
        }

        if !alertTextFields.isEmpty, isPointInsideBackview, !isPointInsideAlertView {
            endEditing(true)
        }
    }

    override public func draw(_: CGRect) {
        defaultSpacing = configureAVWidth()
        defaultHeight = configureAVHeight()

        let result = UIScreen.main.bounds.size
        alpha = 0

        if alertViewWithVector != 0 {
            alertViewFrame = .init(
                x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                y: frame.size.height / 2 - (200.0 / 2),
                width: result.width - defaultSpacing,
                height: defaultHeight
            )
        } else {
            alertViewFrame = .init(
                x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                y: frame.size.height / 2 - (170.0 / 2),
                width: result.width - defaultSpacing,
                height: defaultHeight - 30
            )
        }

        if !hasTitle() {
            alertViewFrame = .init(
                x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                y: frame.size.height / 2 - ((alertViewFrame.size.height - 50) / 2),
                width: result.width - defaultSpacing,
                height: alertViewFrame.size.height - 10
            )
        }

        if hideAllButtons {
            alertViewFrame = .init(
                x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                y: frame.size.height / 2 - ((alertViewFrame.size.height - 50) / 2),
                width: result.width - defaultSpacing,
                height: alertViewFrame.size.height - 45.0
            )
        } else {
            if hideDoneButton, numberOfButtons == 0 {
                alertViewFrame = .init(
                    x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                    y: frame.size.height / 2 - ((alertViewFrame.size.height - 50) / 2),
                    width: result.width - defaultSpacing,
                    height: alertViewFrame.size.height - 45
                )
            }
            if !hideDoneButton, numberOfButtons >= 2 {
                alertViewFrame = .init(
                    x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                    y: frame.size.height / 2 - ((alertViewFrame.size.height - 50 + 140) / 2),
                    width: result.width - defaultSpacing,
                    height: alertViewFrame.size.height - 50 + 140
                )
            }
        }

        if !alertTextFields.isEmpty {
            let xValue = (result.width - defaultSpacing) / 2.0
            let minY = CGFloat.minimum(CGFloat(alertTextFields.count), 4.0)
            let yValue = (alertViewFrame.size.height + 45.0 * minY) / 2.0
            let minHeight = CGFloat.minimum(CGFloat(alertTextFields.count), 4.0)
            alertViewFrame = .init(
                x: frame.size.width / 2.0 - xValue,
                y: frame.size.height / 2.0 - yValue,
                width: result.width - defaultSpacing,
                height: alertViewFrame.size.height + 45 * minHeight
            )
        } else {
            let xValue = (result.width - defaultSpacing) / 2.0
            let yValue = (alertViewFrame.size.height - 50 + 140) / 2.0
            alertViewFrame = .init(
                x: frame.size.width / 2.0 - xValue,
                y: frame.size.height / 2.0 - yValue,
                width: result.width - defaultSpacing,
                height: alertViewFrame.size.height
            )
        }

        if alertTypeRatingStars != 0 || alertTypeRatingHearts != 0 {
            alertViewFrame = .init(
                x: frame.size.width / 2 - ((result.width - defaultSpacing) / 2),
                y: frame.size.height / 2 - ((alertViewFrame.size.height - 50 + 140) / 2),
                width: result.width - defaultSpacing,
                height: alertViewFrame.size.height + 50
            )
        }

        if UIApplication.shared.statusBarOrientation.isLandscape {
            alertViewFrame = .init(
                x: frame.size.width / 2 - (300 / 2),
                y: frame.size.height / 2 - (alertViewFrame.size.height / 2),
                width: 300,
                height: alertViewFrame.size.height
            )
        }

        var descriptionLevel: CGFloat = 45.0
        if !hasTitle() {
            descriptionLevel = 15.0
            alertViewFrame = .init(
                x: alertViewFrame.origin.x,
                y: alertViewFrame.origin.y,
                width: alertViewFrame.size.width,
                height: alertViewFrame.size.height - 20
            )
        }
        let descriptionLabel = UILabel(frame: .init(
            x: 25.0,
            y: descriptionLevel + CGFloat(alertViewWithVector * 30),
            width: alertViewFrame.size.width - 50.0,
            height: 60.0
        )
        )
        if subtitleFont != nil {
            descriptionLabel.font = subtitleFont!
        } else if !title.isEmpty {
            descriptionLabel.font = .systemFont(ofSize: 15.0, weight: .light)
        } else {
            descriptionLabel.font = .systemFont(ofSize: 16.0, weight: .regular)
        }

        descriptionLabel.textColor = subTitleColor
        if subTitle.isEmpty {
            descriptionLabel.attributedText = attributedSubTitle
        } else {
            descriptionLabel.text = subTitle
        }
        descriptionLabel.textAlignment = .center
        descriptionLabel.adjustsFontSizeToFitWidth = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail

        let titleLabel = UILabel(frame: .init(
            x: 15.0,
            y: 20.0 + CGFloat(alertViewWithVector * 30),
            width: alertViewFrame.size.width - 30.0,
            height: 30.0
        ))
        titleLabel.font = titleFont
        titleLabel.numberOfLines = 1
        titleLabel.textColor = titleColor
        if title.isEmpty {
            titleLabel.attributedText = attributedTitle
        } else {
            titleLabel.text = title
        }
        titleLabel.textAlignment = .center

        if let titleText = titleLabel.text {
            let size = (titleText as NSString).size(withAttributes: [.font: titleLabel.font!])
            if size.width > titleLabel.bounds.size.width {
                titleLabel.numberOfLines = 2
                titleLabel.frame = .init(
                    x: titleLabel.frame.origin.x,
                    y: titleLabel.frame.origin.y,
                    width: titleLabel.frame.size.width,
                    height: 60.0
                )

                descriptionLabel.frame = .init(
                    x: descriptionLabel.frame.origin.x,
                    y: descriptionLabel.frame.origin.y + 30.0,
                    width: descriptionLabel.frame.size.width,
                    height: descriptionLabel.frame.size.height
                )

                alertViewFrame = .init(
                    x: alertViewFrame.origin.x,
                    y: alertViewFrame.origin.y,
                    width: alertViewFrame.size.width,
                    height: alertViewFrame.size.height + 30.0
                )
            }
        }

        let constraint = CGSizeMake(descriptionLabel.frame.size.width, CGFLOAT_MAX)
        let context = NSStringDrawingContext()

        if let descriptionText = descriptionLabel.text {
            let boundingBox = (descriptionText as NSString).boundingRect(
                with: constraint,
                options: .usesLineFragmentOrigin,
                attributes: [.font: descriptionLabel.font!],
                context: context
            ).size
            let heightDiff = descriptionLabel.frame.size.height - boundingBox.height

            descriptionLabel.frame = .init(
                x: descriptionLabel.frame.origin.x,
                y: descriptionLabel.frame.origin.y + 7.5,
                width: descriptionLabel.frame.size.width,
                height: boundingBox.height
            )

            alertViewFrame = .init(
                x: alertViewFrame.origin.x,
                y: alertViewFrame.origin.y + ((heightDiff + 15.0) / 2.0),
                width: alertViewFrame.size.width,
                height: alertViewFrame.size.height - heightDiff + 15.0
            )

            descriptionLabelFrames = descriptionLabel.frame
        }

        alertViewContents = UIView(frame: alertViewFrame)
        addSubview(alertViewContents)

        alertView = UIView(frame: .init(
            x: 0.0,
            y: 0.0,
            width: alertViewFrame.size.width,
            height: alertViewFrame.size.height
        ))

        if alertViewWithVector != 0 {
            alertView.backgroundColor = .clear
        } else {
            if alertBackgroundColor == nil {
                alertView.backgroundColor = .white
            } else {
                alertView.backgroundColor = alertBackgroundColor!
            }
            if darkTheme {
                alertView.backgroundColor = .init(white: 48.0 / 255.0, alpha: 1.0)
            }
        }

        alertViewContents.addSubview(alertView)

        let radius = alertView.frame.size.width
        let rectPath = UIBezierPath(
            roundedRect: .init(
                x: 0.0,
                y: 0.0,
                width: frame.size.width,
                height: alertView.bounds.size.height
            ),
            cornerRadius: 0
        )
        let circlePath = UIBezierPath(
            roundedRect: .init(
                x: alertViewFrame.size.width / 2.0 - 33.75,
                y: -33.75,
                width: 67.5,
                height: 67.5
            ),
            cornerRadius: radius
        )
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true

        let fillLayer: CAShapeLayer = .init()
        fillLayer.path = rectPath.cgPath
        fillLayer.fillRule = .evenOdd
        if alertBackgroundColor == nil {
            fillLayer.fillColor = UIColor.white.cgColor
        } else {
            fillLayer.fillColor = alertBackgroundColor!.cgColor
        }

        if darkTheme {
            fillLayer.fillColor = UIColor(white: 48.0 / 255.0, alpha: 1.0).cgColor
        }
        fillLayer.opacity = 1.0

        if alertViewWithVector != 0 {
            alertView.layer.addSublayer(fillLayer)
        }

        let separatorLineView = UIView(frame: .init(
            x: 0,
            y: alertViewFrame.size.height - 47.0,
            width: alertViewFrame.size.width,
            height: 2.0
        ))
        separatorLineView.backgroundColor = .init(white: 100.0 / 255.0, alpha: 1.0)

        if darkTheme {
            separatorLineView.backgroundColor = .init(white: 58.0 / 255.0, alpha: 1.0)
        }

        if !alertTextFields.isEmpty {
            var index = 0
            let maxTextField = min<Int>(alertTextFields.count, 4)

            for textFieldItem in alertTextFields {
                guard index < maxTextField else { break }

                let yField = descriptionLabel.frame.size.height + descriptionLabel.frame.origin.y + 10.5 + CGFloat(45 * index)

                let subTextField = UITextField(frame: .init(
                    x: 12.5,
                    y: yField,
                    width: alertViewFrame.size.width - 25.0,
                    height: 40.0
                ))

                if subTextField.layer.cornerRadius == 0 {
                    subTextField.layer.cornerRadius = 3.0
                }
                subTextField.layer.masksToBounds = true
                subTextField.layer.borderColor = UIColor(white: 217.0 / 255.0, alpha: 1.0).cgColor

                if subTextField.layer.borderWidth == 0 {
                    subTextField.layer.borderWidth = 1
                }
                subTextField.delegate = self
                subTextField.tag = index

                if subTextField.placeholder == nil, textFieldItem.placeholder != nil {
                    subTextField.placeholder = textFieldItem.placeholder!
                }

                if darkTheme {
                    subTextField.backgroundColor = .init(white: 227.0 / 255.0, alpha: 1.0)
                } else {
                    subTextField.backgroundColor = .white
                }

                if index + 1 == maxTextField {
                    subTextField.returnKeyType = .done
                } else {
                    subTextField.returnKeyType = .next
                }

                let paddingView = UIView(frame: .init(
                    x: 0,
                    y: 0,
                    width: 5,
                    height: 20
                ))
                subTextField.leftView = paddingView
                subTextField.leftViewMode = .always

                alertTextFieldHolder.append(subTextField)
                alertView.addSubview(subTextField)

                index += 1
            }
        }

        if numberOfButtons == 0 {
            let doneButton = UIButton(type: .system)

            if colorScheme == nil {
                doneButton.backgroundColor = .white

                if detachButtons {
                    doneButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
                }
                if darkTheme {
                    doneButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
                }
            } else {
                doneButton.backgroundColor = colorScheme
            }

            if doneButtonHighlightedBackgroundColor != nil {
                doneButton.setBackgroundImage(
                    imageWithColor(color: doneButtonHighlightedBackgroundColor!),
                    for: .highlighted
                )
            }

            doneButton.frame = .init(
                x: 0,
                y: alertViewFrame.size.height - 45.0,
                width: alertViewFrame.size.width,
                height: 45.0
            )

            if detachButtons {
                doneButton.frame = .init(
                    x: 8,
                    y: alertViewFrame.size.height - 50,
                    width: alertViewFrame.size.width - 16,
                    height: 40.0
                )

                let minRadius = min<CGFloat>(cornerRadius, doneButton.frame.size.height / 2.0)
                doneButton.layer.cornerRadius = minRadius
                doneButton.layer.masksToBounds = true
            }

            doneButton.setTitle(doneTitle, for: .normal)
            doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            doneButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)
            doneButton.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)

            if doneButtonCustomFont != nil {
                doneButton.titleLabel?.font = doneButtonCustomFont!
            }
            if colorScheme != nil || darkTheme {
                doneButton.tintColor = .white
            }
            if doneButtonTitleColor != nil {
                doneButton.tintColor = doneButtonTitleColor!
            }
            if !hideAllButtons, !hideDoneButton {
                alertView.addSubview(doneButton)
            }

        } else if numberOfButtons == 1 {
            let doneButton = UIButton(type: .system)

            if colorScheme == nil {
                doneButton.backgroundColor = .white

                if detachButtons {
                    doneButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
                }
                if darkTheme {
                    doneButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
                }
            } else {
                doneButton.backgroundColor = colorScheme
            }

            if doneButtonHighlightedBackgroundColor != nil {
                doneButton.setBackgroundImage(
                    imageWithColor(color: doneButtonHighlightedBackgroundColor!),
                    for: .highlighted
                )
            }

            doneButton.frame = .init(
                x: alertViewFrame.size.width / 2.0,
                y: alertViewFrame.size.height - 45.0,
                width: alertViewFrame.size.width / 2.0,
                height: 45.0
            )

            if detachButtons {
                doneButton.frame = .init(
                    x: alertViewFrame.size.width / 2.0 + 6.0,
                    y: doneButton.frame.origin.y - 5.0,
                    width: doneButton.frame.size.width - 16.0,
                    height: 40.0
                )

                let minRadius = min<CGFloat>(cornerRadius, doneButton.frame.size.height / 2.0)
                doneButton.layer.cornerRadius = minRadius
                doneButton.layer.masksToBounds = true
            }

            doneButton.setTitle(doneTitle, for: .normal)
            doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            doneButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)
            doneButton.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)

            if doneButtonCustomFont != nil {
                doneButton.titleLabel?.font = doneButtonCustomFont!
            }
            if colorScheme != nil || darkTheme {
                doneButton.tintColor = .white
            }
            if doneButtonTitleColor != nil {
                doneButton.tintColor = doneButtonTitleColor!
            }

            let otherButton = UIButton(type: .system)
            otherButton.backgroundColor = .white

            if detachButtons {
                otherButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
            }

            if darkTheme {
                otherButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
            }

            if firstButtonBackgroundColor != nil {
                otherButton.backgroundColor = firstButtonBackgroundColor!
            }

            if firstButtonHighlightedBackgroundColor != nil {
                otherButton.setBackgroundImage(
                    imageWithColor(color: firstButtonHighlightedBackgroundColor!),
                    for: .highlighted
                )
            }

            otherButton.frame = .init(
                x: 0,
                y: alertViewFrame.size.height - 45.0,
                width: alertViewFrame.size.width / 2.0,
                height: 45.0
            )

            if hideDoneButton {
                otherButton.frame = .init(
                    x: 0,
                    y: alertViewFrame.size.height - 45.0,
                    width: alertViewFrame.size.width,
                    height: 45.0
                )
            }

            if detachButtons {
                otherButton.frame = .init(
                    x: alertViewFrame.size.width / 2.0 - otherButton.frame.size.width + 16.0 - 6.0,
                    y: otherButton.frame.origin.y - 5.0,
                    width: otherButton.frame.size.width - 16.0,
                    height: 45.0
                )
                let minRadius = min<CGFloat>(cornerRadius, otherButton.frame.size.height / 2.0)
                otherButton.layer.cornerRadius = minRadius
                otherButton.layer.masksToBounds = true
            }

            if let alertButton = alertButtons.first {
                otherButton.setTitle(alertButton.title, for: .normal)
            }
            otherButton.addTarget(self, action: #selector(handleButton(sender:)), for: .touchUpInside)
            otherButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            otherButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)

            otherButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .regular)

            if firstButtonCustomFont != nil {
                otherButton.titleLabel?.font = firstButtonCustomFont!
            }
            otherButton.tintColor = colorScheme

            if colorScheme == nil, darkTheme {
                otherButton.tintColor = .white
            }
            if firstButtonTitleColor != nil {
                otherButton.tintColor = firstButtonTitleColor!
            }

            otherButton.titleLabel?.adjustsFontSizeToFitWidth = true
            otherButton.titleLabel?.minimumScaleFactor = 0.8

            if !hideAllButtons {
                alertView.addSubview(otherButton)
            }

            if !hideAllButtons, !hideDoneButton {
                alertView.addSubview(doneButton)
            }

            if
                !hideAllButtons,
                !hideDoneButton,
                !detachButtons,
                !hideSeparatorLineView
            {
                let horizontalSeparator = UIView(frame: .init(
                    x: alertViewFrame.size.width / 2.0 - 1.0,
                    y: otherButton.frame.origin.y - 2.0,
                    width: 2.0,
                    height: 47.0
                ))
                horizontalSeparator.backgroundColor = .init(white: 100.0 / 255.0, alpha: 1.0)

                if darkTheme {
                    horizontalSeparator.backgroundColor = .init(white: 58.0 / 255.0, alpha: 1.0)
                }

                var blurEffect: UIBlurEffect = .init(style: .extraLight)
                if darkTheme {
                    blurEffect = .init(style: .dark)
                }
                let visualEffectView3 = UIVisualEffectView(effect: blurEffect)
                visualEffectView3.frame = horizontalSeparator.bounds
                visualEffectView3.isUserInteractionEnabled = false
                horizontalSeparator.addSubview(visualEffectView3)

                alertView.addSubview(horizontalSeparator)
            }

        } else if numberOfButtons >= 2 {
            let firstButton = UIButton(type: .system)
            firstButton.backgroundColor = .white

            if detachButtons {
                firstButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
            }
            if darkTheme {
                firstButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
            }

            if firstButtonBackgroundColor != nil {
                firstButton.backgroundColor = firstButtonBackgroundColor!
            }

            if firstButtonHighlightedBackgroundColor != nil {
                firstButton.setBackgroundImage(
                    imageWithColor(color: firstButtonHighlightedBackgroundColor!),
                    for: .highlighted
                )
            }
            firstButton.frame = .init(
                x: 0,
                y: alertViewFrame.size.height - 135.0,
                width: alertViewFrame.size.width,
                height: 45.0
            )

            if hideDoneButton {
                firstButton.frame = .init(
                    x: 0,
                    y: alertViewFrame.size.height - 45.0,
                    width: alertViewFrame.size.width / 2.0,
                    height: 45.0
                )
            }

            if detachButtons {
                firstButton.frame = .init(
                    x: firstButton.frame.origin.x + 8.0,
                    y: firstButton.frame.origin.y - 5.0,
                    width: firstButton.frame.size.width - 16.0,
                    height: 40.0
                )
                let minRadius = min<CGFloat>(cornerRadius, firstButton.frame.size.height / 2.0)
                firstButton.layer.cornerRadius = minRadius
                firstButton.layer.masksToBounds = true
            }

            if let alertBtn = alertButtons.first {
                firstButton.setTitle(alertBtn.title, for: .normal)
            }
            firstButton.addTarget(self, action: #selector(handleButton(sender:)), for: .touchUpInside)
            firstButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            firstButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)
            firstButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .regular)

            if firstButtonCustomFont != nil {
                firstButton.titleLabel?.font = firstButtonCustomFont!
            }
            firstButton.tintColor = colorScheme
            if colorScheme == nil && darkTheme {
                firstButton.tintColor = .white
            }
            if firstButtonTitleColor != nil {
                firstButton.tintColor = firstButtonTitleColor!
            }

            firstButton.titleLabel?.adjustsFontSizeToFitWidth = true
            firstButton.titleLabel?.minimumScaleFactor = 0.8
            firstButton.tag = 0

            let secondButton = UIButton(type: .system)
            secondButton.backgroundColor = .white
            if detachButtons {
                secondButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
            }
            if darkTheme {
                secondButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
            }
            if secondButtonBackgroundColor != nil {
                secondButton.backgroundColor = secondButtonBackgroundColor!
            }
            if secondButtonHighlightedBackgroundColor != nil {
                secondButton.setBackgroundImage(imageWithColor(color: secondButtonHighlightedBackgroundColor!), for: .highlighted)
            }
            secondButton.frame = .init(
                x: 0,
                y: alertViewFrame.size.height - 90.0,
                width: alertViewFrame.size.width,
                height: 45.0
            )
            if hideDoneButton {
                secondButton.frame = .init(
                    x: alertViewFrame.size.width / 2.0,
                    y: alertViewFrame.size.height - 45.0,
                    width: alertViewFrame.size.width / 2.0,
                    height: 45.0
                )
            }
            if detachButtons {
                secondButton.frame = .init(
                    x: secondButton.frame.origin.x + 8.0,
                    y: secondButton.frame.origin.y - 5.0,
                    width: secondButton.frame.size.width - 16.0,
                    height: 40.0
                )
                let minRadius = min<CGFloat>(cornerRadius, secondButton.frame.size.height / 2.0)
                secondButton.layer.cornerRadius = minRadius
                secondButton.layer.masksToBounds = true
            }
            if alertButtons.count > 1 {
                let alertBtn = alertButtons[1]
                secondButton.setTitle(alertBtn.title, for: .normal)
            }
            secondButton.addTarget(self, action: #selector(handleButton(sender:)), for: .touchUpInside)
            secondButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            secondButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)
            secondButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .regular)
            if secondButtonCustomFont != nil {
                secondButton.titleLabel?.font = secondButtonCustomFont!
            }
            secondButton.tintColor = colorScheme
            if colorScheme == nil && darkTheme {
                secondButton.tintColor = .white
            }
            if secondButtonTitleColor != nil {
                secondButton.tintColor = secondButtonTitleColor!
            }
            secondButton.titleLabel?.adjustsFontSizeToFitWidth = true
            secondButton.titleLabel?.minimumScaleFactor = 0.8
            secondButton.tag = 1

            let doneButton = UIButton(type: .system)
            if colorScheme == nil {
                doneButton.backgroundColor = .white
                if detachButtons {
                    doneButton.backgroundColor = .init(white: 228.0 / 255.0, alpha: 1.0)
                }
                if darkTheme {
                    doneButton.backgroundColor = .init(white: 78.0 / 255.0, alpha: 1.0)
                }
            } else {
                doneButton.backgroundColor = colorScheme!
            }

            if doneButtonHighlightedBackgroundColor != nil {
                doneButton.setBackgroundImage(
                    imageWithColor(color: doneButtonHighlightedBackgroundColor!),
                    for: .highlighted
                )
            }

            doneButton.frame = .init(
                x: 0,
                y: alertViewFrame.size.height - 45.0,
                width: alertViewFrame.size.width,
                height: 45.0
            )

            if detachButtons {
                doneButton.frame = .init(
                    x: 8.0,
                    y: alertViewFrame.size.height - 50.0,
                    width: alertViewFrame.size.width - 16.0,
                    height: 40.0
                )

                let minRadius = min<CGFloat>(cornerRadius, doneButton.frame.size.height / 2.0)
                doneButton.layer.cornerRadius = minRadius
                doneButton.layer.masksToBounds = true
            }

            doneButton.setTitle(doneTitle, for: .normal)
            doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(buttonTouched), for: .touchDown)
            doneButton.addTarget(self, action: #selector(buttonReleased), for: .touchDragExit)
            doneButton.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .medium)

            if doneButtonCustomFont != nil {
                doneButton.titleLabel?.font = doneButtonCustomFont!
            }
            if colorScheme != nil || darkTheme {
                doneButton.tintColor = .white
            }
            if doneButtonTitleColor != nil {
                doneButton.tintColor = doneButtonTitleColor!
            }
            if !hideAllButtons {
                alertView.addSubview(firstButton)
                alertView.addSubview(secondButton)
            }
            if !hideAllButtons, !hideDoneButton {
                alertView.addSubview(doneButton)
            }

            let firstSeparator = UIView(frame: .init(
                x: 0,
                y: firstButton.frame.origin.y - 2.0,
                width: alertViewFrame.size.width,
                height: 2.0
            ))
            firstSeparator.backgroundColor = .init(white: 100.0 / 255.0, alpha: 1.0)
            if darkTheme {
                firstSeparator.backgroundColor = .init(white: 58.0 / 255.0, alpha: 1.0)
            }

            let secondSeparator = UIView(frame: .init(
                x: 0,
                y: secondButton.frame.origin.y - 2.0,
                width: alertViewFrame.size.width,
                height: 2.0
            ))
            if hideDoneButton {
                secondSeparator.frame = .init(
                    x: alertViewFrame.size.width / 2.0 - 1.0,
                    y: secondButton.frame.origin.y,
                    width: 2.0,
                    height: 45.0
                )
            }
            secondSeparator.backgroundColor = .init(white: 100.0 / 255.0, alpha: 1.0)
            if darkTheme {
                secondSeparator.backgroundColor = .init(white: 58.0 / 255.0, alpha: 1.0)
            }
            var blurEffect: UIBlurEffect = .init(style: .extraLight)
            if darkTheme {
                blurEffect = .init(style: .dark)
            }
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.frame = firstSeparator.bounds
            visualEffectView.isUserInteractionEnabled = false
            firstSeparator.addSubview(visualEffectView)

            let visualEffectView2 = UIVisualEffectView(effect: blurEffect)
            visualEffectView2.frame = secondSeparator.bounds
            visualEffectView2.isUserInteractionEnabled = false
            secondSeparator.addSubview(visualEffectView2)

            if
                !hideAllButtons,
                !detachButtons,
                !hideSeparatorLineView
            {
                alertView.addSubview(firstSeparator)
                alertView.addSubview(secondSeparator)
            }
        }

        var blurEffect: UIBlurEffect = .init(style: .extraLight)
        if darkTheme {
            blurEffect = .init(style: .dark)
        }
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = separatorLineView.bounds
        visualEffectView.isUserInteractionEnabled = false
        separatorLineView.addSubview(visualEffectView)

        if !fullCircleCustomImage {
            circleLayer = CAShapeLayer()
            circleLayer.path = UIBezierPath(ovalIn: .init(
                x: alertViewContents.frame.size.width / 2 - 30.0,
                y: -30.0,
                width: 60.0,
                height: 60.0
            )).cgPath
            if alertBackgroundColor == nil {
                circleLayer.fillColor = UIColor.white.cgColor
            } else {
                circleLayer.fillColor = alertBackgroundColor!.cgColor
            }
        }
        if darkTheme {
            circleLayer.fillColor = UIColor(white: 48.0 / 255.0, alpha: 1.0).cgColor
        }
        if alertType == "Progress" && colorScheme != nil {
            circleLayer.fillColor = colorScheme!.cgColor
        }

        let spinner = UIActivityIndicatorView(frame: .init(
            x: alertViewContents.frame.size.width / 2.0 - 30.0,
            y: -30.0,
            width: 60.0,
            height: 60.0
        ))
        if let circleLayerFillColor = circleLayer.fillColor, circleLayerFillColor == UIColor.white.cgColor {
            spinner.style = .gray
        } else {
            spinner.style = .white
        }
        spinner.startAnimating()

        let alertViewVector = UIImageView()
        if avoidCustomImageTint && alertType.isEmpty {
            alertViewVector.image = vectorImage
        } else {
            alertViewVector.image = vectorImage?.withRenderingMode(.alwaysTemplate)
        }

        if fullCircleCustomImage {
            customImageScale = 2.0
        }

        if customImageScale <= 0 {
            customImageScale = 1.0
        }

        let vectorSize = 30.0 * min<CGFloat>(2, customImageScale)
        alertViewVector.frame = .init(
            x: alertViewContents.frame.size.width / 2.0 - (vectorSize / 2.0),
            y: -(vectorSize / 2.0) - 0.5,
            width: vectorSize,
            height: vectorSize
        )
        alertViewVector.contentMode = .scaleAspectFit
        alertViewVector.isUserInteractionEnabled = false
        alertViewVector.tintColor = colorScheme

        alertView.layer.cornerRadius = cornerRadius
        alertView.layer.masksToBounds = true

        alertViewContents.addSubview(titleLabel)
        alertViewContents.addSubview(descriptionLabel)

        if !hideAllButtons && !hideSeparatorLineView {
            if numberOfButtons == 1, !detachButtons {
                alertViewContents.addSubview(separatorLineView)
            } else if !hideDoneButton, !detachButtons {
                alertViewContents.addSubview(separatorLineView)
            }
        }
        if alertViewWithVector != 0 {
            alertViewContents.layer.addSublayer(circleLayer)
            alertViewContents.addSubview(alertViewVector)

            if alertType == "Progress" {
                alertViewContents.addSubview(spinner)
            }
        }

        if
            !animateAlertInFromTop &&
            !animateAlertInFromLeft &&
            !animateAlertInFromRight &&
            !animateAlertInFromBottom
        {
            alertViewContents.transform = CGAffineTransformMakeScale(1.15, 1.15)
        } else {
            if animateAlertInFromTop {
                alertViewContents.frame = .init(
                    x: alertViewFrame.origin.x,
                    y: -alertViewFrame.size.height - 15.0,
                    width: alertViewFrame.size.width,
                    height: alertViewFrame.size.height
                )
            }
            if animateAlertInFromRight {
                alertViewContents.frame = .init(
                    x: frame.size.width + alertViewFrame.size.width + 15.0,
                    y: alertViewFrame.origin.y,
                    width: alertViewFrame.size.width,
                    height: alertViewFrame.size.height
                )
            }
            if animateAlertInFromBottom {
                alertViewContents.frame = .init(
                    x: alertViewFrame.origin.x,
                    y: frame.size.height + alertViewFrame.size.height + 15.0,
                    width: alertViewFrame.size.width,
                    height: alertViewFrame.size.height
                )
            }
            if animateAlertInFromLeft {
                alertViewContents.frame = .init(
                    x: -alertViewFrame.size.width - 15.0,
                    y: alertViewFrame.origin.y,
                    width: alertViewFrame.size.width,
                    height: alertViewFrame.size.height
                )
            }
        }

        if let ratingTextfield = alertTextFieldHolder.first {
            let minYValue = CGFloat(min<Int>(alertTextFields.count, 4))
            let maxYValue: CGFloat = max<CGFloat>(1, minYValue)
            ratingController = .init(frame: .init(
                x: 20.0,
                y: descriptionLevel + descriptionLabelFrames.size.height + 32.5 + 15.0 + (maxYValue * (ratingTextfield.frame.size.height + 7.5)),
                width: alertViewFrame.size.width - 40.0,
                height: 40.0
            ))
        }
        let spacingBetween = (ratingController.frame.size.width - (40 * 4)) / 5.0
        let starImage = loadImageFromResourceBundle(imageName: "star").withRenderingMode(.alwaysTemplate)
        let heartImage = loadImageFromResourceBundle(imageName: "heart").withRenderingMode(.alwaysTemplate)

        item1 = .init(type: .custom)
        item1.tintColor = .init(white: 228.0 / 255.0, alpha: 1.0)
        item1.frame = .init(
            x: 40.0 * 0.0 + spacingBetween,
            y: 0,
            width: 40.0,
            height: 40.0
        )
        item1.isUserInteractionEnabled = false

        item2 = .init(type: .custom)
        item2.tintColor = .init(white: 228.0 / 255.0, alpha: 1.0)
        item2.frame = .init(
            x: 40.0 * 1.0 + spacingBetween,
            y: 0,
            width: 40.0,
            height: 40.0
        )
        item2.isUserInteractionEnabled = false

        item3 = .init(type: .custom)
        item3.tintColor = .init(white: 228.0 / 255.0, alpha: 1.0)
        item3.frame = .init(
            x: 40.0 * 2.0 + spacingBetween,
            y: 0,
            width: 40.0,
            height: 40.0
        )
        item3.isUserInteractionEnabled = false

        item4 = .init(type: .custom)
        item4.tintColor = .init(white: 228.0 / 255.0, alpha: 1.0)
        item4.frame = .init(
            x: 40.0 * 3.0 + spacingBetween,
            y: 0,
            width: 40.0,
            height: 40.0
        )
        item4.isUserInteractionEnabled = false

        item5 = .init(type: .custom)
        item5.tintColor = .init(white: 228.0 / 255.0, alpha: 1.0)
        item5.frame = .init(
            x: 40.0 * 4.0 + spacingBetween,
            y: 0,
            width: 40.0,
            height: 40.0
        )
        item5.isUserInteractionEnabled = false

        if alertTypeRatingHearts != 0 {
            item1.setImage(heartImage, for: .normal)
            item2.setImage(heartImage, for: .normal)
            item3.setImage(heartImage, for: .normal)
            item4.setImage(heartImage, for: .normal)
            item5.setImage(heartImage, for: .normal)
        }

        if alertTypeRatingStars != 0 {
            item1.setImage(starImage, for: .normal)
            item2.setImage(starImage, for: .normal)
            item3.setImage(starImage, for: .normal)
            item4.setImage(starImage, for: .normal)
            item5.setImage(starImage, for: .normal)
        }

        item1.adjustsImageWhenHighlighted = false
        item2.adjustsImageWhenHighlighted = false
        item3.adjustsImageWhenHighlighted = false
        item4.adjustsImageWhenHighlighted = false
        item5.adjustsImageWhenHighlighted = false

        ratingController.addSubview(item1)
        ratingController.addSubview(item2)
        ratingController.addSubview(item3)
        ratingController.addSubview(item4)
        ratingController.addSubview(item5)

        if alertTypeRatingHearts != 0 || alertTypeRatingStars != 0 {
            alertViewContents.addSubview(ratingController)
        }

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 10.0
        layer.shadowOffset = .init(width: 0, height: 0)

        if bounceAnimations {
            let horizontalMotionEffect = UIInterpolatingMotionEffect(
                keyPath: "center.x",
                type: .tiltAlongHorizontalAxis
            )
            horizontalMotionEffect.minimumRelativeValue = -22.5
            horizontalMotionEffect.maximumRelativeValue = 22.5

            let verticalMotionEffect = UIInterpolatingMotionEffect(
                keyPath: "center.y",
                type: .tiltAlongVerticalAxis
            )
            verticalMotionEffect.minimumRelativeValue = -22.5
            verticalMotionEffect.maximumRelativeValue = 22.5

            alertViewContents.addMotionEffect(horizontalMotionEffect)
            alertViewContents.addMotionEffect(verticalMotionEffect)
        }

        showAlertView()
    }
}

// MARK: UITextFieldDelegate

extension TAlertView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(
        _: UITextField
    ) {
        currentAVCFrames = alertViewContents.frame

        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.alertViewContents.frame = .init(
                    x: self.currentAVCFrames.origin.x,
                    y: self.currentAVCFrames.origin.y - 80.0,
                    width: self.currentAVCFrames.size.width,
                    height: self.currentAVCFrames.size.height
                )
            }
        )
    }

    public func textFieldDidEndEditing(
        _: UITextField
    ) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.alertViewContents.frame = .init(
                    x: self.currentAVCFrames.origin.x,
                    y: self.currentAVCFrames.origin.y,
                    width: self.currentAVCFrames.size.width,
                    height: self.currentAVCFrames.size.height
                )
            }
        )
    }

    public func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        if textField.tag + 1 == alertTextFieldHolder.count {
            textField.endEditing(true)
        } else {
            let newTextField = alertTextFieldHolder[textField.tag + 1]
            newTextField.becomeFirstResponder()
        }
        return true
    }
}

// MARK: - Private Functions

extension TAlertView {
    private func configureAVWidth() -> CGFloat {
        if customSpacing == 0 {
            if UI_USER_INTERFACE_IDIOM() == .pad {
                let result = UIScreen.main.bounds.size

                if result.height == 1366 {
                    return 105.0 + 600.0
                } else {
                    return 105.0 + 350.0
                }
            }
            if UI_USER_INTERFACE_IDIOM() == .phone {
                let result = UIScreen.main.bounds.size

                if result.height == 480 {
                    return 55.0
                }
                if result.height == 568 {
                    return 65.0
                }
                if result.height == 736 {
                    return 130.0
                } else {
                    return 105.0
                }
            }
        }
        return customSpacing
    }

    private func configureAVHeight() -> CGFloat {
        if customHeight == 0 {
            return 200.0
        } else {
            return customHeight
        }
    }

    private func checkCustomizationValid() {
        if darkTheme {
            if titleColor == nil {
                titleColor = .white
            }
            if subTitleColor == nil {
                subTitleColor = .white
            }
        }

        if !hasSubTitle() {
            if !hasTitle() {
                print("[TAlertView Warning]: Your Alert should have a title and/or subtitle.")
            }
        }

        if doneTitle.isEmpty {
            doneTitle = "OK"
        }

        if cornerRadius == 0 {
            cornerRadius = 18.0
        }

        if vectorImage != nil {
            alertViewWithVector = 1
        }
    }

    private func hasSubTitle() -> Bool {
        !subTitle.isEmpty || attributedSubTitle.length > 0
    }

    private func hasTitle() -> Bool {
        !title.isEmpty || attributedTitle.length > 0
    }

    private func safetyCloseCheck() {
        if hideDoneButton || hideAllButtons {
            if autoHideSeconds == 0, overrideForcedDismiss {
                dismissOnOutsideTouch = true
                print("[TAlertView]: forced dismiss on outside touch")
            }
        }
    }

    private func rate1Triggered() {
        currentRating = currentRating != 1 ? 1 : 0
        setActiveRating(rating: currentRating)

        if bounceAnimations {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.item1.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.35,
                        delay: 0.0,
                        options: .curveEaseInOut,
                        animations: {
                            self.item1.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    private func setActiveRating(rating: Int) {
        [item1, item2, item3, item4, item5].forEach {
            $0.tintColor = .init(
                white: 228.0 / 255.0,
                alpha: 1.0
            )
        }

        switch rating {
        case 1:
            item1.tintColor = colorScheme
        case 2:
            item1.tintColor = colorScheme
            item2.tintColor = colorScheme
        case 3:
            item1.tintColor = colorScheme
            item2.tintColor = colorScheme
            item3.tintColor = colorScheme
        case 4:
            item1.tintColor = colorScheme
            item2.tintColor = colorScheme
            item3.tintColor = colorScheme
            item4.tintColor = colorScheme
        case 5:
            item1.tintColor = colorScheme
            item2.tintColor = colorScheme
            item3.tintColor = colorScheme
            item4.tintColor = colorScheme
            item5.tintColor = colorScheme
        default:
            break
        }
    }

    private func rate2Triggered() {
        currentRating = 2
        setActiveRating(rating: currentRating)

        if bounceAnimations {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.item2.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.35,
                        delay: 0.0,
                        options: .curveEaseInOut,
                        animations: {
                            self.item2.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    private func rate3Triggered() {
        currentRating = 3
        setActiveRating(rating: currentRating)

        if bounceAnimations {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.item3.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.35,
                        delay: 0.0,
                        options: .curveEaseInOut,
                        animations: {
                            self.item3.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    private func rate4Triggered() {
        currentRating = 4
        setActiveRating(rating: currentRating)

        if bounceAnimations {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.item4.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.35,
                        delay: 0.0,
                        options: .curveEaseInOut,
                        animations: {
                            self.item4.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    private func rate5Triggered() {
        currentRating = 5
        setActiveRating(rating: currentRating)

        if bounceAnimations {
            UIView.animate(
                withDuration: 0.2,
                delay: 0.0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.item5.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.35,
                        delay: 0.0,
                        options: .curveEaseInOut,
                        animations: {
                            self.item5.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    private func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = .init(
            x: 0,
            y: 0,
            width: 1,
            height: 1
        )

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }

    @objc
    private func donePressed() {
        for textFieldItem in alertTextFields {
            if let action = textFieldItem.action {
                action(textFieldItem.field.text)
            }
        }

        if let doneBlock = doneBlock {
            doneBlock()
        }

        if let delegate = delegate {
            delegate.tAlertDoneButtonClicked(self)
        }

        if let ratingBlock = ratingBlock {
            ratingBlock(currentRating)
        }

        dismissAlertView()
    }

    @objc
    private func buttonTouched() {
        if bounceAnimations {
            UIView.animate(
                withDuration: 0.15,
                delay: 0.0,
                options: .curveEaseOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.alpha = 1.0
                    self.alertViewContents.transform = CGAffineTransformMakeScale(0.95, 0.95)
                }
            )
        }
    }

    @objc
    private func buttonReleased() {
        if bounceAnimations {
            UIView.animate(
                withDuration: 0.25,
                delay: 0.0,
                options: .curveEaseOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.alertViewContents.transform = CGAffineTransformMakeScale(1.05, 1.05)
                },
                completion: { [weak self] _ in
                    guard let self = self else { return }
                    UIView.animate(
                        withDuration: 0.4,
                        delay: 0.0,
                        options: .curveEaseOut,
                        animations: { [weak self] in
                            guard let self = self else { return }
                            self.alertViewContents.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    )
                }
            )
        }
    }

    @objc
    private func handleButton(sender: UIButton) {
        for textFieldItem in alertTextFields {
            if let action = textFieldItem.action {
                action(textFieldItem.field.text)
            }
        }

        if sender.tag < alertButtons.count {
            let alertBtn = alertButtons[sender.tag]
            if let alertAction = alertBtn.action {
                alertAction(nil)
            }
        }

        if let delegate = delegate {
            delegate.tAlertView(self, clickedButtonIndex: sender.tag, buttonTitle: sender.titleLabel?.text)
        }

        if let ratingBlock = ratingBlock {
            ratingBlock(currentRating)
        }

        dismissAlertView()
    }

    private func loadImageFromResourceBundle(
        imageName: String
    ) -> UIImage {
        let bundle = TAlertView.getResourcesBundle()
        return UIImage(
            named: imageName,
            in: bundle,
            compatibleWith: nil
        )!
    }

    private func showAlertView() {
        if let strongDelegate = delegate {
            strongDelegate.tAlertViewWillAppear(self)
        }

        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.alpha = 1.0
                if self.bounceAnimations {
                    if
                        !self.animateAlertInFromTop,
                        !self.animateAlertInFromLeft,
                        !self.animateAlertInFromRight,
                        !self.animateAlertInFromBottom
                    {
                        self.alertViewContents.transform = CGAffineTransformMakeScale(0.95, 0.95)
                    }
                    if self.animateAlertInFromTop {
                        self.alertViewContents.frame = .init(
                            x: self.alertViewFrame.origin.x,
                            y: self.alertViewFrame.origin.y + 7.5,
                            width: self.alertViewFrame.size.width,
                            height: self.alertViewFrame.size.height
                        )
                    }
                    if self.animateAlertInFromRight {
                        self.alertViewContents.frame = .init(
                            x: self.alertViewFrame.origin.x - 7.5,
                            y: self.alertViewFrame.origin.y,
                            width: self.alertViewFrame.size.width,
                            height: self.alertViewFrame.size.height
                        )
                    }
                    if self.animateAlertInFromBottom {
                        self.alertViewContents.frame = .init(
                            x: self.alertViewFrame.origin.x,
                            y: self.alertViewFrame.origin.y - 7.5,
                            width: self.alertViewFrame.size.width,
                            height: self.alertViewFrame.size.height
                        )
                    }
                    if self.animateAlertInFromLeft {
                        self.alertViewContents.frame = .init(
                            x: self.alertViewFrame.origin.x + 7.5,
                            y: self.alertViewFrame.origin.y,
                            width: self.alertViewFrame.size.width,
                            height: self.alertViewFrame.size.height
                        )
                    }
                } else {
                    self.alertViewContents.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.alertViewContents.frame = .init(
                        x: self.alertViewFrame.origin.x,
                        y: self.alertViewFrame.origin.y,
                        width: self.alertViewFrame.size.width,
                        height: self.alertViewFrame.size.height
                    )
                }
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                if self.bounceAnimations {
                    UIView.animate(
                        withDuration: 0.5,
                        delay: 0.0,
                        options: .curveEaseOut,
                        animations: {
                            if
                                !self.animateAlertInFromTop,
                                !self.animateAlertInFromLeft,
                                !self.animateAlertInFromRight,
                                !self.animateAlertInFromBottom
                            {
                                self.alertViewContents.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            }
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x,
                                y: self.alertViewFrame.origin.y,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                    )
                }
                if self.autoHideSeconds != 0 {
                    self.perform(#selector(dismissAlertView), with: nil, afterDelay: TimeInterval(self.autoHideSeconds))
                }
            }
        )
        player.play()
    }
}

// MARK: - Public Static Functions

public extension TAlertView {
    static func getResourcesBundle() -> Bundle {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: TAlertView.self)
        #endif
    }
}

// MARK: - Public Functions

public extension TAlertView {
    @objc
    func dismissAlertView() {
        UIView.animate(
            withDuration: 0.175,
            delay: 0.0,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else { return }
                if
                    !self.animateAlertOutToTop,
                    !self.animateAlertOutToLeft,
                    !self.animateAlertOutToRight,
                    !self.animateAlertOutToBottom
                {
                    self.alpha = 0
                    self.backgroundVisualEffectView.alpha = 0
                    self.alertViewContents.transform = CGAffineTransformMakeScale(0.9, 0.9)

                } else {
                    if self.bounceAnimations {
                        if animateAlertOutToTop {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x,
                                y: self.alertViewFrame.origin.y + 7.5,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToRight {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x - 7.5,
                                y: self.alertViewFrame.origin.y,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToBottom {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x,
                                y: self.alertViewFrame.origin.y - 7.5,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToLeft {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x + 7.5,
                                y: self.alertViewFrame.origin.y,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                    } else {
                        self.alpha = 0
                        self.backgroundVisualEffectView.alpha = 0

                        if self.animateAlertOutToTop {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x,
                                y: -self.alertViewFrame.size.height - 15.0,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToRight {
                            self.alertViewContents.frame = .init(
                                x: self.frame.size.width + self.alertViewFrame.size.width + 15.0,
                                y: self.alertViewFrame.origin.y,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToBottom {
                            self.alertViewContents.frame = .init(
                                x: self.alertViewFrame.origin.x,
                                y: self.frame.size.height + self.alertViewFrame.size.height + 15.0,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                        if self.animateAlertOutToLeft {
                            self.alertViewContents.frame = .init(
                                x: -self.alertViewFrame.size.width - 15.0,
                                y: self.alertViewFrame.origin.y,
                                width: self.alertViewFrame.size.width,
                                height: self.alertViewFrame.size.height
                            )
                        }
                    }
                }
            },
            completion: { [weak self] _ in
                guard let self = self else { return }

                if
                    !self.animateAlertOutToTop,
                    !self.animateAlertOutToLeft,
                    !self.animateAlertOutToRight,
                    !self.animateAlertOutToBottom
                {
                    if let strongDelegate = self.delegate {
                        strongDelegate.tAlertViewDismissed(self)
                    }

                    self.backgroundVisualEffectView.removeFromSuperview()
                    self.removeFromSuperview()
                } else {
                    if bounceAnimations {
                        UIView.animate(
                            withDuration: 0.175,
                            delay: 0.0,
                            options: .curveEaseOut,
                            animations: {
                                self.alpha = 0
                                self.backgroundVisualEffectView.alpha = 0

                                if self.animateAlertOutToTop {
                                    self.alertViewContents.frame = .init(
                                        x: self.alertViewFrame.origin.x,
                                        y: -self.alertViewFrame.size.height - 15.0,
                                        width: self.alertViewFrame.size.width,
                                        height: self.alertViewFrame.size.height
                                    )
                                }
                                if self.animateAlertOutToRight {
                                    self.alertViewContents.frame = .init(
                                        x: self.frame.size.width + self.alertViewFrame.size.width + 15.0,
                                        y: self.alertViewFrame.origin.y,
                                        width: self.alertViewFrame.size.width,
                                        height: self.alertViewFrame.size.height
                                    )
                                }
                                if self.animateAlertOutToBottom {
                                    self.alertViewContents.frame = .init(
                                        x: self.alertViewFrame.origin.x,
                                        y: self.frame.size.height + self.alertViewFrame.size.height + 15.0,
                                        width: self.alertViewFrame.size.width,
                                        height: self.alertViewFrame.size.height
                                    )
                                }
                                if self.animateAlertOutToLeft {
                                    self.alertViewContents.frame = .init(
                                        x: -self.alertViewFrame.size.width - 15.0,
                                        y: self.alertViewFrame.origin.y,
                                        width: self.alertViewFrame.size.width,
                                        height: self.alertViewFrame.size.height
                                    )
                                }
                            }, completion: { _ in
                                if let strongDelegate = self.delegate {
                                    strongDelegate.tAlertViewDismissed(self)
                                }

                                self.backgroundVisualEffectView.removeFromSuperview()
                                self.removeFromSuperview()
                            }
                        )
                    } else {
                        if let strongDelegate = self.delegate {
                            strongDelegate.tAlertViewDismissed(self)
                        }

                        self.backgroundVisualEffectView.removeFromSuperview()
                        self.removeFromSuperview()
                    }
                }
            }
        )
    }

    func addButton(
        title: String,
        withActionBlock action: TActionBlock?
    ) {
        if alertButtons.count < 2 {
            if let action = action {
                alertButtons.append(.init(
                    title: title,
                    action: { _ in action() }
                ))
            } else {
                alertButtons.append(.init(
                    title: title,
                    action: nil
                ))
            }
        }

        numberOfButtons = alertButtons.count
    }

    func doneActionBlock(
        action: TActionBlock?
    ) {
        if let action = action {
            doneBlock = action
        }
    }

    func addTextFieldWithPlaceholder(
        placeholder: String,
        andTextReturnBlock textReturn: TTextReturnBlock?
    ) {
        if let textReturn = textReturn {
            alertTextFields.append(.init(
                field: .init(frame: .zero),
                placeholder: placeholder,
                action: { text in
                    textReturn(text ?? "")
                }
            ))
        } else {
            alertTextFields.append(.init(
                field: .init(frame: .zero),
                placeholder: placeholder,
                action: nil
            ))
        }
    }

    func addTextFieldWithCustomTextField(
        field: UITextField,
        andPlaceholder placeholder: String,
        andTextReturnBlock textReturn: TTextReturnBlock?
    ) {
        if let textReturn = textReturn {
            alertTextFields.append(.init(
                field: field,
                placeholder: placeholder,
                action: { text in
                    textReturn(text ?? "")
                }
            ))
        } else {
            alertTextFields.append(.init(
                field: field,
                placeholder: placeholder,
                action: nil
            ))
        }
    }

    func makeAlertTypeWarning() {
        vectorImage = loadImageFromResourceBundle(imageName: "close-round")
        alertViewWithVector = 1
        colorScheme = flatRed
        alertType = "Warning"
    }

    func makeAlertTypeCaution() {
        vectorImage = loadImageFromResourceBundle(imageName: "alert-round")
        alertViewWithVector = 1
        colorScheme = flatOrange
        alertType = "Caution"
    }

    func makeAlertTypeSuccess() {
        vectorImage = loadImageFromResourceBundle(imageName: "checkmark-round")
        alertViewWithVector = 1
        colorScheme = flatGreen
        alertType = "Success"
    }

    func makeAlertTypeProgress() {
        circleLayer.fillColor = colorScheme?.cgColor
        alertViewWithVector = 1
        alertType = "Progress"
    }

    func makeAlertTypeRateHearts(
        ratingBlock: TRatingBlock?
    ) {
        self.ratingBlock = ratingBlock
        vectorImage = loadImageFromResourceBundle(imageName: "heart")
        alertViewWithVector = 1
        alertTypeRatingHearts = 1
        alertTypeRatingStars = 0
        colorScheme = .init(
            red: 228.0 / 255.0,
            green: 77.0 / 255.0,
            blue: 65.0 / 255.0,
            alpha: 1.0
        )
    }

    func makeAlertTypeRateStars(
        ratingBlock: TRatingBlock?
    ) {
        self.ratingBlock = ratingBlock
        vectorImage = loadImageFromResourceBundle(imageName: "star")
        alertViewWithVector = 1
        alertTypeRatingHearts = 1
        alertTypeRatingStars = 0
        colorScheme = .init(
            red: 234.0 / 255.0,
            green: 201.0 / 255.0,
            blue: 77.0 / 255.0,
            alpha: 1.0
        )
    }

    func showAlertInView(
        view: UIViewController,
        withTitle title: String,
        withSubtitle subTitle: String,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = view.view.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            view.view.addSubview(backgroundVisualEffectView)
        }

        setAlertViewAttributes(
            title: title,
            withSubtitle: subTitle,
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        view.view.addSubview(self)
    }

    func setAlertViewAttributes(
        title: String,
        withSubtitle subTitle: String,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        self.title = title
        self.subTitle = subTitle

        for buttonItem in buttons {
            alertButtons.append(.init(
                title: buttonItem,
                action: nil
            ))
        }
        numberOfButtons = alertButtons.count
        doneTitle = done

        if alertViewWithVector == 0 {
            vectorImage = image
        }

        checkCustomizationValid()
        safetyCloseCheck()
    }

    func showAlertInWindow(
        window: UIWindow,
        withTitle title: String,
        withSubtitle subTitle: String,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = window.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            window.addSubview(backgroundVisualEffectView)
        }

        setAlertViewAttributes(
            title: title,
            withSubtitle: subTitle,
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        window.addSubview(self)
    }

    func showAlertWithTitle(
        title: String,
        withSubtitle subTitle: String,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        setAlertViewAttributes(
            title: title,
            withSubtitle: subTitle,
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        guard let window = UIApplication.shared.keyWindow else { return }

        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = window.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            window.addSubview(backgroundVisualEffectView)
        }

        window.addSubview(self)
        window.bringSubviewToFront(self)
    }

    func showAlertWithAttributedTitle(
        title: NSAttributedString,
        withSubtitle subTitle: String,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        attributedTitle = title

        setAlertViewAttributes(
            title: "",
            withSubtitle: subTitle,
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        guard let window = UIApplication.shared.keyWindow else { return }

        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = window.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            window.addSubview(backgroundVisualEffectView)
        }

        window.addSubview(self)
        window.bringSubviewToFront(self)
    }

    func showAlertWithTitle(
        title: String,
        withAttributedSubtitle subTitle: NSAttributedString,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        attributedSubTitle = subTitle

        setAlertViewAttributes(
            title: title,
            withSubtitle: "",
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        guard let window = UIApplication.shared.keyWindow else { return }

        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = window.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            window.addSubview(backgroundVisualEffectView)
        }

        window.addSubview(self)
        window.bringSubviewToFront(self)
    }

    func showAlertWithAttributedTitle(
        title: NSAttributedString,
        withAttributedSubtitle subTitle: NSAttributedString,
        withCustomImage image: UIImage?,
        withDoneButtonTitle done: String,
        andButtons buttons: [String]
    ) {
        attributedTitle = title
        attributedSubTitle = subTitle

        setAlertViewAttributes(
            title: "",
            withSubtitle: "",
            withCustomImage: image,
            withDoneButtonTitle: done,
            andButtons: buttons
        )

        guard let window = UIApplication.shared.keyWindow else { return }

        if blurBackground {
            let blurEffect = UIBlurEffect(style: .light)
            backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
            backgroundVisualEffectView.frame = window.bounds
            alertBackground.backgroundColor = .init(white: 0.0, alpha: 0.5)
            window.addSubview(backgroundVisualEffectView)
        }

        window.addSubview(self)
        window.bringSubviewToFront(self)
    }
}
