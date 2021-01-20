// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Расклад помогает понять причины и найти решения не очень сложных и не запущенных проблем.
  internal static let briefForecast = L10n.tr("Localizable", "briefForecast")
  /// Известность и популярность данного гадания объясняется широтой толкования, с его помощью можно как просто заглянуть в свое будущее, так и узнать, как действовать и чего ожидать от конкретно возникшей затруднительной ситуации.
  internal static let celticCross = L10n.tr("Localizable", "celticCross")
  /// Чтобы узнать, как сейчас (за или против вас) складывается ситуация, используйте этот популярный расклад. Он поможет скоординировать ваши действия и подскажет оптимальное решение проблемы.
  internal static let cross = L10n.tr("Localizable", "cross")
  /// Данный расклад является расширенной версией расклада «Крест».
  internal static let crossOfTheElements = L10n.tr("Localizable", "crossOfTheElements")
  /// Сочетание двух рун дает характеристику настоящему положению дел и тех сил, которые оказывают влияние на Вас сейчас, в настоящем. И поэтому вопрос должен касаться настоящего или можно обойтись без вопроса. Две руны даже без вопросов, покажут характеристику настоящего момента.
  internal static let layoutOfTwoRunes = L10n.tr("Localizable", "layoutOfTwoRunes")
  /// В германо-скандинавской мифологии три женщины, волшебницы, наделенные чудесным даром определять судьбы мира, людей и даже богов. Данный рунический расклад может применяться в различных ситуациях как для прояснения чего-либо, так и для получения совета или ответа на вопрос.
  internal static let norns = L10n.tr("Localizable", "norns")
  /// Часто для получения ответа на заданный вопрос достаточно взять одну руну, ее значение – это и есть ответ на Ваш вопрос. В этом случае исключена вероятность неправильного толкования, ведь других рун, способных запутать Вопрошающего – нет.
  internal static let runesOfTheDay = L10n.tr("Localizable", "runesOfTheDay")
  /// Данный расклад символизирует Ваше прошлое, настоящее и будущее.
  internal static let thorsHammer = L10n.tr("Localizable", "thorsHammer")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
