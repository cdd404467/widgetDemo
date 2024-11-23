//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by caidd on 2024/11/20.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

/*** -----------     widget view   --------------**/

//小号widget view
struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Favorite Emoji:")
//            Text(entry.configuration.favoriteEmoji)
//        }
        ZStack {
            Image("small_egg_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct Egg_2_SmallView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("small_egg_2")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}


//中号widget view
struct Egg_1_MediumView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("medium_egg_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

//大号widget view
struct Egg_1_LargeView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("large_egg_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

/*** -----------     WidgetConfiguration   --------------**/

//小号组件
struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
        .configurationDisplayName("小号组件")
        .description("在APP中添加【小号】小组件，长按桌面小组件点击「编辑小组件」选择您要显示的内容.")
    }
}

struct small_egg_2Widget: Widget {
    let kind: String = "small_egg_2Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Egg_2_SmallView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
        .configurationDisplayName("小号组件")
        .description("在APP中添加【小号】小组件，长按桌面小组件点击「编辑小组件」选择您要显示的内容.")
    }
}

//中号组件
struct CddMiddleWidget: Widget {
    let kind: String = "WidgetExtension_middle"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Egg_1_MediumView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
        .configurationDisplayName("中号组件")
        .description("在APP中添加【中号】小组件，长按桌面小组件点击「编辑小组件」选择您要显示的内容.")
    }
}

//大号组件
struct CddLargeWidget: Widget {
    let kind: String = "WidgetExtension_large"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Egg_1_LargeView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemLarge])
        .contentMarginsDisabled()
        .configurationDisplayName("大号组件")
        .description("在APP中添加【大号】小组件，长按桌面小组件点击「编辑小组件」选择您要显示的内容.")
    }
}




extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
        intent.isShow = false
        intent.backgroundColor = WidgetBackgroundColor.green
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
        intent.isShow = false
        intent.backgroundColor = WidgetBackgroundColor.blue
        return intent
    }
}

//预览调试
#Preview(as: .systemLarge) {
//    WidgetExtension()
    CddLargeWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
