import Foundation

public protocol TAlertViewDelegate: AnyObject {
    func tAlertView(
        _ alertView: TAlertView,
        clickedButtonIndex index: Int,
        buttonTitle title: String?
    )

    func tAlertViewDismissed(
        _ alertView: TAlertView
    )

    func tAlertViewWillAppear(
        _ alertView: TAlertView
    )

    func tAlertDoneButtonClicked(
        _ alertView: TAlertView
    )
}

extension TAlertViewDelegate {
    func tAlertView(
        _: TAlertView,
        clickedButtonIndex _: Int,
        buttonTitle _: String?
    ) {}

    func tAlertViewDismissed(
        _: TAlertView
    ) {}

    func tAlertViewWillAppear(
        _: TAlertView
    ) {}

    func tAlertDoneButtonClicked(
        _: TAlertView
    ) {}
}
