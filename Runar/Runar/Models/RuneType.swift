import UIKit

public enum RuneType: Equatable {
    public typealias AllCases = Array<RuneType>

    public enum RuneSubType {
        case random
        case original
        case reversed
    }
    
    public static func allCases(subtype: RuneSubType = .original) {
       
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
            return  .urus(isReversed: Bool.random())
        case .purisaz:
            return  .purisaz(isReversed: Bool.random())
        case .ansuz:
            return  .ansuz(isReversed: Bool.random())
        case .raidu:
            return  .raidu(isReversed: Bool.random())
        case .kauna:
            return  .kauna(isReversed: Bool.random())
        case .gebu:
            return  .gebu
        case .wunji:
            return  .wunji(isReversed: Bool.random())
        case .hagalaz:
            return  .hagalaz
        case .naudiz:
            return  .naudiz(isReversed: Bool.random())
        case .isaz:
            return  .isaz
        case .jara:
            return  .jara
        case .iwas:
            return  .iwas
        case .perpu:
            return  .perpu(isReversed: Bool.random())
        case .algis:
            return  .algis(isReversed: Bool.random())
        case .sowilu:
            return  .sowilu
        case .tiwaz:
            return  .tiwaz(isReversed: Bool.random())
        case .berkana:
            return  .berkana(isReversed: Bool.random())
        case .ehwaz:
            return  .ehwaz(isReversed: Bool.random())
        case .mannaz:
            return  .mannaz(isReversed: Bool.random())
        case .lagus:
            return  .lagus(isReversed: Bool.random())
        case .inwaz:
            return  .inwaz
        case .dagaz:
            return  .dagaz
        case .opila:
            return  .opila(isReversed: Bool.random())
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
    
    var luck: String {
        switch self {
        case let .fehu(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.fehu
            } else {
                return L10n.Description.Auspiciousness.fehu
            }
        case let .urus(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.uruz
            } else {
                return L10n.Description.Auspiciousness.uruz
            }
        case let .purisaz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.purisaz
            } else {
                return L10n.Description.Auspiciousness.purisaz
            }
        case let .ansuz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.ansuz
            } else {
                return L10n.Description.Auspiciousness.ansuz
            }
        case let .raidu(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.raidu
            } else {
                return L10n.Description.Auspiciousness.raidu
            }
        case let .kauna(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.kauna
            } else {
                return L10n.Description.Auspiciousness.kauna
            }
        case .gebu:
            return L10n.Description.Auspiciousness.gebu
        case let .wunji(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.wunji
            } else {
                return L10n.Description.Auspiciousness.wunji
            }
        case .hagalaz:
            return  L10n.Description.Auspiciousness.hagalaz
        case let .naudiz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.naudiz
            } else {
                return L10n.Description.Auspiciousness.naudiz
            }
        case .isaz:
            return  L10n.Description.Auspiciousness.isaz
        case .jara:
            return  L10n.Description.Auspiciousness.jara
        case .iwas:
            return  L10n.Description.Auspiciousness.iwaz
        case let .perpu(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.perpu
            } else {
                return L10n.Description.Auspiciousness.perpu
            }
        case let .algis(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.algiz
            } else {
                return L10n.Description.Auspiciousness.algiz
            }
        case .sowilu:
            return  L10n.Description.Auspiciousness.sowilu
        case let .tiwaz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.tiwaz
            } else {
                return L10n.Description.Auspiciousness.tiwaz
            }
        case let .berkana(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.berkana
            } else {
                return L10n.Description.Auspiciousness.berkana
            }
        case let .ehwaz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.ehvaz
            } else {
                return L10n.Description.Auspiciousness.ehwaz
            }
        case let .mannaz(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.mannaz
            } else {
                return L10n.Description.Auspiciousness.mannaz
            }
        case let .lagus(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.laguz
            } else {
                return L10n.Description.Auspiciousness.laguz
            }
        case .inwaz:
            return  L10n.Description.Auspiciousness.inwaz
        case .dagaz:
            return  L10n.Description.Auspiciousness.dagaz
        case let .opila(isReversed: isReversed):
            if isReversed {
                return L10n.Description.Auspiciousness.Reverse.opila
            } else {
                return L10n.Description.Auspiciousness.opila
            }
        case .odin:
            return  L10n.Description.Auspiciousness.odin
        }
    }
    

}
