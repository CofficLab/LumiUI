import SwiftUI

// MARK: - 阴影系统
extension DesignTokens {
    /// 阴影令牌 - 定义界面元素的深度感和发光效果
    public enum Shadow {
        /// 微妙阴影 - 用于卡片
        public static let subtle = SwiftUI.Color.black.opacity(0.15)
        public static let subtleRadius: CGFloat = 12
        public static let subtleOffset: CGFloat = 4

        /// 发光阴影 - 用于强调元素
        /// - Parameters:
        ///   - color: 光晕颜色
        ///   - radius: 光晕半径
        /// - Returns: 带透明度的颜色
        public static func glow(color: SwiftUI.Color, radius: CGFloat = 8) -> SwiftUI.Color {
            color.opacity(0.4)
        }

        /// 深度阴影 - 用于浮动元素
        public static let deep = SwiftUI.Color.black.opacity(0.25)
        public static let deepRadius: CGFloat = 20
        public static let deepOffset: CGFloat = 8

        // MARK: - 输入框内阴影

        /// 输入框内阴影起始颜色（顶部最深）—— 等价于 tailwind 的 `shadow-inner`。
        ///
        /// 用计算属性而非 `static let`：`Color.adaptive` 在初始化时即解析明暗，
        /// 缓存成常量后主题切换不会跟随。亮色表面与黑色的对比本来就强，用更低的不透明度
        /// 才不会糊成一条硬边框；暗色表面则需要更深的阴影才读得出凹陷。
        ///
        /// 注意 `Color(hex:)` 的 8 位格式是 **ARGB**，透明度在高位。
        public static var innerFieldColor: SwiftUI.Color {
            SwiftUI.Color.adaptive(light: "1A000000", dark: "73000000")
        }

        /// 内阴影渐变中段位置：之后迅速淡出，把凹陷感集中在顶部
        public static let innerFieldMidStop: CGFloat = 0.35
        /// 内阴影渐变中段的剩余不透明度比例
        public static let innerFieldMidOpacity: Double = 0.35

        /// 输入框内阴影描边宽度：决定凹陷感向内渗透的深度
        public static let innerFieldLineWidth: CGFloat = 4
        /// 输入框内阴影模糊半径：让描边过渡成柔和的渐变
        public static let innerFieldBlur: CGFloat = 3
    }
}

// MARK: - 凹陷输入表面

public extension View {
    /// 把当前形状叠成「凹陷」的输入表面，用于输入框与搜索框。
    ///
    /// 在内容之上叠加一条自上而下衰减的深色描边，模拟光照从上方打来的内阴影，
    /// 即 tailwind `shadow-inner` 的效果。
    ///
    /// 不用 `ShapeStyle.shadow(.inner(_:))` 的原因：
    /// - 它要求底层填充接近不透明，`Color.clear` 上完全不渲染，无法做成独立图层；
    /// - 直接链式加到 `Material` 上（如 `.fill(Material.glass.shadow(...))`）会让材质
    ///   退化成不透明白色。
    ///
    /// ```swift
    /// RoundedRectangle(cornerRadius: 8, style: .continuous)
    ///     .fill(DesignTokens.Material.glass.opacity(0.1))
    ///     .appInputSurface(cornerRadius: 8)
    /// ```
    ///
    /// - Parameter cornerRadius: 与底层形状一致的圆角，确保内阴影贴合边缘。
    func appInputSurface(cornerRadius: CGFloat) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        let shadowColor = DesignTokens.Shadow.innerFieldColor

        return overlay(
            shape
                .strokeBorder(
                    LinearGradient(
                        stops: [
                            .init(color: shadowColor, location: 0),
                            .init(
                                color: shadowColor.opacity(DesignTokens.Shadow.innerFieldMidOpacity),
                                location: DesignTokens.Shadow.innerFieldMidStop
                            ),
                            .init(color: shadowColor.opacity(0), location: 1),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: DesignTokens.Shadow.innerFieldLineWidth
                )
                .blur(radius: DesignTokens.Shadow.innerFieldBlur)
                .clipShape(shape)
                .allowsHitTesting(false)
        )
    }
}
