import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        if warningFired {
            viewModel?.hideEmailWarning?()
        }
        let textCount = textField.text?.count ?? 0
        if range.length == 0 {
            textField.rightViewMode = .whileEditing
            activateButton()
        } else if range.length != 0 && textCount == range.length {
            textField.rightViewMode = .never
            deactivateButton()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if warningFired {
            viewModel?.hideEmailWarning?()
        }
        deactivateButton()
        
        return true
    }
}
