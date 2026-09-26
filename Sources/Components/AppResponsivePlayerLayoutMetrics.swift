import CoreGraphics

/// Configurable sizing rules for responsive audio and video player layouts.
///
/// The defaults are a practical starting point for a compact desktop player;
/// applications can supply their own thresholds while sharing the same layout
/// calculations.
public struct AppResponsivePlayerLayoutMetrics: Equatable {
    public let minimumWindowSize: CGSize
    public let controlMinimumHeight: CGFloat
    public let contentMinimumHeight: CGFloat
    public let secondaryColumnMinimumWidth: CGFloat
    public let compactStateHeightThreshold: CGFloat
    public let expandedStateHeightThreshold: CGFloat
    public let compactStateHeight: CGFloat
    public let regularStateHeight: CGFloat
    public let expandedStateHeight: CGFloat

    public init(
        minimumWindowSize: CGSize = CGSize(width: 400, height: 250),
        controlMinimumHeight: CGFloat = 250,
        contentMinimumHeight: CGFloat = 200,
        secondaryColumnMinimumWidth: CGFloat = 768,
        compactStateHeightThreshold: CGFloat = 250,
        expandedStateHeightThreshold: CGFloat = 450,
        compactStateHeight: CGFloat = 24,
        regularStateHeight: CGFloat = 36,
        expandedStateHeight: CGFloat = 48
    ) {
        self.minimumWindowSize = minimumWindowSize
        self.controlMinimumHeight = controlMinimumHeight
        self.contentMinimumHeight = contentMinimumHeight
        self.secondaryColumnMinimumWidth = secondaryColumnMinimumWidth
        self.compactStateHeightThreshold = compactStateHeightThreshold
        self.expandedStateHeightThreshold = expandedStateHeightThreshold
        self.compactStateHeight = compactStateHeight
        self.regularStateHeight = regularStateHeight
        self.expandedStateHeight = expandedStateHeight
    }

    public func stateHeight(for windowHeight: CGFloat) -> CGFloat {
        if windowHeight <= compactStateHeightThreshold { return compactStateHeight }
        if windowHeight <= expandedStateHeightThreshold { return regularStateHeight }
        return expandedStateHeight
    }

    public func controlButtonHeight(width: CGFloat, height: CGFloat, maximum: CGFloat = 900) -> CGFloat {
        max(0, min(width / 5, maximum, height / 4))
    }

    public func shouldShowSecondaryColumn(width: CGFloat) -> Bool {
        width > secondaryColumnMinimumWidth
    }

    public func needsExpandedWindow(for windowHeight: CGFloat) -> Bool {
        windowHeight - controlMinimumHeight <= contentMinimumHeight
    }
}
