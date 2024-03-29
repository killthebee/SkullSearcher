import UIKit

public final class BottomSheetTransitioningDelegate: NSObject {
    
    let transition: BottomSheetTransition
    
    private let configuration: BottomSheetConfiguration
    
    public init(configuration: BottomSheetConfiguration) {
        self.configuration = configuration
        self.transition = BottomSheetTransition(configuration: configuration)
    }
}
    
extension BottomSheetTransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        transition.wantsInteractiveStart = false
        return transition
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    public func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting,
            configuration: configuration
        )
    }
}
