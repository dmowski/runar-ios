// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// В настоящее время с Вами происходит:\n\nДостижение цели, удача, что является следствием вашего прошлого %@.\n\nЧтобы достичь в будущем Окончание Черной полосы в жизни, вам необходимо обратить внимание на непреодолимое обстоятельство.\n\nВозможно, причиной ваших трудностей является Эмоциональное переживание.\n\nЛучшее, чего Вы можете ожидать - это Бессилие.\n\nВ результате, вас ждет Неприятное затруднение.
  internal static func textInterpritation(_ p1: Any) -> String {
    return L10n.tr("Localizable", "text_interpritation", String(describing: p1))
  }

  internal enum Rune {
    internal enum Cross {
      /// Чтобы узнать, как сейчас (за или против вас) складывается ситуация, используйте этот популярный расклад. Он поможет скоординировать ваши действия и подскажет оптимальное решение проблемы.
      internal static let description = L10n.tr("Localizable", "rune.cross.description")
      /// Крест
      internal static let name = L10n.tr("Localizable", "rune.cross.name")
    }
    internal enum DayRune {
      /// Часто для получения ответа на заданный вопрос достаточно взять одну руну, ее значение – это и есть ответ на Ваш вопрос. В этом случае исключена вероятность неправильного толкования, ведь других рун, способных запутать Вопрошающего – нет.
      internal static let description = L10n.tr("Localizable", "rune.dayRune.description")
      /// Руна дня
      internal static let name = L10n.tr("Localizable", "rune.dayRune.name")
    }
    internal enum ElementsCross {
      /// Данный расклад является расширенной версией расклада «Крест».
      internal static let description = L10n.tr("Localizable", "rune.elementsCross.description")
      /// Крест стихий
      internal static let name = L10n.tr("Localizable", "rune.elementsCross.name")
    }
    internal enum KeltsCross {
      /// Известность и популярность данного гадания объясняется широтой толкования, с его помощью можно как просто заглянуть в свое будущее, так и узнать, как действовать и чего ожидать от конкретно возникшей затруднительной ситуации.
      internal static let description = L10n.tr("Localizable", "rune.keltsCross.description")
      /// Кельтский крест
      internal static let name = L10n.tr("Localizable", "rune.keltsCross.name")
    }
    internal enum Norns {
      /// В германо-скандинавской мифологии три женщины, волшебницы, наделенные чудесным даром определять судьбы мира, людей и даже богов. Данный рунический расклад может применяться в различных ситуациях как для прояснения чего-либо, так и для получения совета или ответа на вопрос.
      internal static let description = L10n.tr("Localizable", "rune.norns.description")
      /// Норны
      internal static let name = L10n.tr("Localizable", "rune.norns.name")
    }
    internal enum ShortPrediction {
      /// Расклад помогает понять причины и найти решения не очень сложных и не запущенных проблем.
      internal static let description = L10n.tr("Localizable", "rune.shortPrediction.description")
      /// Краткий прогноз
      internal static let name = L10n.tr("Localizable", "rune.shortPrediction.name")
    }
    internal enum ThorsHummer {
      /// Данный расклад символизирует Ваше прошлое, настоящее и будущее.
      internal static let description = L10n.tr("Localizable", "rune.thorsHummer.description")
      /// Молот тора
      internal static let name = L10n.tr("Localizable", "rune.thorsHummer.name")
    }
    internal enum TwoRunes {
      /// Сочетание двух рун дает характеристику настоящему положению дел и тех сил, которые оказывают влияние на Вас сейчас, в настоящем. И поэтому вопрос должен касаться настоящего или можно обойтись без вопроса. Две руны даже без вопросов, покажут характеристику настоящего момента.
      internal static let description = L10n.tr("Localizable", "rune.twoRunes.description")
      /// Расклад из 2 рун
      internal static let name = L10n.tr("Localizable", "rune.twoRunes.name")
    }
  }
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
