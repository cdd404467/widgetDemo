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
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "是否打开", default: false)
//    var favoriteEmoji: String
    var isShow: Bool
    
    @Parameter(title: "Color", default: WidgetBackgroundColor.blue)
        var backgroundColor: WidgetBackgroundColor
    
}
