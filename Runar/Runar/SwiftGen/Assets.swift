// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Colors {
    internal static let color2 = ColorAsset(name: "Colors/Color-2")
    internal enum Touch {
      internal static let layerBackground = ColorAsset(name: "Colors/Touch/layerBackground")
      internal static let layerBorder = ColorAsset(name: "Colors/Touch/layerBorder")
      internal static let text = ColorAsset(name: "Colors/Touch/text")
    }
    internal enum UnTouch {
      internal static let layerBackground = ColorAsset(name: "Colors/UnTouch/layerBackground")
      internal static let layerBorder = ColorAsset(name: "Colors/UnTouch/layerBorder")
      internal static let text = ColorAsset(name: "Colors/UnTouch/text")
    }
  }
  internal enum LayoutsRunes {
    internal static let альгизОбратная = ImageAsset(name: "Layouts Runes/альгиз обратная")
    internal static let альгиз = ImageAsset(name: "Layouts Runes/альгиз")
    internal static let ансузОбратная = ImageAsset(name: "Layouts Runes/ансуз обратная")
    internal static let ансуз = ImageAsset(name: "Layouts Runes/ансуз")
    internal static let берканаОбратная = ImageAsset(name: "Layouts Runes/беркана обратная")
    internal static let беркана = ImageAsset(name: "Layouts Runes/беркана")
    internal static let вуньоОбратная = ImageAsset(name: "Layouts Runes/вуньо обратная")
    internal static let вуньо = ImageAsset(name: "Layouts Runes/вуньо")
    internal static let гебо = ImageAsset(name: "Layouts Runes/гебо")
    internal static let дагаз = ImageAsset(name: "Layouts Runes/дагаз")
    internal static let ингуз = ImageAsset(name: "Layouts Runes/ингуз")
    internal static let иса = ImageAsset(name: "Layouts Runes/иса")
    internal static let йера = ImageAsset(name: "Layouts Runes/йера")
    internal static let кеназОбратная = ImageAsset(name: "Layouts Runes/кеназ обратная")
    internal static let кеназ = ImageAsset(name: "Layouts Runes/кеназ")
    internal static let лагузОбратная = ImageAsset(name: "Layouts Runes/лагуз обратная")
    internal static let лагуз = ImageAsset(name: "Layouts Runes/лагуз")
    internal static let манназОбратная = ImageAsset(name: "Layouts Runes/манназ обратная")
    internal static let манназ = ImageAsset(name: "Layouts Runes/манназ")
    internal static let наутизОбратная = ImageAsset(name: "Layouts Runes/наутиз обратная")
    internal static let наутиз = ImageAsset(name: "Layouts Runes/наутиз")
    internal static let отиллаОбратная = ImageAsset(name: "Layouts Runes/отилла обратная")
    internal static let отилла = ImageAsset(name: "Layouts Runes/отилла")
    internal static let пертОбратная = ImageAsset(name: "Layouts Runes/перт обратная")
    internal static let перт = ImageAsset(name: "Layouts Runes/перт")
    internal static let райдоОбратная = ImageAsset(name: "Layouts Runes/райдо обратная")
    internal static let райдо = ImageAsset(name: "Layouts Runes/райдо")
    internal static let рунаОдина = ImageAsset(name: "Layouts Runes/руна одина")
    internal static let совило = ImageAsset(name: "Layouts Runes/совило")
    internal static let тейвазОбратная = ImageAsset(name: "Layouts Runes/тейваз обратная")
    internal static let тейваз = ImageAsset(name: "Layouts Runes/тейваз")
    internal static let турисазОбратная = ImageAsset(name: "Layouts Runes/турисаз обратная")
    internal static let турисаз = ImageAsset(name: "Layouts Runes/турисаз")
    internal static let урузОбратная = ImageAsset(name: "Layouts Runes/уруз обратная")
    internal static let уруз = ImageAsset(name: "Layouts Runes/уруз")
    internal static let фехуОбратная = ImageAsset(name: "Layouts Runes/феху обратная")
    internal static let феху = ImageAsset(name: "Layouts Runes/феху")
    internal static let хагалаз = ImageAsset(name: "Layouts Runes/хагалаз")
    internal static let эвазОбратная = ImageAsset(name: "Layouts Runes/эваз обратная")
    internal static let эваз = ImageAsset(name: "Layouts Runes/эваз")
    internal static let эйваз = ImageAsset(name: "Layouts Runes/эйваз")
  }
  internal static let cross = ImageAsset(name: "cross")
  internal static let dayRune = ImageAsset(name: "dayRune")
  internal static let elementsCross = ImageAsset(name: "elementsCross")
  internal static let keltsCross = ImageAsset(name: "keltsCross")
  internal static let norns = ImageAsset(name: "norns")
  internal static let shortPrediction = ImageAsset(name: "shortPrediction")
  internal static let thorsHummer = ImageAsset(name: "thorsHummer")
  internal static let twoRunes = ImageAsset(name: "twoRunes")
  internal static let backgroundDown = ImageAsset(name: "backgroundDown")
  internal static let bookmark = ImageAsset(name: "bookmark")
  internal static let circle = ImageAsset(name: "circle")
  internal static let escape = ImageAsset(name: "escape")
  internal static let favourite = ImageAsset(name: "favourite")
  internal static let floatingDown = ImageAsset(name: "floatingDown")
  internal static let floatingUp = ImageAsset(name: "floatingUp")
  internal static let home = ImageAsset(name: "home")
  internal static let main = ImageAsset(name: "main")
  internal static let mainFire = ImageAsset(name: "main_fire")
  internal static let person2 = ImageAsset(name: "person 2")
  internal static let selected = ImageAsset(name: "selected")
  internal static let unselected = ImageAsset(name: "unselected")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
