import Foundation
import UIKit

public class TAlertTextField {
    let field: UITextField
    let placeholder: String?
    let action: ((String?) -> Void)?
    
    init(
        field: UITextField,
        placeholder: String?,
        action: ((String?) -> Void)?
    ) {
        self.field = field
        self.placeholder = placeholder
        self.action = action
    }
}
