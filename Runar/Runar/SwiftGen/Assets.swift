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
  internal enum Background {
    internal static let main = ImageAsset(name: "Background/main")
  }
  internal enum CellSettings {
    internal enum Colors {
      internal static let backgroundColor = ColorAsset(name: "CellSettings/Colors/BackgroundColor")
      internal static let colorDidLight = ColorAsset(name: "CellSettings/Colors/ColorDidLight")
      internal static let colorLight = ColorAsset(name: "CellSettings/Colors/ColorLight")
      internal static let backgroundColorHighlite = ColorAsset(name: "CellSettings/Colors/backgroundColorHighlite")
      internal static let borderColor = ColorAsset(name: "CellSettings/Colors/borderColor")
    }
    internal enum Runes {
      internal static let cross = ImageAsset(name: "CellSettings/Runes/cross")
      internal static let dayRune = ImageAsset(name: "CellSettings/Runes/dayRune")
      internal static let elementsCross = ImageAsset(name: "CellSettings/Runes/elementsCross")
      internal static let keltsCross = ImageAsset(name: "CellSettings/Runes/keltsCross")
      internal static let norns = ImageAsset(name: "CellSettings/Runes/norns")
      internal static let shortPrediction = ImageAsset(name: "CellSettings/Runes/shortPrediction")
      internal static let thorsHummer = ImageAsset(name: "CellSettings/Runes/thorsHummer")
      internal static let twoRunes = ImageAsset(name: "CellSettings/Runes/twoRunes")
    }
  }
  internal enum Colors {
    internal static let textColor = ColorAsset(name: "Colors/TextColor")
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
  internal static let interpretationBackground = ImageAsset(name: "InterpretationBackground")
  internal enum LayoutsRunes {
    internal static let algiz = ImageAsset(name: "LayoutsRunes/Algiz")
    internal static let ansuz = ImageAsset(name: "LayoutsRunes/Ansuz")
    internal static let berkana = ImageAsset(name: "LayoutsRunes/Berkana")
    internal static let dagaz = ImageAsset(name: "LayoutsRunes/Dagaz")
    internal static let ehvaz = ImageAsset(name: "LayoutsRunes/Ehvaz")
    internal static let fehu = ImageAsset(name: "LayoutsRunes/Fehu")
    internal static let gebu = ImageAsset(name: "LayoutsRunes/Gebu")
    internal static let hagalaz = ImageAsset(name: "LayoutsRunes/Hagalaz")
    internal static let inwaz = ImageAsset(name: "LayoutsRunes/Inwaz")
    internal static let isaz = ImageAsset(name: "LayoutsRunes/Isaz")
    internal static let iwaz = ImageAsset(name: "LayoutsRunes/Iwaz")
    internal static let jara = ImageAsset(name: "LayoutsRunes/Jara")
    internal static let kauna = ImageAsset(name: "LayoutsRunes/Kauna")
    internal static let laguz = ImageAsset(name: "LayoutsRunes/Laguz")
    internal static let mannaz = ImageAsset(name: "LayoutsRunes/Mannaz")
    internal static let naudiz = ImageAsset(name: "LayoutsRunes/Naudiz")
    internal static let odinRune = ImageAsset(name: "LayoutsRunes/OdinRune")
    internal static let opila = ImageAsset(name: "LayoutsRunes/Opila")
    internal static let perpu = ImageAsset(name: "LayoutsRunes/Perpu")
    internal static let purisaz = ImageAsset(name: "LayoutsRunes/Purisaz")
    internal static let raidu = ImageAsset(name: "LayoutsRunes/Raidu")
    internal enum Reverse {
      internal static let reverseAlgiz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseAlgiz")
      internal static let reverseAnsuz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseAnsuz")
      internal static let reverseBerkana = ImageAsset(name: "LayoutsRunes/Reverse/ReverseBerkana")
      internal static let reverseEhvaz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseEhvaz")
      internal static let reverseFehu = ImageAsset(name: "LayoutsRunes/Reverse/ReverseFehu")
      internal static let reverseKauna = ImageAsset(name: "LayoutsRunes/Reverse/ReverseKauna")
      internal static let reverseLaguz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseLaguz")
      internal static let reverseMannaz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseMannaz")
      internal static let reverseNaudiz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseNaudiz")
      internal static let reverseOpila = ImageAsset(name: "LayoutsRunes/Reverse/ReverseOpila")
      internal static let reversePerpu = ImageAsset(name: "LayoutsRunes/Reverse/ReversePerpu")
      internal static let reversePurisaz = ImageAsset(name: "LayoutsRunes/Reverse/ReversePurisaz")
      internal static let reverseRaidu = ImageAsset(name: "LayoutsRunes/Reverse/ReverseRaidu")
      internal static let reverseTiwaz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseTiwaz")
      internal static let reverseUruz = ImageAsset(name: "LayoutsRunes/Reverse/ReverseUruz")
      internal static let reverseWunji = ImageAsset(name: "LayoutsRunes/Reverse/ReverseWunji")
    }
    internal static let sowilu = ImageAsset(name: "LayoutsRunes/Sowilu")
    internal static let tiwaz = ImageAsset(name: "LayoutsRunes/Tiwaz")
    internal static let uruz = ImageAsset(name: "LayoutsRunes/Uruz")
    internal static let wunji = ImageAsset(name: "LayoutsRunes/Wunji")
  }
  internal enum TabBar {
    internal enum Image {
      internal static let favorites = ImageAsset(name: "TabBar/Image/Favorites")
      internal static let home = ImageAsset(name: "TabBar/Image/Home")
      internal static let library = ImageAsset(name: "TabBar/Image/Library")
      internal static let settings = ImageAsset(name: "TabBar/Image/Settings")
    }
    internal static let pushColor = ColorAsset(name: "TabBar/pushColor")
  }
  internal static let ads = ImageAsset(name: "ads")
  internal static let backgroundDown = ImageAsset(name: "backgroundDown")
  internal static let bottomBlackGradient = ImageAsset(name: "bottomBlackGradient")
  internal static let darkRune = ImageAsset(name: "darkRune")
  internal static let escape = ImageAsset(name: "escape")
  internal static let floatingDown = ImageAsset(name: "floatingDown")
  internal static let floatingUp = ImageAsset(name: "floatingUp")
  internal static let learnAboutTheAlignment = ImageAsset(name: "learnAboutTheAlignment")
  internal static let mainFire = ImageAsset(name: "main_fire")
  internal static let nameLabelGradient = ImageAsset(name: "nameLabelGradient")
  internal static let person2 = ImageAsset(name: "person 2")
  internal static let popUpVectorLeft = ImageAsset(name: "popUpVectorLeft")
  internal static let popUpVectorRight = ImageAsset(name: "popUpVectorRight")
  internal static let selected = ImageAsset(name: "selected")
  internal static let topBlackGradient = ImageAsset(name: "topBlackGradient")
  internal static let unselected = ImageAsset(name: "unselected")
  internal static let vector = ImageAsset(name: "vector")
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
