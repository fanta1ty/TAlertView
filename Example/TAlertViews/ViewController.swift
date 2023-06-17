import UIKit
import TAlertViews

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = TAlertView()
        alert.makeAlertTypeSuccess()
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

