import UIKit

public struct BottomSheetConfiguration {
    
    public let showPullBar: Bool
    public let tapToDismissEnabled: Bool
    public let panToDismissEnaled: Bool
    public let cornerRadius: CGFloat
    public let overlayColor: UIColor
    
    public let animationDuration: TimeInterval
    
    public let dampingRatio: Double
    
    public let dismissThreshold: CGFloat
    
    public init(showPullBar: Bool,
                tapToDismissEnabled: Bool,
                panToDismissEnaled: Bool,
                cornerRadius: CGFloat,
                overlayColor: UIColor,
                animationDuration: TimeInterval,
                dampingRatio: Double,
                dismissThreshold: CGFloat) {
        self.showPullBar = showPullBar
        self.tapToDismissEnabled = tapToDismissEnabled
        self.panToDismissEnaled = panToDismissEnaled
        self.cornerRadius = cornerRadius
        self.overlayColor = overlayColor
        self.animationDuration = animationDuration
        self.dampingRatio = dampingRatio
        self.dismissThreshold = dismissThreshold
    }
    
    // MARK: Configurations
    
    public static let `default` = BottomSheetConfiguration(
        showPullBar: true,
        tapToDismissEnabled: true,
        panToDismissEnaled: true,
        cornerRadius: 16,
        overlayColor: .black.withAlphaComponent(0.3),
        animationDuration: 0.5,
        dampingRatio: 0.9,
        dismissThreshold: 0.3
    )
}
