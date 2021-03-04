import UIKit

public enum RuneType: Equatable {
    public typealias AllCases = Array<RuneType>

    public enum RuneSubType {
        case random
        case original
        case reversed
    }
    
    public static func allCases(subtype: RuneSubType = .original) -> [Self] {
       
        [ RuneType.fehu(isReversed: false), .urus(isReversed: false), .purisaz(isReversed: false),
          .ansuz(isReversed: false), .raidu(isReversed: false), .kauna(isReversed: false),
          .gebu, .wunji(isReversed: false), .hagalaz, .naudiz(isReversed: false),
          .isaz, .jara, .iwas,
          .perpu(isReversed: false), .algis(isReversed: false), .sowilu,
          .tiwaz(isReversed: false), .berkana(isReversed: false), .ehwaz(isReversed: false),
          .mannaz(isReversed: false), .lagus(isReversed: false), .inwaz,
          .dagaz, .opila(isReversed: false), .odin
            
        ].map { $0.withSubtype(subtype) }
    }

    public func withSubtype(_ subtype: RuneSubType = .random) -> RuneType {
        let isReversed: Bool

        switch subtype {
        case  .original:
            isReversed = false
        case  .reversed:
            isReversed = true
        case .random:
            isReversed = Bool.random()
        }
    
        switch self {
        case .fehu:
            return  RuneType.fehu(isReversed: isReversed)
        case .urus:
            return  .urus(isReversed: isReversed)
        case .purisaz:
            return  .purisaz(isReversed: isReversed)
        case .ansuz:
            return  .ansuz(isReversed: isReversed)
        case .raidu:
            return  .raidu(isReversed: isReversed)
        case .kauna:
            return  .kauna(isReversed: isReversed)
        case .gebu:
            return  .gebu
        case .wunji:
            return  .wunji(isReversed: isReversed)
        case .hagalaz:
            return  .hagalaz
        case .naudiz:
            return  .naudiz(isReversed: isReversed)
        case .isaz:
            return  .isaz
        case .jara:
            return  .jara
        case .iwas:
            return  .iwas
        case .perpu:
            return  .perpu(isReversed: isReversed)
        case .algis:
            return  .algis(isReversed: isReversed)
        case .sowilu:
            return  .sowilu
        case .tiwaz:
            return  .tiwaz(isReversed: isReversed)
        case .berkana:
            return  .berkana(isReversed: isReversed)
        case .ehwaz:
            return  .ehwaz(isReversed: isReversed)
        case .mannaz:
            return  .mannaz(isReversed: isReversed)
        case .lagus:
            return  .lagus(isReversed: isReversed)
        case .inwaz:
            return  .inwaz
        case .dagaz:
            return  .dagaz
        case .opila:
            return  .opila(isReversed: isReversed)
        case .odin:
            return  .odin
        }
    }

    case fehu(isReversed: Bool)
    case urus(isReversed: Bool)
    case purisaz(isReversed: Bool)
    case ansuz(isReversed: Bool)
    case raidu(isReversed: Bool)
    case kauna(isReversed: Bool)
    case gebu
    case wunji(isReversed: Bool)
    case hagalaz
    case naudiz(isReversed: Bool)
    case isaz
    case jara
    case iwas
    case perpu(isReversed: Bool)
    case algis(isReversed: Bool)
    case sowilu
    case tiwaz(isReversed: Bool)
    case berkana(isReversed: Bool)
    case ehwaz(isReversed: Bool)
    case mannaz(isReversed: Bool)
    case lagus(isReversed: Bool)
    case inwaz
    case dagaz
    case opila(isReversed: Bool)
    case odin
    
    static public func ==(lhs: RuneType, rhs: RuneType) -> Bool {
        switch (lhs, rhs) {
        case (.fehu, .fehu), (.urus, .urus), (.purisaz, .purisaz),
             (.ansuz, .ansuz), (.raidu, .raidu), (.kauna, .kauna),
             (.gebu, .gebu), (.wunji, .wunji), (.hagalaz, .hagalaz),
             (.naudiz, .naudiz), (.isaz, .isaz), (.jara, .jara),
             (.iwas, .iwas), (.perpu, .perpu), (.algis, .algis),
             (.sowilu, .sowilu), (.tiwaz, .tiwaz), (.berkana, .berkana),
             (.ehwaz, .ehwaz), (.mannaz, .mannaz), (.lagus, .lagus),
             (.inwaz, .inwaz), (.dagaz, .dagaz), (.opila, .opila),
             (.odin, .odin):
            return true
        default: return false
        }
    }
}


