import UIKit

extension ConfirmViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count == 0 {
            textField.attributedPlaceholder = NSAttributedString(
                string: "*",
                attributes: [
                    NSAttributedString.Key.foregroundColor: grey3!,
                    NSAttributedString.Key.font: starsFont!
                ]
            )
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        if newString.count > maxLength {
            textField.text = ""
        }
        if range.length == 0 {
            viewModel?.savePinInput(textField.tag, num: string)
        } else {
            viewModel?.savePinInput(textField.tag, num: string, add: false)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
