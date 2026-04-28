//
//  Widgets+Extension.swift
//  WidgetExtensionExtension
//
//  Created by caidd on 2025/3/4.
//

import SwiftUI
import WidgetKit

extension View {
    // iOS 17.0要用containerBackground背景，否则显示不了背景
    @ViewBuilder
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOS 17.0, *) {
            containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            background(backgroundView)
        }
    }
    
    
        
}

extension Image {
    @ViewBuilder
        func applyWidgetAccented() -> some View {
            if #available(iOS 18.0, *) {
                widgetAccentedRenderingMode(.fullColor)
            } else {
                self
            }
        }
}

extension WidgetConfiguration {
    // 是否允许content margin
    func adoptableWidgetContentMargin() -> some WidgetConfiguration {
        if #available(iOSApplicationExtension 15.0, *) {
            print("15.0 以上系统")
            return contentMarginsDisabled()
        } else {
            print("15.0 以下系统")
            return self
        }
    }
}
