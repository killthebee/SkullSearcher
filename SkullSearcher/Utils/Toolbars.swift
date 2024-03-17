import UIKit

func makeToolbar(barItems: [UIBarButtonItem]) -> UIToolbar {
    let toolbar = UIToolbar()
    toolbar.setItems(barItems, animated: true)
    toolbar.sizeToFit()

    return toolbar
}
