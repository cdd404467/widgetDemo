//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by caidd on 2024/11/20.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        markWidgetActive()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func markWidgetActive() {
            if let defaults = UserDefaults(suiteName: "group.com.cdd.widgetDemo") {
                defaults.set(true, forKey: "widget_exist")
                defaults.set(Date(), forKey: "WidgetLastActiveDate")
            }
        }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

/*** -----------     widget view   --------------**/

//小号widget view
struct WidgetExtensionEntryView : View {
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: Provider.Entry
 
        var body: some View {
            
            if renderingMode == .fullColor {
                VStack(spacing: 10) {
                    Image("lg_image")
                        .resizable()
                        .scaledToFit()

                    Text("Hello")
                        .font(.headline)
                    
                    Text(entry.date, style: .time)
                        .font(.caption)
    //                    .widgetAccentable()
                }
            }
            
            if renderingMode == .accented {
                VStack(spacing: 10) {
//                    if #available(iOS 18.0, *) {
                        Image("lg_image")
                            .resizable()
                            .applyWidgetAccented()
                            .scaledToFit()
//                    } else {
//                        // Fallback on earlier versions
//                    }
                    

                    Text("Wish Wish")
                        .font(.headline)
                    
                    Text(entry.date, style: .time)
                        .font(.caption)
                        .widgetAccentable()
                }
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

struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("CDDNB")
        }
    }
}

/*** -----------     WidgetConfiguration   --------------**/

//小号组件
struct WidgetExtension: Widget {
    let kind: String = "clearWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//            GifAnimateWidgetEntryView(entry: entry)
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(.clear, for: .widget)
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


struct WidgetSlot: AppEntity {
    let id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget位置"
    static var defaultQuery = WidgetSlotQuery()
    var displayRepresentation: DisplayRepresentation { .init(stringLiteral: "位置 \(id)") }
}

struct WidgetSlotQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [WidgetSlot] {
        identifiers.map { WidgetSlot(id: $0) }
    }
    func suggestedEntities() async throws -> [WidgetSlot] {
        (1...6).map { WidgetSlot(id: "\($0)") }
    }
    
    func defaultResult() async -> WidgetSlot? {
        WidgetSlot(id: "1")
    }
}


extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
////        intent.favoriteEmoji = "😀"
//        intent.isShow = false
//        intent.backgroundColor = WidgetBackgroundColor.green
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
////        intent.favoriteEmoji = "🤩"
//        intent.isShow = false
//        intent.backgroundColor = WidgetBackgroundColor.blue
//        return intent
//    }
}

struct NextGifIntent: AppIntent {

    static var title: LocalizedStringResource = "Next GIF"

    func perform() async throws -> some IntentResult {
        // 切换逻辑
//        let list = WidgetUtils.getGifIdList()
//        let current = WidgetUtils.getCurrentGifId()
//
//        let next = WidgetUtils.fetchNextGifId(from: current, list: list)
//        WidgetUtils.setCurrentGif(gId: next)
        
        print("pppppppp")
        // 刷新 widget
        WidgetCenter.shared.reloadTimelines(ofKind: "YourWidgetName")

        return .result()
    }
}

//预览调试
//#Preview(as: .systemLarge) {
////    WidgetExtension()
//    CddLargeWidget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
