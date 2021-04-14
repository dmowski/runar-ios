import UIKit

extension String {
    static let present = L10n.present
    static let strength = L10n.strength
    static let situation = L10n.situation
    static let problem = L10n.problem
    static let solutionProblem = L10n.solutionProblem
    static let past = L10n.past
    static let situationInRealTime = L10n.situationInRealTime
    static let future = L10n.future
    static let solution = L10n.solution
    static let result = L10n.result
    static let help = L10n.help
    static let irresistibleStrength = L10n.irresistibleStrength
    static let yuorEssence = L10n.yuorEssence
    static let probableFuture = L10n.probableFuture
    static let ourAim = L10n.ourAim
    static let difficulties = L10n.difficulties
    static let stateOfAffairs = L10n.difficulties
    static let conditions = L10n.conditions
    static let reason = L10n.reason
    static let theBest = L10n.theBest
    static let awaitsYou = L10n.awaitsYou
}

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
            return L10n.Description.Total.hagalaz
        case .naudiz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.naudiz
            } else {
                return L10n.Description.Total.naudiz
            }
        case .isaz:
            return L10n.Description.Total.isaz
        case .jara:
            return L10n.Description.Total.jara
        case .iwas:
            return L10n.Description.Total.iwaz
        case .perpu(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.perpu
            } else {
                return L10n.Description.Total.perpu
            }
        case .algis(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.algiz
            } else {
                return L10n.Description.Total.algiz
            }
        case .sowilu:
            return L10n.Description.Total.sowilu
        case .tiwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.tiwaz
            } else {
                return L10n.Description.Total.tiwaz
            }
        case .berkana(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.berkana
            } else {
                return L10n.Description.Total.berkana
            }
        case .ehwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.ehvaz
            } else {
                return L10n.Description.Total.ehwaz
            }
        case .mannaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.mannaz
            } else {
                return L10n.Description.Total.mannaz
            }
        case .lagus(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.laguz
            } else {
                return L10n.Description.Total.laguz
            }
        case .inwaz:
            return L10n.Description.Total.inwaz
        case .dagaz:
            return L10n.Description.Total.dagaz
        case .opila(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Total.Reverse.opila
            } else {
                return L10n.Description.Total.opila
            }
        case .odin:
            return L10n.Description.Total.odin
        }
    }
    
    var name: String {
        switch self {
        case let .fehu(isReversed: isReversed):
            if isReversed {
            return L10n.Name.Reverse.fehu
            } else {
                return L10n.Name.fehu
                
            }
        case .urus(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.uruz
            } else {
                return L10n.Name.uruz
            }
        case .purisaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.purisaz
            } else {
                return L10n.Name.purisaz
            }
        case .ansuz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.ansuz
            } else {
                return L10n.Name.ansuz
            }
        case .raidu(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.raidu
            } else {
                return L10n.Name.raidu
            }
        case .kauna(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.kauna
            } else {
                return L10n.Name.kauna
            }
        case .gebu:
            return L10n.Name.gebu
        case .wunji(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.wunji
            } else {
                return L10n.Name.wunji
            }
        case .hagalaz:
            return L10n.Name.hagalaz
        case .naudiz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.naudiz
            } else {
                return L10n.Name.naudiz
            }
        case .isaz:
            return L10n.Name.isaz
        case .jara:
            return L10n.Name.jara
        case .iwas:
            return L10n.Name.iwaz
        case .perpu(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.perpu
            } else {
                return L10n.Name.perpu
            }
        case .algis(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.algiz
            } else {
                return L10n.Name.algiz
            }
        case .sowilu:
            return L10n.Name.sowilu
        case .tiwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.tiwaz
            } else {
                return L10n.Name.tiwaz
            }
        case .berkana(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.berkana
            } else {
                return L10n.Name.berkana
            }
        case .ehwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.ehvaz
            } else {
                return L10n.Name.ehwaz
            }
        case .mannaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.mannaz
            } else {
                return L10n.Name.mannaz
            }
        case .lagus(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.laguz
            } else {
                return L10n.Name.laguz
            }
        case .inwaz:
            return L10n.Name.inwaz
        case .dagaz:
            return L10n.Name.dagaz
        case .opila(isReversed: let isReversed):
            if isReversed {
                return L10n.Name.Reverse.opila
            } else {
                return L10n.Name.opila
            }
        case .odin:
            return L10n.Name.odin
        }
    }

    func cross (runeType: RuneType) -> String {
        switch (self, runeType) {
        case (.fehu, .urus) :
            return L10n.InterpretationForTwoRunes.Fehu.uruz
        case (.fehu, .purisaz):
        return L10n.InterpretationForTwoRunes.Fehu.turisaz
        case (.fehu, .ansuz):
            return L10n.InterpretationForTwoRunes.Fehu.ansuz
        case (.fehu, .raidu):
            return L10n.InterpretationForTwoRunes.Fehu.raido
        case (.fehu, .kauna):
            return L10n.InterpretationForTwoRunes.Fehu.kenaz
        case (.fehu, .gebu):
            return L10n.InterpretationForTwoRunes.Fehu.gebo
        case (.fehu, .wunji):
            return L10n.InterpretationForTwoRunes.Fehu.vunyo
        case (.fehu, .hagalaz):
            return L10n.InterpretationForTwoRunes.Fehu.halagaz
        case (.fehu, .naudiz):
            return L10n.InterpretationForTwoRunes.Fehu.nautiz
        case (.fehu, .isaz):
            return L10n.InterpretationForTwoRunes.Fehu.isa
        case (.fehu, .jara):
            return L10n.InterpretationForTwoRunes.Fehu.hyera
        case (.fehu, .iwas):
            return L10n.InterpretationForTwoRunes.Fehu.eyvaz
        case (.fehu, .perpu):
            return L10n.InterpretationForTwoRunes.Fehu.perth
        case (.fehu, .algis):
            return L10n.InterpretationForTwoRunes.Fehu.algiz
        case (.fehu, .sowilu):
            return L10n.InterpretationForTwoRunes.Fehu.sovilo
        case (.fehu, .tiwaz):
            return L10n.InterpretationForTwoRunes.Fehu.teyvaz
        case (.fehu, .berkana):
            return L10n.InterpretationForTwoRunes.Fehu.berkana
        case (.fehu, .ehwaz):
            return L10n.InterpretationForTwoRunes.Fehu.evaz
        case (.fehu, .mannaz):
            return L10n.InterpretationForTwoRunes.Fehu.mannaz
        case (.fehu, .lagus):
            return L10n.InterpretationForTwoRunes.Fehu.laguz
        case (.fehu, .inwaz):
            return L10n.InterpretationForTwoRunes.Fehu.inguz
        case (.fehu, .dagaz):
            return L10n.InterpretationForTwoRunes.Fehu.dagaz
        case (.fehu, .opila):
            return L10n.InterpretationForTwoRunes.Fehu.otilla
        case (.fehu, .odin):
            return L10n.InterpretationForTwoRunes.Fehu.runeOfOdin
        
        case (.urus, .fehu) :
            return L10n.InterpretationForTwoRunes.Uruz.fehu
        case (.urus, .purisaz):
            return L10n.InterpretationForTwoRunes.Uruz.turisaz
        case (.urus, .ansuz):
            return L10n.InterpretationForTwoRunes.Uruz.ansuz
        case (.urus, .raidu):
            return L10n.InterpretationForTwoRunes.Uruz.raido
        case (.urus, .kauna):
            return L10n.InterpretationForTwoRunes.Uruz.kenaz
        case (.urus, .gebu):
            return L10n.InterpretationForTwoRunes.Uruz.gebo
        case (.urus, .wunji):
            return L10n.InterpretationForTwoRunes.Uruz.vunyo
        case (.urus, .hagalaz):
            return L10n.InterpretationForTwoRunes.Uruz.halagaz
        case (.urus, .naudiz):
            return L10n.InterpretationForTwoRunes.Uruz.nautiz
        case (.urus, .isaz):
            return L10n.InterpretationForTwoRunes.Uruz.isa
        case (.urus, .jara):
            return L10n.InterpretationForTwoRunes.Uruz.hyera
        case (.urus, .iwas):
            return L10n.InterpretationForTwoRunes.Uruz.eyvaz
        case (.urus, .perpu):
            return L10n.InterpretationForTwoRunes.Uruz.perth
        case (.urus, .algis):
            return L10n.InterpretationForTwoRunes.Uruz.algiz
        case (.urus, .sowilu):
            return L10n.InterpretationForTwoRunes.Uruz.sovilo
        case (.urus, .tiwaz):
            return L10n.InterpretationForTwoRunes.Uruz.teyvaz
        case (.urus, .berkana):
            return L10n.InterpretationForTwoRunes.Uruz.berkana
        case (.urus, .ehwaz):
            return L10n.InterpretationForTwoRunes.Uruz.evaz
        case (.urus, .mannaz):
            return L10n.InterpretationForTwoRunes.Uruz.mannaz
        case (.urus, .lagus):
            return L10n.InterpretationForTwoRunes.Uruz.laguz
        case (.urus, .inwaz):
            return L10n.InterpretationForTwoRunes.Uruz.inguz
        case (.urus, .dagaz):
            return L10n.InterpretationForTwoRunes.Uruz.dagaz
        case (.urus, .opila):
            return L10n.InterpretationForTwoRunes.Uruz.otilla
        case (.urus, .odin):
            return L10n.InterpretationForTwoRunes.Uruz.runeOfOdin
            
        case (.purisaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Turisaz.fehu
        case (.purisaz, .urus):
            return L10n.InterpretationForTwoRunes.Turisaz.uruz
        case (.purisaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Turisaz.ansuz
        case (.purisaz, .raidu):
            return L10n.InterpretationForTwoRunes.Turisaz.raido
        case (.purisaz, .kauna):
            return L10n.InterpretationForTwoRunes.Turisaz.kenaz
        case (.purisaz, .gebu):
            return L10n.InterpretationForTwoRunes.Turisaz.gebo
        case (.purisaz, .wunji):
            return L10n.InterpretationForTwoRunes.Turisaz.vunyo
        case (.purisaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Turisaz.halagaz
        case (.purisaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Turisaz.nautiz
        case (.purisaz, .isaz):
            return L10n.InterpretationForTwoRunes.Turisaz.isa
        case (.purisaz, .jara):
            return L10n.InterpretationForTwoRunes.Turisaz.hyera
        case (.purisaz, .iwas):
            return L10n.InterpretationForTwoRunes.Turisaz.eyvaz
        case (.purisaz, .perpu):
            return L10n.InterpretationForTwoRunes.Turisaz.perth
        case (.purisaz, .algis):
            return L10n.InterpretationForTwoRunes.Turisaz.algiz
        case (.purisaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Turisaz.sovilo
        case (.purisaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Turisaz.teyvaz
        case (.purisaz, .berkana):
            return L10n.InterpretationForTwoRunes.Turisaz.berkana
        case (.purisaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Turisaz.evaz
        case (.purisaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Turisaz.mannaz
        case (.purisaz, .lagus):
            return L10n.InterpretationForTwoRunes.Turisaz.laguz
        case (.purisaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Turisaz.inguz
        case (.purisaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Turisaz.dagaz
        case (.purisaz, .opila):
            return L10n.InterpretationForTwoRunes.Turisaz.otilla
        case (.purisaz, .odin):
            return L10n.InterpretationForTwoRunes.Turisaz.runeOfOdin
            
        case (.ansuz, .fehu) :
            return L10n.InterpretationForTwoRunes.Ansuz.fehu
        case (.ansuz, .urus):
            return L10n.InterpretationForTwoRunes.Ansuz.uruz
        case (.ansuz, .purisaz):
            return L10n.InterpretationForTwoRunes.Ansuz.turisaz
        case (.ansuz, .raidu):
            return L10n.InterpretationForTwoRunes.Ansuz.raido
        case (.ansuz, .kauna):
            return L10n.InterpretationForTwoRunes.Ansuz.kenaz
        case (.ansuz, .gebu):
            return L10n.InterpretationForTwoRunes.Ansuz.gebo
        case (.ansuz, .wunji):
            return L10n.InterpretationForTwoRunes.Ansuz.vunyo
        case (.ansuz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Ansuz.halagaz
        case (.ansuz, .naudiz):
            return L10n.InterpretationForTwoRunes.Ansuz.nautiz
        case (.ansuz, .isaz):
            return L10n.InterpretationForTwoRunes.Ansuz.isa
        case (.ansuz, .jara):
            return L10n.InterpretationForTwoRunes.Ansuz.hyera
        case (.ansuz, .iwas):
            return L10n.InterpretationForTwoRunes.Ansuz.eyvaz
        case (.ansuz, .perpu):
            return L10n.InterpretationForTwoRunes.Ansuz.perth
        case (.ansuz, .algis):
            return L10n.InterpretationForTwoRunes.Ansuz.algiz
        case (.ansuz, .sowilu):
            return L10n.InterpretationForTwoRunes.Ansuz.sovilo
        case (.ansuz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Ansuz.teyvaz
        case (.ansuz, .berkana):
            return L10n.InterpretationForTwoRunes.Ansuz.berkana
        case (.ansuz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Ansuz.evaz
        case (.ansuz, .mannaz):
            return L10n.InterpretationForTwoRunes.Ansuz.mannaz
        case (.ansuz, .lagus):
            return L10n.InterpretationForTwoRunes.Ansuz.laguz
        case (.ansuz, .inwaz):
            return L10n.InterpretationForTwoRunes.Ansuz.inguz
        case (.ansuz, .dagaz):
            return L10n.InterpretationForTwoRunes.Ansuz.dagaz
        case (.ansuz, .opila):
            return L10n.InterpretationForTwoRunes.Ansuz.otilla
        case (.ansuz, .odin):
            return L10n.InterpretationForTwoRunes.Ansuz.runeOfOdin
            
        case (.raidu, .fehu) :
            return L10n.InterpretationForTwoRunes.Raido.fehu
        case (.raidu, .urus):
            return L10n.InterpretationForTwoRunes.Raido.uruz
        case (.raidu, .purisaz):
            return L10n.InterpretationForTwoRunes.Raido.turisaz
        case (.raidu, .ansuz):
            return L10n.InterpretationForTwoRunes.Raido.ansuz
        case (.raidu, .kauna):
            return L10n.InterpretationForTwoRunes.Raido.kenaz
        case (.raidu, .gebu):
            return L10n.InterpretationForTwoRunes.Raido.gebo
        case (.raidu, .wunji):
            return L10n.InterpretationForTwoRunes.Raido.vunyo
        case (.raidu, .hagalaz):
            return L10n.InterpretationForTwoRunes.Raido.halagaz
        case (.raidu, .naudiz):
            return L10n.InterpretationForTwoRunes.Raido.nautiz
        case (.raidu, .isaz):
            return L10n.InterpretationForTwoRunes.Raido.isa
        case (.raidu, .jara):
            return L10n.InterpretationForTwoRunes.Raido.hyera
        case (.raidu, .iwas):
            return L10n.InterpretationForTwoRunes.Raido.eyvaz
        case (.raidu, .perpu):
            return L10n.InterpretationForTwoRunes.Raido.perth
        case (.raidu, .algis):
            return L10n.InterpretationForTwoRunes.Raido.algiz
        case (.raidu, .sowilu):
            return L10n.InterpretationForTwoRunes.Raido.sovilo
        case (.raidu, .tiwaz):
            return L10n.InterpretationForTwoRunes.Raido.teyvaz
        case (.raidu, .berkana):
            return L10n.InterpretationForTwoRunes.Raido.berkana
        case (.raidu, .ehwaz):
            return L10n.InterpretationForTwoRunes.Raido.evaz
        case (.raidu, .mannaz):
            return L10n.InterpretationForTwoRunes.Raido.mannaz
        case (.raidu, .lagus):
            return L10n.InterpretationForTwoRunes.Raido.laguz
        case (.raidu, .inwaz):
            return L10n.InterpretationForTwoRunes.Raido.inguz
        case (.raidu, .dagaz):
            return L10n.InterpretationForTwoRunes.Raido.dagaz
        case (.raidu, .opila):
            return L10n.InterpretationForTwoRunes.Raido.otilla
        case (.raidu, .odin):
            return L10n.InterpretationForTwoRunes.Raido.runeOfOdin
            
        case (.kauna, .fehu) :
            return L10n.InterpretationForTwoRunes.Kenaz.fehu
        case (.kauna, .urus):
            return L10n.InterpretationForTwoRunes.Kenaz.uruz
        case (.kauna, .purisaz):
            return L10n.InterpretationForTwoRunes.Kenaz.turisaz
        case (.kauna, .ansuz):
            return L10n.InterpretationForTwoRunes.Kenaz.ansuz
        case (.kauna, .raidu):
            return L10n.InterpretationForTwoRunes.Kenaz.raido
        case (.kauna, .gebu):
            return L10n.InterpretationForTwoRunes.Kenaz.gebo
        case (.kauna, .wunji):
            return L10n.InterpretationForTwoRunes.Kenaz.vunyo
        case (.kauna, .hagalaz):
            return L10n.InterpretationForTwoRunes.Kenaz.halagaz
        case (.kauna, .naudiz):
            return L10n.InterpretationForTwoRunes.Kenaz.nautiz
        case (.kauna, .isaz):
            return L10n.InterpretationForTwoRunes.Kenaz.isa
        case (.kauna, .jara):
            return L10n.InterpretationForTwoRunes.Kenaz.hyera
        case (.kauna, .iwas):
            return L10n.InterpretationForTwoRunes.Kenaz.eyvaz
        case (.kauna, .perpu):
            return L10n.InterpretationForTwoRunes.Kenaz.perth
        case (.kauna, .algis):
            return L10n.InterpretationForTwoRunes.Kenaz.algiz
        case (.kauna, .sowilu):
            return L10n.InterpretationForTwoRunes.Kenaz.sovilo
        case (.kauna, .tiwaz):
            return L10n.InterpretationForTwoRunes.Kenaz.teyvaz
        case (.kauna, .berkana):
            return L10n.InterpretationForTwoRunes.Kenaz.berkana
        case (.kauna, .ehwaz):
            return L10n.InterpretationForTwoRunes.Kenaz.evaz
        case (.kauna, .mannaz):
            return L10n.InterpretationForTwoRunes.Kenaz.mannaz
        case (.kauna, .lagus):
            return L10n.InterpretationForTwoRunes.Kenaz.laguz
        case (.kauna, .inwaz):
            return L10n.InterpretationForTwoRunes.Kenaz.inguz
        case (.kauna, .dagaz):
            return L10n.InterpretationForTwoRunes.Kenaz.dagaz
        case (.kauna, .opila):
            return L10n.InterpretationForTwoRunes.Kenaz.otilla
        case (.kauna, .odin):
            return L10n.InterpretationForTwoRunes.Kenaz.runeOfOdin
            
        case (.gebu, .fehu) :
            return L10n.InterpretationForTwoRunes.Gebo.fehu
        case (.gebu, .urus):
            return L10n.InterpretationForTwoRunes.Gebo.uruz
        case (.gebu, .purisaz):
            return L10n.InterpretationForTwoRunes.Gebo.turisaz
        case (.gebu, .ansuz):
            return L10n.InterpretationForTwoRunes.Gebo.ansuz
        case (.gebu, .raidu):
            return L10n.InterpretationForTwoRunes.Gebo.raido
        case (.gebu, .kauna):
            return L10n.InterpretationForTwoRunes.Gebo.kenaz
        case (.gebu, .wunji):
            return L10n.InterpretationForTwoRunes.Gebo.vunyo
        case (.gebu, .hagalaz):
            return L10n.InterpretationForTwoRunes.Gebo.halagaz
        case (.gebu, .naudiz):
            return L10n.InterpretationForTwoRunes.Gebo.nautiz
        case (.gebu, .isaz):
            return L10n.InterpretationForTwoRunes.Gebo.isa
        case (.gebu, .jara):
            return L10n.InterpretationForTwoRunes.Gebo.hyera
        case (.gebu, .iwas):
            return L10n.InterpretationForTwoRunes.Gebo.eyvaz
        case (.gebu, .perpu):
            return L10n.InterpretationForTwoRunes.Gebo.perth
        case (.gebu, .algis):
            return L10n.InterpretationForTwoRunes.Gebo.algiz
        case (.gebu, .sowilu):
            return L10n.InterpretationForTwoRunes.Gebo.sovilo
        case (.gebu, .tiwaz):
            return L10n.InterpretationForTwoRunes.Gebo.teyvaz
        case (.gebu, .berkana):
            return L10n.InterpretationForTwoRunes.Gebo.berkana
        case (.gebu, .ehwaz):
            return L10n.InterpretationForTwoRunes.Gebo.evaz
        case (.gebu, .mannaz):
            return L10n.InterpretationForTwoRunes.Gebo.mannaz
        case (.gebu, .lagus):
            return L10n.InterpretationForTwoRunes.Gebo.laguz
        case (.gebu, .inwaz):
            return L10n.InterpretationForTwoRunes.Gebo.inguz
        case (.gebu, .dagaz):
            return L10n.InterpretationForTwoRunes.Gebo.dagaz
        case (.gebu, .opila):
            return L10n.InterpretationForTwoRunes.Gebo.otilla
        case (.gebu, .odin):
            return L10n.InterpretationForTwoRunes.Gebo.runeOfOdin
            
        case (.wunji, .fehu) :
            return L10n.InterpretationForTwoRunes.Vunyo.fehu
        case (.wunji, .urus):
            return L10n.InterpretationForTwoRunes.Vunyo.uruz
        case (.wunji, .purisaz):
            return L10n.InterpretationForTwoRunes.Vunyo.turisaz
        case (.wunji, .ansuz):
            return L10n.InterpretationForTwoRunes.Vunyo.ansuz
        case (.wunji, .raidu):
            return L10n.InterpretationForTwoRunes.Vunyo.raido
        case (.wunji, .kauna):
            return L10n.InterpretationForTwoRunes.Vunyo.kenaz
        case (.wunji, .gebu):
            return L10n.InterpretationForTwoRunes.Vunyo.gebo
        case (.wunji, .hagalaz):
            return L10n.InterpretationForTwoRunes.Vunyo.halagaz
        case (.wunji, .naudiz):
            return L10n.InterpretationForTwoRunes.Vunyo.nautiz
        case (.wunji, .isaz):
            return L10n.InterpretationForTwoRunes.Vunyo.isa
        case (.wunji, .jara):
            return L10n.InterpretationForTwoRunes.Vunyo.hyera
        case (.wunji, .iwas):
            return L10n.InterpretationForTwoRunes.Vunyo.eyvaz
        case (.wunji, .perpu):
            return L10n.InterpretationForTwoRunes.Vunyo.perth
        case (.wunji, .algis):
            return L10n.InterpretationForTwoRunes.Vunyo.algiz
        case (.wunji, .sowilu):
            return L10n.InterpretationForTwoRunes.Vunyo.sovilo
        case (.wunji, .tiwaz):
            return L10n.InterpretationForTwoRunes.Vunyo.teyvaz
        case (.wunji, .berkana):
            return L10n.InterpretationForTwoRunes.Vunyo.berkana
        case (.wunji, .ehwaz):
            return L10n.InterpretationForTwoRunes.Vunyo.evaz
        case (.wunji, .mannaz):
            return L10n.InterpretationForTwoRunes.Vunyo.mannaz
        case (.wunji, .lagus):
            return L10n.InterpretationForTwoRunes.Vunyo.laguz
        case (.wunji, .inwaz):
            return L10n.InterpretationForTwoRunes.Vunyo.inguz
        case (.wunji, .dagaz):
            return L10n.InterpretationForTwoRunes.Vunyo.dagaz
        case (.wunji, .opila):
            return L10n.InterpretationForTwoRunes.Vunyo.otilla
        case (.wunji, .odin):
            return L10n.InterpretationForTwoRunes.Vunyo.runeOfOdin
            
        case (.hagalaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Halagaz.fehu
        case (.hagalaz, .urus):
            return L10n.InterpretationForTwoRunes.Halagaz.uruz
        case (.hagalaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Halagaz.turisaz
        case (.hagalaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Halagaz.ansuz
        case (.hagalaz, .raidu):
            return L10n.InterpretationForTwoRunes.Halagaz.raido
        case (.hagalaz, .kauna):
            return L10n.InterpretationForTwoRunes.Halagaz.kenaz
        case (.hagalaz, .gebu):
            return L10n.InterpretationForTwoRunes.Halagaz.gebo
        case (.hagalaz, .wunji):
            return L10n.InterpretationForTwoRunes.Halagaz.vunyo
        case (.hagalaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Halagaz.nautiz
        case (.hagalaz, .isaz):
            return L10n.InterpretationForTwoRunes.Halagaz.isa
        case (.hagalaz, .jara):
            return L10n.InterpretationForTwoRunes.Halagaz.hyera
        case (.hagalaz, .iwas):
            return L10n.InterpretationForTwoRunes.Halagaz.eyvaz
        case (.hagalaz, .perpu):
            return L10n.InterpretationForTwoRunes.Halagaz.perth
        case (.hagalaz, .algis):
            return L10n.InterpretationForTwoRunes.Halagaz.algiz
        case (.hagalaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Halagaz.sovilo
        case (.hagalaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Halagaz.teyvaz
        case (.hagalaz, .berkana):
            return L10n.InterpretationForTwoRunes.Halagaz.berkana
        case (.hagalaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Halagaz.evaz
        case (.hagalaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Halagaz.mannaz
        case (.hagalaz, .lagus):
            return L10n.InterpretationForTwoRunes.Halagaz.laguz
        case (.hagalaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Halagaz.inguz
        case (.hagalaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Halagaz.dagaz
        case (.hagalaz, .opila):
            return L10n.InterpretationForTwoRunes.Halagaz.otilla
        case (.hagalaz, .odin):
            return L10n.InterpretationForTwoRunes.Halagaz.runeOfOdin
            
        case (.naudiz, .fehu) :
            return L10n.InterpretationForTwoRunes.Nautiz.fehu
        case (.naudiz, .urus):
            return L10n.InterpretationForTwoRunes.Nautiz.uruz
        case (.naudiz, .purisaz):
            return L10n.InterpretationForTwoRunes.Nautiz.turisaz
        case (.naudiz, .ansuz):
            return L10n.InterpretationForTwoRunes.Nautiz.ansuz
        case (.naudiz, .raidu):
            return L10n.InterpretationForTwoRunes.Nautiz.raido
        case (.naudiz, .kauna):
            return L10n.InterpretationForTwoRunes.Nautiz.kenaz
        case (.naudiz, .gebu):
            return L10n.InterpretationForTwoRunes.Nautiz.gebo
        case (.naudiz, .wunji):
            return L10n.InterpretationForTwoRunes.Nautiz.vunyo
        case (.naudiz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Nautiz.halagaz
        case (.naudiz, .isaz):
            return L10n.InterpretationForTwoRunes.Nautiz.isa
        case (.naudiz, .jara):
            return L10n.InterpretationForTwoRunes.Nautiz.hyera
        case (.naudiz, .iwas):
            return L10n.InterpretationForTwoRunes.Nautiz.eyvaz
        case (.naudiz, .perpu):
            return L10n.InterpretationForTwoRunes.Nautiz.perth
        case (.naudiz, .algis):
            return L10n.InterpretationForTwoRunes.Nautiz.algiz
        case (.naudiz, .sowilu):
            return L10n.InterpretationForTwoRunes.Nautiz.sovilo
        case (.naudiz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Nautiz.teyvaz
        case (.naudiz, .berkana):
            return L10n.InterpretationForTwoRunes.Nautiz.berkana
        case (.naudiz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Nautiz.evaz
        case (.naudiz, .mannaz):
            return L10n.InterpretationForTwoRunes.Nautiz.mannaz
        case (.naudiz, .lagus):
            return L10n.InterpretationForTwoRunes.Nautiz.laguz
        case (.naudiz, .inwaz):
            return L10n.InterpretationForTwoRunes.Nautiz.inguz
        case (.naudiz, .dagaz):
            return L10n.InterpretationForTwoRunes.Nautiz.dagaz
        case (.naudiz, .opila):
            return L10n.InterpretationForTwoRunes.Nautiz.otilla
        case (.naudiz, .odin):
            return L10n.InterpretationForTwoRunes.Nautiz.runeOfOdin
            
        case (.isaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Isa.fehu
        case (.isaz, .urus):
            return L10n.InterpretationForTwoRunes.Isa.uruz
        case (.isaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Isa.turisaz
        case (.isaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Isa.ansuz
        case (.isaz, .raidu):
            return L10n.InterpretationForTwoRunes.Isa.raido
        case (.isaz, .kauna):
            return L10n.InterpretationForTwoRunes.Isa.kenaz
        case (.isaz, .gebu):
            return L10n.InterpretationForTwoRunes.Isa.gebo
        case (.isaz, .wunji):
            return L10n.InterpretationForTwoRunes.Isa.vunyo
        case (.isaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Isa.halagaz
        case (.isaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Isa.nautiz
        case (.isaz, .jara):
            return L10n.InterpretationForTwoRunes.Isa.hyera
        case (.isaz, .iwas):
            return L10n.InterpretationForTwoRunes.Isa.eyvaz
        case (.isaz, .perpu):
            return L10n.InterpretationForTwoRunes.Isa.perth
        case (.isaz, .algis):
            return L10n.InterpretationForTwoRunes.Isa.algiz
        case (.isaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Isa.sovilo
        case (.isaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Isa.teyvaz
        case (.isaz, .berkana):
            return L10n.InterpretationForTwoRunes.Isa.berkana
        case (.isaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Isa.evaz
        case (.isaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Isa.mannaz
        case (.isaz, .lagus):
            return L10n.InterpretationForTwoRunes.Isa.laguz
        case (.isaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Isa.inguz
        case (.isaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Isa.dagaz
        case (.isaz, .opila):
            return L10n.InterpretationForTwoRunes.Isa.otilla
        case (.isaz, .odin):
            return L10n.InterpretationForTwoRunes.Isa.runeOfOdin
            
        case (.jara, .fehu) :
            return L10n.InterpretationForTwoRunes.Hyera.fehu
        case (.jara, .urus):
            return L10n.InterpretationForTwoRunes.Hyera.uruz
        case (.jara, .purisaz):
            return L10n.InterpretationForTwoRunes.Hyera.turisaz
        case (.jara, .ansuz):
            return L10n.InterpretationForTwoRunes.Hyera.ansuz
        case (.jara, .raidu):
            return L10n.InterpretationForTwoRunes.Hyera.raido
        case (.jara, .kauna):
            return L10n.InterpretationForTwoRunes.Hyera.kenaz
        case (.jara, .gebu):
            return L10n.InterpretationForTwoRunes.Hyera.gebo
        case (.jara, .wunji):
            return L10n.InterpretationForTwoRunes.Hyera.vunyo
        case (.jara, .hagalaz):
            return L10n.InterpretationForTwoRunes.Hyera.halagaz
        case (.jara, .naudiz):
            return L10n.InterpretationForTwoRunes.Hyera.nautiz
        case (.jara, .isaz):
            return L10n.InterpretationForTwoRunes.Hyera.isa
        case (.jara, .iwas):
            return L10n.InterpretationForTwoRunes.Hyera.eyvaz
        case (.jara, .perpu):
            return L10n.InterpretationForTwoRunes.Hyera.perth
        case (.jara, .algis):
            return L10n.InterpretationForTwoRunes.Hyera.algiz
        case (.jara, .sowilu):
            return L10n.InterpretationForTwoRunes.Hyera.sovilo
        case (.jara, .tiwaz):
            return L10n.InterpretationForTwoRunes.Hyera.teyvaz
        case (.jara, .berkana):
            return L10n.InterpretationForTwoRunes.Hyera.berkana
        case (.jara, .ehwaz):
            return L10n.InterpretationForTwoRunes.Hyera.evaz
        case (.jara, .mannaz):
            return L10n.InterpretationForTwoRunes.Hyera.mannaz
        case (.jara, .lagus):
            return L10n.InterpretationForTwoRunes.Hyera.laguz
        case (.jara, .inwaz):
            return L10n.InterpretationForTwoRunes.Hyera.inguz
        case (.jara, .dagaz):
            return L10n.InterpretationForTwoRunes.Hyera.dagaz
        case (.jara, .opila):
            return L10n.InterpretationForTwoRunes.Hyera.otilla
        case (.jara, .odin):
            return L10n.InterpretationForTwoRunes.Hyera.runeOfOdin
            
        case (.iwas, .fehu) :
            return L10n.InterpretationForTwoRunes.Eyvaz.fehu
        case (.iwas, .urus):
            return L10n.InterpretationForTwoRunes.Eyvaz.uruz
        case (.iwas, .purisaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.turisaz
        case (.iwas, .ansuz):
            return L10n.InterpretationForTwoRunes.Eyvaz.ansuz
        case (.iwas, .raidu):
            return L10n.InterpretationForTwoRunes.Eyvaz.raido
        case (.iwas, .kauna):
            return L10n.InterpretationForTwoRunes.Eyvaz.kenaz
        case (.iwas, .gebu):
            return L10n.InterpretationForTwoRunes.Eyvaz.gebo
        case (.iwas, .wunji):
            return L10n.InterpretationForTwoRunes.Eyvaz.vunyo
        case (.iwas, .hagalaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.halagaz
        case (.iwas, .naudiz):
            return L10n.InterpretationForTwoRunes.Eyvaz.nautiz
        case (.iwas, .isaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.isa
        case (.iwas, .jara):
            return L10n.InterpretationForTwoRunes.Eyvaz.hyera
        case (.iwas, .perpu):
            return L10n.InterpretationForTwoRunes.Eyvaz.perth
        case (.iwas, .algis):
            return L10n.InterpretationForTwoRunes.Eyvaz.algiz
        case (.iwas, .sowilu):
            return L10n.InterpretationForTwoRunes.Eyvaz.sovilo
        case (.iwas, .tiwaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.teyvaz
        case (.iwas, .berkana):
            return L10n.InterpretationForTwoRunes.Eyvaz.berkana
        case (.iwas, .ehwaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.evaz
        case (.iwas, .mannaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.mannaz
        case (.iwas, .lagus):
            return L10n.InterpretationForTwoRunes.Eyvaz.laguz
        case (.iwas, .inwaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.inguz
        case (.iwas, .dagaz):
            return L10n.InterpretationForTwoRunes.Eyvaz.dagaz
        case (.iwas, .opila):
            return L10n.InterpretationForTwoRunes.Eyvaz.otilla
        case (.iwas, .odin):
            return L10n.InterpretationForTwoRunes.Eyvaz.runeOfOdin
            
        case (.perpu, .fehu) :
            return L10n.InterpretationForTwoRunes.Perth.fehu
        case (.perpu, .urus):
            return L10n.InterpretationForTwoRunes.Perth.uruz
        case (.perpu, .purisaz):
            return L10n.InterpretationForTwoRunes.Perth.turisaz
        case (.perpu, .ansuz):
            return L10n.InterpretationForTwoRunes.Perth.ansuz
        case (.perpu, .raidu):
            return L10n.InterpretationForTwoRunes.Perth.raido
        case (.perpu, .kauna):
            return L10n.InterpretationForTwoRunes.Perth.kenaz
        case (.perpu, .gebu):
            return L10n.InterpretationForTwoRunes.Perth.gebo
        case (.perpu, .wunji):
            return L10n.InterpretationForTwoRunes.Perth.vunyo
        case (.perpu, .hagalaz):
            return L10n.InterpretationForTwoRunes.Perth.halagaz
        case (.perpu, .naudiz):
            return L10n.InterpretationForTwoRunes.Perth.nautiz
        case (.perpu, .isaz):
            return L10n.InterpretationForTwoRunes.Perth.isa
        case (.perpu, .jara):
            return L10n.InterpretationForTwoRunes.Perth.hyera
        case (.perpu, .iwas):
            return L10n.InterpretationForTwoRunes.Perth.eyvaz
        case (.perpu, .algis):
            return L10n.InterpretationForTwoRunes.Perth.algiz
        case (.perpu, .sowilu):
            return L10n.InterpretationForTwoRunes.Perth.sovilo
        case (.perpu, .tiwaz):
            return L10n.InterpretationForTwoRunes.Perth.teyvaz
        case (.perpu, .berkana):
            return L10n.InterpretationForTwoRunes.Perth.berkana
        case (.perpu, .ehwaz):
            return L10n.InterpretationForTwoRunes.Perth.evaz
        case (.perpu, .mannaz):
            return L10n.InterpretationForTwoRunes.Perth.mannaz
        case (.perpu, .lagus):
            return L10n.InterpretationForTwoRunes.Perth.laguz
        case (.perpu, .inwaz):
            return L10n.InterpretationForTwoRunes.Perth.inguz
        case (.perpu, .dagaz):
            return L10n.InterpretationForTwoRunes.Perth.dagaz
        case (.perpu, .opila):
            return L10n.InterpretationForTwoRunes.Perth.otilla
        case (.perpu, .odin):
            return L10n.InterpretationForTwoRunes.Perth.runeOfOdin
            
        case (.algis, .fehu) :
            return L10n.InterpretationForTwoRunes.Algiz.fehu
        case (.algis, .urus):
            return L10n.InterpretationForTwoRunes.Algiz.uruz
        case (.algis, .purisaz):
            return L10n.InterpretationForTwoRunes.Algiz.turisaz
        case (.algis, .ansuz):
            return L10n.InterpretationForTwoRunes.Algiz.ansuz
        case (.algis, .raidu):
            return L10n.InterpretationForTwoRunes.Algiz.raido
        case (.algis, .kauna):
            return L10n.InterpretationForTwoRunes.Algiz.kenaz
        case (.algis, .gebu):
            return L10n.InterpretationForTwoRunes.Algiz.gebo
        case (.algis, .wunji):
            return L10n.InterpretationForTwoRunes.Algiz.vunyo
        case (.algis, .hagalaz):
            return L10n.InterpretationForTwoRunes.Algiz.halagaz
        case (.algis, .naudiz):
            return L10n.InterpretationForTwoRunes.Algiz.nautiz
        case (.algis, .isaz):
            return L10n.InterpretationForTwoRunes.Algiz.isa
        case (.algis, .jara):
            return L10n.InterpretationForTwoRunes.Algiz.hyera
        case (.algis, .iwas):
            return L10n.InterpretationForTwoRunes.Algiz.eyvaz
        case (.algis, .perpu):
            return L10n.InterpretationForTwoRunes.Algiz.perth
        case (.algis, .sowilu):
            return L10n.InterpretationForTwoRunes.Algiz.sovilo
        case (.algis, .tiwaz):
            return L10n.InterpretationForTwoRunes.Algiz.teyvaz
        case (.algis, .berkana):
            return L10n.InterpretationForTwoRunes.Algiz.berkana
        case (.algis, .ehwaz):
            return L10n.InterpretationForTwoRunes.Algiz.evaz
        case (.algis, .mannaz):
            return L10n.InterpretationForTwoRunes.Algiz.mannaz
        case (.algis, .lagus):
            return L10n.InterpretationForTwoRunes.Algiz.laguz
        case (.algis, .inwaz):
            return L10n.InterpretationForTwoRunes.Algiz.inguz
        case (.algis, .dagaz):
            return L10n.InterpretationForTwoRunes.Algiz.dagaz
        case (.algis, .opila):
            return L10n.InterpretationForTwoRunes.Algiz.otilla
        case (.algis, .odin):
            return L10n.InterpretationForTwoRunes.Algiz.runeOfOdin
            
        case (.sowilu, .fehu) :
            return L10n.InterpretationForTwoRunes.Sovilo.fehu
        case (.sowilu, .urus):
            return L10n.InterpretationForTwoRunes.Sovilo.uruz
        case (.sowilu, .purisaz):
            return L10n.InterpretationForTwoRunes.Sovilo.turisaz
        case (.sowilu, .ansuz):
            return L10n.InterpretationForTwoRunes.Sovilo.ansuz
        case (.sowilu, .raidu):
            return L10n.InterpretationForTwoRunes.Sovilo.raido
        case (.sowilu, .kauna):
            return L10n.InterpretationForTwoRunes.Sovilo.kenaz
        case (.sowilu, .gebu):
            return L10n.InterpretationForTwoRunes.Sovilo.gebo
        case (.sowilu, .wunji):
            return L10n.InterpretationForTwoRunes.Sovilo.vunyo
        case (.sowilu, .hagalaz):
            return L10n.InterpretationForTwoRunes.Sovilo.halagaz
        case (.sowilu, .naudiz):
            return L10n.InterpretationForTwoRunes.Sovilo.nautiz
        case (.sowilu, .isaz):
            return L10n.InterpretationForTwoRunes.Sovilo.isa
        case (.sowilu, .jara):
            return L10n.InterpretationForTwoRunes.Sovilo.hyera
        case (.sowilu, .iwas):
            return L10n.InterpretationForTwoRunes.Sovilo.eyvaz
        case (.sowilu, .perpu):
            return L10n.InterpretationForTwoRunes.Sovilo.perth
        case (.sowilu, .algis):
            return L10n.InterpretationForTwoRunes.Sovilo.algiz
        case (.sowilu, .tiwaz):
            return L10n.InterpretationForTwoRunes.Sovilo.teyvaz
        case (.sowilu, .berkana):
            return L10n.InterpretationForTwoRunes.Sovilo.berkana
        case (.sowilu, .ehwaz):
            return L10n.InterpretationForTwoRunes.Sovilo.evaz
        case (.sowilu, .mannaz):
            return L10n.InterpretationForTwoRunes.Sovilo.mannaz
        case (.sowilu, .lagus):
            return L10n.InterpretationForTwoRunes.Sovilo.laguz
        case (.sowilu, .inwaz):
            return L10n.InterpretationForTwoRunes.Sovilo.inguz
        case (.sowilu, .dagaz):
            return L10n.InterpretationForTwoRunes.Sovilo.dagaz
        case (.sowilu, .opila):
            return L10n.InterpretationForTwoRunes.Sovilo.otilla
        case (.sowilu, .odin):
            return L10n.InterpretationForTwoRunes.Sovilo.runeOfOdin
            
        case (.tiwaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Teyvaz.fehu
        case (.tiwaz, .urus):
            return L10n.InterpretationForTwoRunes.Teyvaz.uruz
        case (.tiwaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.turisaz
        case (.tiwaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Teyvaz.ansuz
        case (.tiwaz, .raidu):
            return L10n.InterpretationForTwoRunes.Teyvaz.raido
        case (.tiwaz, .kauna):
            return L10n.InterpretationForTwoRunes.Teyvaz.kenaz
        case (.tiwaz, .gebu):
            return L10n.InterpretationForTwoRunes.Teyvaz.gebo
        case (.tiwaz, .wunji):
            return L10n.InterpretationForTwoRunes.Teyvaz.vunyo
        case (.tiwaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.halagaz
        case (.tiwaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Teyvaz.nautiz
        case (.tiwaz, .isaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.isa
        case (.tiwaz, .jara):
            return L10n.InterpretationForTwoRunes.Teyvaz.hyera
        case (.tiwaz, .iwas):
            return L10n.InterpretationForTwoRunes.Teyvaz.eyvaz
        case (.tiwaz, .perpu):
            return L10n.InterpretationForTwoRunes.Teyvaz.perth
        case (.tiwaz, .algis):
            return L10n.InterpretationForTwoRunes.Teyvaz.algiz
        case (.tiwaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Teyvaz.sovilo
        case (.tiwaz, .berkana):
            return L10n.InterpretationForTwoRunes.Teyvaz.berkana
        case (.tiwaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.evaz
        case (.tiwaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.mannaz
        case (.tiwaz, .lagus):
            return L10n.InterpretationForTwoRunes.Teyvaz.laguz
        case (.tiwaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.inguz
        case (.tiwaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Teyvaz.dagaz
        case (.tiwaz, .opila):
            return L10n.InterpretationForTwoRunes.Teyvaz.otilla
        case (.tiwaz, .odin):
            return L10n.InterpretationForTwoRunes.Teyvaz.runeOfOdin
            
        case (.berkana, .fehu) :
            return L10n.InterpretationForTwoRunes.Berkana.fehu
        case (.berkana, .urus):
            return L10n.InterpretationForTwoRunes.Berkana.uruz
        case (.berkana, .purisaz):
            return L10n.InterpretationForTwoRunes.Berkana.turisaz
        case (.berkana, .ansuz):
            return L10n.InterpretationForTwoRunes.Berkana.ansuz
        case (.berkana, .raidu):
            return L10n.InterpretationForTwoRunes.Berkana.raido
        case (.berkana, .kauna):
            return L10n.InterpretationForTwoRunes.Berkana.kenaz
        case (.berkana, .gebu):
            return L10n.InterpretationForTwoRunes.Berkana.gebo
        case (.berkana, .wunji):
            return L10n.InterpretationForTwoRunes.Berkana.vunyo
        case (.berkana, .hagalaz):
            return L10n.InterpretationForTwoRunes.Berkana.halagaz
        case (.berkana, .naudiz):
            return L10n.InterpretationForTwoRunes.Berkana.nautiz
        case (.berkana, .isaz):
            return L10n.InterpretationForTwoRunes.Berkana.isa
        case (.berkana, .jara):
            return L10n.InterpretationForTwoRunes.Berkana.hyera
        case (.berkana, .iwas):
            return L10n.InterpretationForTwoRunes.Berkana.eyvaz
        case (.berkana, .perpu):
            return L10n.InterpretationForTwoRunes.Berkana.perth
        case (.berkana, .algis):
            return L10n.InterpretationForTwoRunes.Berkana.algiz
        case (.berkana, .sowilu):
            return L10n.InterpretationForTwoRunes.Berkana.sovilo
        case (.berkana, .tiwaz):
            return L10n.InterpretationForTwoRunes.Berkana.teyvaz
        case (.berkana, .ehwaz):
            return L10n.InterpretationForTwoRunes.Berkana.evaz
        case (.berkana, .mannaz):
            return L10n.InterpretationForTwoRunes.Berkana.mannaz
        case (.berkana, .lagus):
            return L10n.InterpretationForTwoRunes.Berkana.laguz
        case (.berkana, .inwaz):
            return L10n.InterpretationForTwoRunes.Berkana.inguz
        case (.berkana, .dagaz):
            return L10n.InterpretationForTwoRunes.Berkana.dagaz
        case (.berkana, .opila):
            return L10n.InterpretationForTwoRunes.Berkana.otilla
        case (.berkana, .odin):
            return L10n.InterpretationForTwoRunes.Berkana.runeOfOdin
        
        case (.ehwaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Evaz.fehu
        case (.ehwaz, .urus):
            return L10n.InterpretationForTwoRunes.Evaz.uruz
        case (.ehwaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Evaz.turisaz
        case (.ehwaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Evaz.ansuz
        case (.ehwaz, .raidu):
            return L10n.InterpretationForTwoRunes.Evaz.raido
        case (.ehwaz, .kauna):
            return L10n.InterpretationForTwoRunes.Evaz.kenaz
        case (.ehwaz, .gebu):
            return L10n.InterpretationForTwoRunes.Evaz.gebo
        case (.ehwaz, .wunji):
            return L10n.InterpretationForTwoRunes.Evaz.vunyo
        case (.ehwaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Evaz.halagaz
        case (.ehwaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Evaz.nautiz
        case (.ehwaz, .isaz):
            return L10n.InterpretationForTwoRunes.Evaz.isa
        case (.ehwaz, .jara):
            return L10n.InterpretationForTwoRunes.Evaz.hyera
        case (.ehwaz, .iwas):
            return L10n.InterpretationForTwoRunes.Evaz.eyvaz
        case (.ehwaz, .perpu):
            return L10n.InterpretationForTwoRunes.Evaz.perth
        case (.ehwaz, .algis):
            return L10n.InterpretationForTwoRunes.Evaz.algiz
        case (.ehwaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Evaz.sovilo
        case (.ehwaz, .berkana):
            return L10n.InterpretationForTwoRunes.Evaz.berkana
        case (.ehwaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Evaz.teyvaz
        case (.ehwaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Evaz.mannaz
        case (.ehwaz, .lagus):
            return L10n.InterpretationForTwoRunes.Evaz.laguz
        case (.ehwaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Evaz.inguz
        case (.ehwaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Evaz.dagaz
        case (.ehwaz, .opila):
            return L10n.InterpretationForTwoRunes.Evaz.otilla
        case (.ehwaz, .odin):
            return L10n.InterpretationForTwoRunes.Evaz.runeOfOdin

        case (.mannaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Mannaz.fehu
        case (.mannaz, .urus):
            return L10n.InterpretationForTwoRunes.Mannaz.uruz
        case (.mannaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Mannaz.turisaz
        case (.mannaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Mannaz.ansuz
        case (.mannaz, .raidu):
            return L10n.InterpretationForTwoRunes.Mannaz.raido
        case (.mannaz, .kauna):
            return L10n.InterpretationForTwoRunes.Mannaz.kenaz
        case (.mannaz, .gebu):
            return L10n.InterpretationForTwoRunes.Mannaz.gebo
        case (.mannaz, .wunji):
            return L10n.InterpretationForTwoRunes.Mannaz.vunyo
        case (.mannaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Mannaz.halagaz
        case (.mannaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Mannaz.nautiz
        case (.mannaz, .isaz):
            return L10n.InterpretationForTwoRunes.Mannaz.isa
        case (.mannaz, .jara):
            return L10n.InterpretationForTwoRunes.Mannaz.hyera
        case (.mannaz, .iwas):
            return L10n.InterpretationForTwoRunes.Mannaz.eyvaz
        case (.mannaz, .perpu):
            return L10n.InterpretationForTwoRunes.Mannaz.perth
        case (.mannaz, .algis):
            return L10n.InterpretationForTwoRunes.Mannaz.algiz
        case (.mannaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Mannaz.sovilo
        case (.mannaz, .berkana):
            return L10n.InterpretationForTwoRunes.Mannaz.berkana
        case (.mannaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Mannaz.teyvaz
        case (.mannaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Mannaz.evaz
        case (.mannaz, .lagus):
            return L10n.InterpretationForTwoRunes.Mannaz.laguz
        case (.mannaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Mannaz.inguz
        case (.mannaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Mannaz.dagaz
        case (.mannaz, .opila):
            return L10n.InterpretationForTwoRunes.Mannaz.otilla
        case (.mannaz, .odin):
            return L10n.InterpretationForTwoRunes.Mannaz.runeOfOdin

        case (.lagus, .fehu) :
            return L10n.InterpretationForTwoRunes.Laguz.fehu
        case (.lagus, .urus):
            return L10n.InterpretationForTwoRunes.Laguz.uruz
        case (.lagus, .purisaz):
            return L10n.InterpretationForTwoRunes.Laguz.turisaz
        case (.lagus, .ansuz):
            return L10n.InterpretationForTwoRunes.Laguz.ansuz
        case (.lagus, .raidu):
            return L10n.InterpretationForTwoRunes.Laguz.raido
        case (.lagus, .kauna):
            return L10n.InterpretationForTwoRunes.Laguz.kenaz
        case (.lagus, .gebu):
            return L10n.InterpretationForTwoRunes.Laguz.gebo
        case (.lagus, .wunji):
            return L10n.InterpretationForTwoRunes.Laguz.vunyo
        case (.lagus, .hagalaz):
            return L10n.InterpretationForTwoRunes.Laguz.halagaz
        case (.lagus, .naudiz):
            return L10n.InterpretationForTwoRunes.Laguz.nautiz
        case (.lagus, .isaz):
            return L10n.InterpretationForTwoRunes.Laguz.isa
        case (.lagus, .jara):
            return L10n.InterpretationForTwoRunes.Laguz.hyera
        case (.lagus, .iwas):
            return L10n.InterpretationForTwoRunes.Laguz.eyvaz
        case (.lagus, .perpu):
            return L10n.InterpretationForTwoRunes.Laguz.perth
        case (.lagus, .algis):
            return L10n.InterpretationForTwoRunes.Laguz.algiz
        case (.lagus, .sowilu):
            return L10n.InterpretationForTwoRunes.Laguz.sovilo
        case (.lagus, .berkana):
            return L10n.InterpretationForTwoRunes.Laguz.berkana
        case (.lagus, .tiwaz):
            return L10n.InterpretationForTwoRunes.Laguz.teyvaz
        case (.lagus, .mannaz):
            return L10n.InterpretationForTwoRunes.Laguz.mannaz
        case (.lagus, .ehwaz):
            return L10n.InterpretationForTwoRunes.Laguz.evaz
        case (.lagus, .inwaz):
            return L10n.InterpretationForTwoRunes.Laguz.inguz
        case (.lagus, .dagaz):
            return L10n.InterpretationForTwoRunes.Laguz.dagaz
        case (.lagus, .opila):
            return L10n.InterpretationForTwoRunes.Laguz.otilla
        case (.lagus, .odin):
            return L10n.InterpretationForTwoRunes.Laguz.runeOfOdin
            
        case (.inwaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Inguz.fehu
        case (.inwaz, .urus):
            return L10n.InterpretationForTwoRunes.Inguz.uruz
        case (.inwaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Inguz.turisaz
        case (.inwaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Inguz.ansuz
        case (.inwaz, .raidu):
            return L10n.InterpretationForTwoRunes.Inguz.raido
        case (.inwaz, .kauna):
            return L10n.InterpretationForTwoRunes.Inguz.kenaz
        case (.inwaz, .gebu):
            return L10n.InterpretationForTwoRunes.Inguz.gebo
        case (.inwaz, .wunji):
            return L10n.InterpretationForTwoRunes.Inguz.vunyo
        case (.inwaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Inguz.halagaz
        case (.inwaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Inguz.nautiz
        case (.inwaz, .isaz):
            return L10n.InterpretationForTwoRunes.Inguz.isa
        case (.inwaz, .jara):
            return L10n.InterpretationForTwoRunes.Inguz.hyera
        case (.inwaz, .iwas):
            return L10n.InterpretationForTwoRunes.Inguz.eyvaz
        case (.inwaz, .perpu):
            return L10n.InterpretationForTwoRunes.Inguz.perth
        case (.inwaz, .algis):
            return L10n.InterpretationForTwoRunes.Inguz.algiz
        case (.inwaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Inguz.sovilo
        case (.inwaz, .berkana):
            return L10n.InterpretationForTwoRunes.Inguz.berkana
        case (.inwaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Inguz.teyvaz
        case (.inwaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Inguz.mannaz
        case (.inwaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Inguz.evaz
        case (.inwaz, .lagus):
            return L10n.InterpretationForTwoRunes.Inguz.laguz
        case (.inwaz, .dagaz):
            return L10n.InterpretationForTwoRunes.Inguz.dagaz
        case (.inwaz, .opila):
            return L10n.InterpretationForTwoRunes.Inguz.otilla
        case (.inwaz, .odin):
            return L10n.InterpretationForTwoRunes.Inguz.runeOfOdin
            
        case (.dagaz, .fehu) :
            return L10n.InterpretationForTwoRunes.Dagaz.fehu
        case (.dagaz, .urus):
            return L10n.InterpretationForTwoRunes.Dagaz.uruz
        case (.dagaz, .purisaz):
            return L10n.InterpretationForTwoRunes.Dagaz.turisaz
        case (.dagaz, .ansuz):
            return L10n.InterpretationForTwoRunes.Dagaz.ansuz
        case (.dagaz, .raidu):
            return L10n.InterpretationForTwoRunes.Dagaz.raido
        case (.dagaz, .kauna):
            return L10n.InterpretationForTwoRunes.Dagaz.kenaz
        case (.dagaz, .gebu):
            return L10n.InterpretationForTwoRunes.Dagaz.gebo
        case (.dagaz, .wunji):
            return L10n.InterpretationForTwoRunes.Dagaz.vunyo
        case (.dagaz, .hagalaz):
            return L10n.InterpretationForTwoRunes.Dagaz.halagaz
        case (.dagaz, .naudiz):
            return L10n.InterpretationForTwoRunes.Dagaz.nautiz
        case (.dagaz, .isaz):
            return L10n.InterpretationForTwoRunes.Dagaz.isa
        case (.dagaz, .jara):
            return L10n.InterpretationForTwoRunes.Dagaz.hyera
        case (.dagaz, .iwas):
            return L10n.InterpretationForTwoRunes.Dagaz.eyvaz
        case (.dagaz, .perpu):
            return L10n.InterpretationForTwoRunes.Dagaz.perth
        case (.dagaz, .algis):
            return L10n.InterpretationForTwoRunes.Dagaz.algiz
        case (.dagaz, .sowilu):
            return L10n.InterpretationForTwoRunes.Dagaz.sovilo
        case (.dagaz, .berkana):
            return L10n.InterpretationForTwoRunes.Dagaz.berkana
        case (.dagaz, .tiwaz):
            return L10n.InterpretationForTwoRunes.Dagaz.teyvaz
        case (.dagaz, .mannaz):
            return L10n.InterpretationForTwoRunes.Dagaz.mannaz
        case (.dagaz, .ehwaz):
            return L10n.InterpretationForTwoRunes.Dagaz.evaz
        case (.dagaz, .lagus):
            return L10n.InterpretationForTwoRunes.Dagaz.laguz
        case (.dagaz, .inwaz):
            return L10n.InterpretationForTwoRunes.Dagaz.inguz
        case (.dagaz, .opila):
            return L10n.InterpretationForTwoRunes.Dagaz.otilla
        case (.dagaz, .odin):
            return L10n.InterpretationForTwoRunes.Dagaz.runeOfOdin
            
        case (.opila, .fehu) :
            return L10n.InterpretationForTwoRunes.Otilla.fehu
        case (.opila, .urus):
            return L10n.InterpretationForTwoRunes.Otilla.uruz
        case (.opila, .purisaz):
            return L10n.InterpretationForTwoRunes.Otilla.turisaz
        case (.opila, .ansuz):
            return L10n.InterpretationForTwoRunes.Otilla.ansuz
        case (.opila, .raidu):
            return L10n.InterpretationForTwoRunes.Otilla.raido
        case (.opila, .kauna):
            return L10n.InterpretationForTwoRunes.Otilla.kenaz
        case (.opila, .gebu):
            return L10n.InterpretationForTwoRunes.Otilla.gebo
        case (.opila, .wunji):
            return L10n.InterpretationForTwoRunes.Otilla.vunyo
        case (.opila, .hagalaz):
            return L10n.InterpretationForTwoRunes.Otilla.halagaz
        case (.opila, .naudiz):
            return L10n.InterpretationForTwoRunes.Otilla.nautiz
        case (.opila, .isaz):
            return L10n.InterpretationForTwoRunes.Otilla.isa
        case (.opila, .jara):
            return L10n.InterpretationForTwoRunes.Otilla.hyera
        case (.opila, .iwas):
            return L10n.InterpretationForTwoRunes.Otilla.eyvaz
        case (.opila, .perpu):
            return L10n.InterpretationForTwoRunes.Otilla.perth
        case (.opila, .algis):
            return L10n.InterpretationForTwoRunes.Otilla.algiz
        case (.opila, .sowilu):
            return L10n.InterpretationForTwoRunes.Otilla.sovilo
        case (.opila, .berkana):
            return L10n.InterpretationForTwoRunes.Otilla.berkana
        case (.opila, .tiwaz):
            return L10n.InterpretationForTwoRunes.Otilla.teyvaz
        case (.opila, .mannaz):
            return L10n.InterpretationForTwoRunes.Otilla.mannaz
        case (.opila, .ehwaz):
            return L10n.InterpretationForTwoRunes.Otilla.evaz
        case (.opila, .lagus):
            return L10n.InterpretationForTwoRunes.Otilla.laguz
        case (.opila, .inwaz):
            return L10n.InterpretationForTwoRunes.Otilla.inguz
        case (.opila, .dagaz):
            return L10n.InterpretationForTwoRunes.Otilla.dagaz
        case (.opila, .odin):
            return L10n.InterpretationForTwoRunes.Otilla.runeOfOdin

        case (.odin, .fehu) :
            return L10n.InterpretationForTwoRunes.RuneOfOdin.fehu
        case (.odin, .urus):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.uruz
        case (.odin, .purisaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.turisaz
        case (.odin, .ansuz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.ansuz
        case (.odin, .raidu):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.raido
        case (.odin, .kauna):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.kenaz
        case (.odin, .gebu):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.gebo
        case (.odin, .wunji):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.vunyo
        case (.odin, .hagalaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.halagaz
        case (.odin, .naudiz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.nautiz
        case (.odin, .isaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.isa
        case (.odin, .jara):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.hyera
        case (.odin, .iwas):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.eyvaz
        case (.odin, .perpu):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.perth
        case (.odin, .algis):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.algiz
        case (.odin, .sowilu):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.sovilo
        case (.odin, .berkana):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.berkana
        case (.odin, .tiwaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.teyvaz
        case (.odin, .mannaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.mannaz
        case (.odin, .ehwaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.evaz
        case (.odin, .lagus):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.laguz
        case (.odin, .inwaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.inguz
        case (.odin, .dagaz):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.dagaz
        case (.odin, .opila):
            return L10n.InterpretationForTwoRunes.RuneOfOdin.otilla
        default:
            return "Error"
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
            if isReversed {
                return L10n.Description.Value.Reverse.uruz
            } else {
                return L10n.Description.Value.uruz
            }
            
        case .purisaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.purisaz
            } else {
                return L10n.Description.Value.purisaz
            }
            
        case .ansuz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.ansuz
            } else {
                return L10n.Description.Value.ansuz
            }
            
        case .raidu(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.raidu
            } else {
                return L10n.Description.Value.raidu
            }
            
        case .kauna(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.kauna
            } else {
                return L10n.Description.Value.kauna
            }
            
        case .gebu:
            return L10n.Description.Value.gebu
            
        case .wunji(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.wunji
            } else {
                return L10n.Description.Value.wunji
            }
        case .hagalaz:
            return L10n.Description.Value.hagalaz
            
        case .naudiz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.naudiz
            } else {
                return L10n.Description.Value.naudiz
            }
            
        case .isaz:
            return L10n.Description.Value.isaz
            
        case .jara:
            return L10n.Description.Value.jara
            
        case .iwas:
            return L10n.Description.Value.iwaz
            
        case .perpu(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.perpu
            } else {
                return L10n.Description.Value.perpu
            }
            
        case .algis(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.algiz
            } else {
                return L10n.Description.Value.algiz
            }
            
        case .sowilu:
            return L10n.Description.Value.sowilu
            
        case .tiwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.tiwaz
            } else {
                return L10n.Description.Value.tiwaz
            }
            
        case .berkana(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.berkana
            } else {
                return L10n.Description.Value.berkana
            }
            
        case .ehwaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.ehvaz
            } else {
                return L10n.Description.Value.ehwaz
            }
            
        case .mannaz(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.mannaz
            } else {
                return L10n.Description.Value.mannaz
            }
            
        case .lagus(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.laguz
            } else {
                return L10n.Description.Value.laguz
            }
            
        case .inwaz:
            return L10n.Description.Value.inwaz
            
        case .dagaz:
            return L10n.Description.Value.dagaz
            
        case .opila(isReversed: let isReversed):
            if isReversed {
                return L10n.Description.Value.Reverse.opila
            } else {
                return L10n.Description.Value.opila
            }
            
        case .odin:
            return L10n.Description.Value.odin
        }
    }
    
    
    func configureRuneTime(runeLayout: RuneLayout, index: Int) -> String {
        var result = String()
        switch (runeLayout, index) {
        case (.dayRune, 0):
            result = ""
        case (.twoRunes, 0):
            result = String.present
        case (.twoRunes, 1):
            result = String.strength
        case (.norns, 0):
            result = String.situation
        case (.norns, 1):
            result = String.problem
        case (.norns, 2):
            result = String.solutionProblem
        case (.shortPrediction, 0):
            result = String.present
        case (.shortPrediction, 1):
            result = String.problem
        case (.shortPrediction, 2):
            result = String.solution
        case (.shortPrediction, 3):
            result = String.result
        case (.thorsHummer, 0):
            result = String.past
        case (.thorsHummer, 1):
            result = String.situationInRealTime
        case (.thorsHummer, 2):
            result = String.situationInRealTime
        case (.thorsHummer, 3):
            result = String.future
        case (.cross, 0):
            result = String.past
        case (.cross, 1):
            result = String.problem
        case (.cross, 2):
            result = String.result
        case (.cross, 3):
            result = String.help
        case (.cross, 4):
            result = String.irresistibleStrength
        case (.elementsCross, 0):
            result = String.present
        case (.elementsCross, 1):
            result = String.yuorEssence
        case (.elementsCross, 2):
            result = String.probableFuture
        case (.elementsCross, 3):
            result = String.problem
        case (.elementsCross, 4):
            result = String.ourAim
        case (.elementsCross, 5):
            result = String.difficulties
        case (.keltsCross, 0):
            result = String.stateOfAffairs
        case (.keltsCross, 1):
            result = String.past
        case (.keltsCross, 2):
            result = String.future
        case (.keltsCross, 3):
            result = String.conditions
        case (.keltsCross, 4):
            result = String.reason
        case (.keltsCross, 5):
            result = String.theBest
        case (.keltsCross, 6):
            result = String.awaitsYou
        default: break
        }
        return result
    }

}
