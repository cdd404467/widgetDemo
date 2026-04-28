//
//  GifTestWidget.swift
//  WidgetExtensionExtension
//
//  Created by caidd on 2025/11/4.
//

import SwiftUI
import WidgetKit



struct GifEntryView_1 : View {
    var entry: SimpleEntry
//    let widgetKind: String
//    var slotNumber: String {
//        // 使用 "_" 分割字符串，取数组的最后一个元素
//        widgetKind.split(separator: "_").last.map(String.init) ?? "1"
//    }
    @Environment(\.widgetFamily) var family: WidgetFamily
    var body: some View {
        ZStack(alignment: .topLeading) {
            let name = "jweq6wsre2f6s3e4"
//            GifPlayView(name: name)
//            GifImageView(gifName: name, defaultImage: "")
            Text("组件已升级")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
//            Cdd_GifImageView(name: name)
//            Text(slotNumber)
//                            .font(.system(size: 11, weight: .bold, design: .rounded))
//                            .foregroundColor(.white)
//                            .frame(width: 18, height: 18)
//                            .background(
//                                Circle()
//                                    .fill(Color.black.opacity(0.5))
//                                    .overlay(
//                                        Circle().stroke(Color.white.opacity(0.8), lineWidth: 1)
//                                    )
//                            )
//                            // 2. 精准控制边距：左边 10，上方 10
//                            .padding(.leading, 10)
//                            .padding(.top, 10)
            VStack {
           
                Button("切换图片", intent: ConfigurationAppIntent())
                                .font(.caption)
                Spacer()
                Text(name)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 3, trailing: 0))
            }
        }
    }
}

struct GifEntryView_cdd : View {
    var entry: SimpleEntry
    let widgetKind: String
    var slotNumber: String {
        // 使用 "_" 分割字符串，取数组的最后一个元素
        widgetKind.split(separator: "_").last.map(String.init) ?? "1"
    }
    @Environment(\.widgetFamily) var family: WidgetFamily
    var body: some View {
        ZStack(alignment: .topLeading) {
            let name = "jweq6wsre2f6s3e4"
//            GifPlayView(name: name)
            GifImageView(gifName: name, defaultImage: "")
//            Cdd_GifImageView(name: name)
            Text(slotNumber)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 18, height: 18)
                            .background(
                                Circle()
                                    .fill(Color.black.opacity(0.1))
                                    .overlay(
                                        Circle().stroke(Color.white.opacity(0.8), lineWidth: 1)
                                    )
                            )
                            // 2. 精准控制边距：左边 10，上方 10
                            .padding(.leading, 10)
                            .padding(.top, 10)
            VStack {
           
//                Button("切换图片", intent: ButtonIntent(kind: widgetKind))
//                                .font(.caption)
//                Spacer()
//                Text(name)
//                    .font(.system(size: 10))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 3, trailing: 0))
            }
        }
    }
}

struct DeprecatedView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)

            VStack(spacing: 8) {
                Text("此小组件已停用")
                    .font(.headline)
                Text("请删除并添加新版本")
                    .font(.caption)
            }
        }
    }
}

struct GifWidget: Widget {
    let kind: String = "dd_clearWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            GifEntryView_1(entry: entry)
                .widgetBackground(Color.black.opacity(0))
        }
        .configurationDisplayName("（已停用）Gif Widget")
        .description("此组件已废弃，请使用新版本")
        .supportedFamilies([.systemSmall])
        
        .adoptableWidgetContentMargin()
    }
}

struct GifWidget_1: Widget {
    let kind: String = "dd_clearWidget_1"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            GifEntryView_cdd(entry: entry, widgetKind: kind)
                .widgetBackground(Color.black.opacity(0))
        }
        .configurationDisplayName("Gif-1")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
        .adoptableWidgetContentMargin()
    }
}

struct GifWidget_2: Widget {
    let kind: String = "dd_clearWidget_2"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            GifEntryView_cdd(entry: entry, widgetKind: kind)
                .widgetBackground(Color.black.opacity(0))
        }
        .configurationDisplayName("Gif-1")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
        .adoptableWidgetContentMargin()
    }
}


