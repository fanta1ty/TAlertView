import TAlertView
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = TAlertView()
        alert.makeAlertTypeCaution()
        alert.showAlertInView(
            view: self,
            withTitle: "Alert Title",
            withSubtitle: "This is your alert's subtitle",
            withCustomImage: nil,
            withDoneButtonTitle: "",
            andButtons: []
        )
    }
}
