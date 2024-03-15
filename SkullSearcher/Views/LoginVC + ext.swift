import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let textCount = textField.text?.count ?? 0
        if range.length == 0 {
            textField.rightViewMode = .whileEditing
        } else if range.length != 0 && textCount == range.length {
            textField.rightViewMode = .never
        }
        
        return true
    }
}
