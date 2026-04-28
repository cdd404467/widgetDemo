//
//  AppIntent.swift
//  WidgetExtension
//
//  Created by caidd on 2024/11/20.
//

import WidgetKit
import AppIntents
import SwiftUI

enum WidgetBackgroundColor: String, CaseIterable, AppEnum {
    case blue = "Blue"
    case green = "Green"
    case orange = "Orange"

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Background Color"
    static var caseDisplayRepresentations: [WidgetBackgroundColor : DisplayRepresentation] = [
        .blue: "Blue",
        .green: "Green",
        .orange: "Orange"
    ]

    var color: Color {
        switch self {
            case .blue: return .blue
            case .green: return .green
            case .orange: return .orange
        }
    }
}


struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration->"
    static var description = IntentDescription("This is an example widget.")
    
//    // An example configurable parameter.
//    @Parameter(title: "是否打开", default: false)
//    var isShow: Bool
//    
//    @Parameter(title: "Color", default: WidgetBackgroundColor.blue)
//    var backgroundColor: WidgetBackgroundColor
//    @Parameter(title: "Widget Number")
//    var slot: WidgetSlot?
//    var kind: String
//    init() {}
//    init(kind: String) {
//        self.kind = kind
//    }
    public func perform() async throws -> some IntentResult {
        print("cdd tap !!")
        
        // 刷新 widget
        WidgetCenter.shared.reloadAllTimelines()
        
        return .result()
    }
}

struct ButtonIntent: AppIntent {
    static var title: LocalizedStringResource = "局部刷新"

        // 定义参数接收 kind
        @Parameter(title: "Widget Kind")
        var kind: String

        init() {}
        init(kind: String) {
            self.kind = kind
        }

        func perform() async throws -> some IntentResult {
            // 【关键点】这里就拿到了对应的 wd_1 到 wd_6
            print("准备刷新 Kind: \(kind)")
            
            // 精准刷新当前这一个，不影响其他的
            WidgetCenter.shared.reloadTimelines(ofKind: kind)
            
            return .result()
        }
}