public extension RuneType {
    
    var image: UIImage {
        
        switch self {
        case let .fehu(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseFehu.image
            } else {
                return Assets.LayoutsRunes.fehu.image
            }
        case let .urus(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseUruz.image
            } else {
                return Assets.LayoutsRunes.uruz.image
            }
        case let .purisaz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reversePurisaz.image
            } else {
                return Assets.LayoutsRunes.purisaz.image
            }
        case let .ansuz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseAnsuz.image
            } else {
                return Assets.LayoutsRunes.ansuz.image
            }
        case let .raidu(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseRaidu.image
            } else {
                return Assets.LayoutsRunes.raidu.image
            }
        case let .kauna(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseKauna.image
            } else {
                return Assets.LayoutsRunes.kauna.image
            }
        case .gebu:
            return Assets.LayoutsRunes.gebu.image
        case let .wunji(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseWunji.image
            } else {
                return Assets.LayoutsRunes.wunji.image
            }
        case .hagalaz:
            return  Assets.LayoutsRunes.hagalaz.image
        case let .naudiz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseNaudiz.image
            } else {
                return Assets.LayoutsRunes.naudiz.image
            }
        case .isaz:
            return  Assets.LayoutsRunes.isaz.image
        case .jara:
            return  Assets.LayoutsRunes.jara.image
        case .iwas:
            return  Assets.LayoutsRunes.iwaz.image
        case let .perpu(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reversePerpu.image
            } else {
                return Assets.LayoutsRunes.perpu.image
            }
        case let .algis(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseAlgiz.image
            } else {
                return Assets.LayoutsRunes.algiz.image
            }
        case .sowilu:
            return  Assets.LayoutsRunes.sowilu.image
        case let .tiwaz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseTiwaz.image
            } else {
                return Assets.LayoutsRunes.tiwaz.image
            }
        case let .berkana(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseBerkana.image
            } else {
                return Assets.LayoutsRunes.berkana.image
            }
        case let .ehwaz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseEhvaz.image
            } else {
                return Assets.LayoutsRunes.ehvaz.image
            }
        case let .mannaz(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseMannaz.image
            } else {
                return Assets.LayoutsRunes.mannaz.image
            }
        case let .lagus(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseLaguz.image
            } else {
                return Assets.LayoutsRunes.laguz.image
            }
        case .inwaz:
            return  Assets.LayoutsRunes.inwaz.image
        case .dagaz:
            return  Assets.LayoutsRunes.dagaz.image
        case let .opila(isReversed: isReversed):
            if isReversed {
                return Assets.LayoutsRunes.Reverse.reverseOpila.image
            } else {
                return Assets.LayoutsRunes.opila.image
            }
        case .odin:
            return  Assets.LayoutsRunes.odinRune.image
            
        }
    }
    
    var luck: Int {
        switch self {
        case let .fehu(isReversed: isReversed):
            if isReversed {
                return 30
            } else {
                return 60
            }
        case let .urus(isReversed: isReversed):
            if isReversed {
                return 20
            } else {
                return 80
            }
        case let .purisaz(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 20
            }
        case let .ansuz(isReversed: isReversed):
            if isReversed {
                return 20
            } else {
                return 70
            }
        case let .raidu(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 70
            }
        case let .kauna(isReversed: isReversed):
            if isReversed {
                return 20
            } else {
                return 80
            }
        case .gebu:
            return 90
        case let .wunji(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 70
            }
        case .hagalaz:
            return  30
        case let .naudiz(isReversed: isReversed):
            if isReversed {
                return 20
            } else {
                return 20
            }
        case .isaz:
            return  10
        case .jara:
            return  80
        case .iwas:
            return  20
        case let .perpu(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 50
            }
        case let .algis(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 70
            }
        case .sowilu:
            return  90
        case let .tiwaz(isReversed: isReversed):
            if isReversed {
                return 10
            } else {
                return 80
            }
        case let .berkana(isReversed: isReversed):
            if isReversed {
                return 30
            } else {
                return 70
            }
        case let .ehwaz(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 60
            }
        case let .mannaz(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 40
            }
        case let .lagus(isReversed: isReversed):
            if isReversed {
                return 30
            } else {
                return 50
            }
        case .inwaz:
            return  70
        case .dagaz:
            return  90
        case let .opila(isReversed: isReversed):
            if isReversed {
                return 40
            } else {
                return 50
            }
        case .odin:
            return  50
        }
    }
    
    var description: String {
        switch self {
        case let .fehu(isReversed: isReversed):
            if isReversed {
            return L10n.Description.Total.Reverse.fehu
            } else {
                return L10n.Description.Total.fehu
                
            }
        case .urus(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.uruz
            } else {
                return L10n.Description.Total.uruz
            }
        case .purisaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.purisaz
            } else {
                return L10n.Description.Total.purisaz
            }
        case .ansuz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.ansuz
            } else {
                return L10n.Description.Total.ansuz
            }
        case .raidu(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.raidu
            } else {
                return L10n.Description.Total.raidu
            }
        case .kauna(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.kauna
            } else {
                return L10n.Description.Total.kauna
            }
        case .gebu:
            return L10n.Description.Total.gebu
        case .wunji(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.wunji
            } else {
                return L10n.Description.Total.wunji
            }
        case .hagalaz:
            <#code#>
        case .naudiz(isReversed: let isReversed):
            <#code#>
        case .isaz:
            <#code#>
        case .jara:
            <#code#>
        case .iwas:
            <#code#>
        case .perpu(isReversed: let isReversed):
            <#code#>
        case .algis(isReversed: let isReversed):
            <#code#>
        case .sowilu:
            <#code#>
        case .tiwaz(isReversed: let isReversed):
            <#code#>
        case .berkana(isReversed: let isReversed):
            <#code#>
        case .ehwaz(isReversed: let isReversed):
            <#code#>
        case .mannaz(isReversed: let isReversed):
            <#code#>
        case .lagus(isReversed: let isReversed):
            <#code#>
        case .inwaz:
            <#code#>
        case .dagaz:
            <#code#>
        case .opila(isReversed: let isReversed):
            <#code#>
        case .odin:
            <#code#>
        }
    }

    func cross (runeType: RuneType) -> String {
        switch (self, runeType) {
        case (.fehu, .algis) :
            return L10n.InterpretationForTwoRunes.Fehu.algiz
            <#code#>
        default:
            <#code#>
        }
    }
    
    var value: String {
        switch self {
        case .fehu(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.fehu
            } else {
                return L10n.Description.Value.fehu
            }

        case .urus(isReversed: let isReversed):
            <#code#>
        case .purisaz(isReversed: let isReversed):
            <#code#>
        case .ansuz(isReversed: let isReversed):
            <#code#>
        case .raidu(isReversed: let isReversed):
            <#code#>
        case .kauna(isReversed: let isReversed):
            <#code#>
        case .gebu:
            <#code#>
        case .wunji(isReversed: let isReversed):
            <#code#>
        case .hagalaz:
            <#code#>
        case .naudiz(isReversed: let isReversed):
            <#code#>
        case .isaz:
            <#code#>
        case .jara:
            <#code#>
        case .iwas:
            <#code#>
        case .perpu(isReversed: let isReversed):
            <#code#>
        case .algis(isReversed: let isReversed):
            <#code#>
        case .sowilu:
            <#code#>
        case .tiwaz(isReversed: let isReversed):
            <#code#>
        case .berkana(isReversed: let isReversed):
            <#code#>
        case .ehwaz(isReversed: let isReversed):
            <#code#>
        case .mannaz(isReversed: let isReversed):
            <#code#>
        case .lagus(isReversed: let isReversed):
            <#code#>
        case .inwaz:
            <#code#>
        case .dagaz:
            <#code#>
        case .opila(isReversed: let isReversed):
            <#code#>
        case .odin:
            <#code#>
        }
    }
    
}
