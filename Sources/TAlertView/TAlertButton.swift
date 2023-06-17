import Foundation
import UIKit

public class TAlertButton {
    let title: String
    let action: ((String?) -> Void)?
    
    init(
        title: String,
        action: ((String?) -> Void)?
    ) {
        self.title = title
        self.action = action
    }
}
