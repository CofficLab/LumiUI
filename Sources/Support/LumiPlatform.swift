import SwiftUI

// MARK: - 跨平台图像 / 剪贴板适配
//
// 把 AppKit(`NSImage`/`NSPasteboard`) 与 UIKit(`UIImage`/`UIPasteboard`) 的差异
// 收口到本文件，LumiUI 其余源码只依赖这里的平台无关 API，从而可以同时编译到
// macOS 与 iOS。

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
/// 跨平台图像类型：macOS 用 `NSImage`。
public typealias LumiPlatformImage = NSImage

public extension Image {
    /// 从跨平台图像构造 SwiftUI `Image`。
    init(lumiImage image: LumiPlatformImage) {
        self.init(nsImage: image)
    }
}
#elseif canImport(UIKit)
/// 跨平台图像类型：iOS 用 `UIImage`。
public typealias LumiPlatformImage = UIImage

public extension Image {
    /// 从跨平台图像构造 SwiftUI `Image`。
    init(lumiImage image: LumiPlatformImage) {
        self.init(uiImage: image)
    }
}
#endif

/// 跨平台剪贴板写入。
public enum LumiPasteboard {
    /// 将字符串复制到系统剪贴板。
    public static func copyString(_ string: String) {
        #if canImport(AppKit)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        #elseif canImport(UIKit)
        UIPasteboard.general.string = string
        #endif
    }
}

// MARK: - 跨平台语义色

public extension Color {
    /// 跨平台"控件背景"语义色（macOS=`.controlBackgroundColor`，iOS=`.secondarySystemBackground`）。
    static var lumiControlBackground: Color {
        #if canImport(AppKit)
        return Color(nsColor: .controlBackgroundColor)
        #elseif canImport(UIKit)
        return Color(uiColor: .secondarySystemBackground)
        #endif
    }

    /// 跨平台"文本背景"语义色（macOS=`.textBackgroundColor`，iOS=`.systemBackground`）。
    static var lumiTextBackground: Color {
        #if canImport(AppKit)
        return Color(nsColor: .textBackgroundColor)
        #elseif canImport(UIKit)
        return Color(uiColor: .systemBackground)
        #endif
    }
}

// MARK: - iOS 分组列表语义色
//
// iOS 的「分组列表」（Settings.app 风格）有一套独立于 macOS 的语义色：
// 页面底色用 `systemGroupedBackground`，分组卡片用 `secondarySystemGroupedBackground`，
// 文字用 `label` / `secondaryLabel`，分隔线用 `separator`。
// 这里收口为跨平台命名：iOS 取系统语义色，macOS 退回到等价的近似色，
// 使同一套设置组件在两端都能编译，并保持一致的层级关系。

public extension Color {
    /// 分组列表页面底色（iOS=`systemGroupedBackground`）。
    static var lumiGroupedBackground: Color {
        #if canImport(UIKit)
        return Color(uiColor: .systemGroupedBackground)
        #else
        return Color.lumiControlBackground
        #endif
    }

    /// 分组卡片底色（iOS=`secondarySystemGroupedBackground`）。
    static var lumiGroupedCardBackground: Color {
        #if canImport(UIKit)
        return Color(uiColor: .secondarySystemGroupedBackground)
        #else
        return Color.lumiTextBackground
        #endif
    }

    /// 主文字色（iOS=`label`）。
    static var lumiPrimaryLabel: Color {
        #if canImport(UIKit)
        return Color(uiColor: .label)
        #else
        return Color.primary
        #endif
    }

    /// 次要文字色（iOS=`secondaryLabel`）。
    static var lumiSecondaryLabel: Color {
        #if canImport(UIKit)
        return Color(uiColor: .secondaryLabel)
        #else
        return Color.secondary
        #endif
    }

    /// 三级文字色（iOS=`tertiaryLabel`），用于箭头等弱化元素。
    static var lumiTertiaryLabel: Color {
        #if canImport(UIKit)
        return Color(uiColor: .tertiaryLabel)
        #else
        return Color.secondary.opacity(0.6)
        #endif
    }

    /// 分隔线色（iOS=`separator`）。
    static var lumiSeparator: Color {
        #if canImport(UIKit)
        return Color(uiColor: .separator)
        #else
        return Color.primary.opacity(0.12)
        #endif
    }

    /// 三级填充色（iOS=`tertiarySystemFill`），用于搜索框等控件底色。
    static var lumiTertiaryFill: Color {
        #if canImport(UIKit)
        return Color(uiColor: .tertiarySystemFill)
        #else
        return Color.primary.opacity(0.06)
        #endif
    }
}

public extension LumiPlatformImage {
    /// 从文件 URL 加载图像（macOS=`NSImage(contentsOf:)`，iOS=`UIImage(contentsOfFile:)`）。
    convenience init?(lumiContentsOf url: URL) {
        #if canImport(AppKit)
        self.init(contentsOf: url)
        #elseif canImport(UIKit)
        self.init(contentsOfFile: url.path)
        #endif
    }
}
