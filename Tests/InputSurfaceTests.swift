import AppKit
import SwiftUI
import Testing
@testable import LumiUI

struct InputSurfaceTests {
    @Test
    func innerFieldGeometryStaysPositiveAndSubtle() {
        #expect(DesignTokens.Shadow.innerFieldLineWidth == 4)
        #expect(DesignTokens.Shadow.innerFieldBlur == 3)

        // 中段停靠点必须落在渐变内部，否则阴影会退化成硬边或直接消失。
        #expect(DesignTokens.Shadow.innerFieldMidStop > 0)
        #expect(DesignTokens.Shadow.innerFieldMidStop < 1)
        #expect(DesignTokens.Shadow.innerFieldMidOpacity > 0)
        #expect(DesignTokens.Shadow.innerFieldMidOpacity < 1)

        // 凹陷感向内渗透的深度不该超过输入框自身的视觉厚度。
        #expect(DesignTokens.Shadow.innerFieldLineWidth <= 8)
        #expect(DesignTokens.Shadow.innerFieldBlur <= DesignTokens.Shadow.innerFieldLineWidth)
    }

    @Test
    @MainActor
    func innerFieldResolvesPerAppearance() {
        let previousTheme = ActiveChromeTheme.current
        let previousScheme = ResolvedSystemColorScheme.current
        ActiveChromeTheme.current = LumiFallbackChromeTheme()
        defer {
            ActiveChromeTheme.current = previousTheme
            ResolvedSystemColorScheme.current = previousScheme
        }

        func alpha(for scheme: ColorScheme) -> CGFloat {
            ResolvedSystemColorScheme.current = scheme
            return NSColor(DesignTokens.Shadow.innerFieldColor).usingColorSpace(.sRGB)?.alphaComponent ?? 0
        }

        let lightAlpha = alpha(for: .light)
        let darkAlpha = alpha(for: .dark)

        // 完全透明等于没有阴影；完全不透明会盖住输入内容。
        #expect(lightAlpha > 0.05)
        #expect(darkAlpha > 0.05)
        #expect(lightAlpha < 0.9)
        #expect(darkAlpha < 0.9)

        // 暗色表面与黑色的对比更弱，需要更深的内阴影才读得出凹陷。
        #expect(darkAlpha > lightAlpha)

        // 令牌必须是计算属性：`Color.adaptive` 在初始化时即解析明暗，
        // 缓存成常量后主题切换不会跟随。
        #expect(alpha(for: .dark) == darkAlpha)
        #expect(alpha(for: .light) == lightAlpha)
    }
}
