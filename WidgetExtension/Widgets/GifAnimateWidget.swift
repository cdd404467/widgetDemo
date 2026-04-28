//
//  File.swift
//  WidgetExtensionExtension
//
//  Created by caidd on 2025/3/4.
//

import SwiftUI
import WidgetKit

struct GifAnimateWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    var body: some View {
//        GeometryReader { geo in
//            switch family {
//            case .systemSmall: GifPlayView(name: "model_dog1")
//            default: GifPlayView(name: "model_dog1")
//            }
//            
//        }
        let name = "jweq6wsre2f6s3e4"
        GifPlayView(name: name)
    
//        GifImageView(gifName: name, defaultImage: "")
//        Cdd_GifImageView(name: name)
    }
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("3D Model")
//                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
//                .font(.system(size: 24))
//                .foregroundColor(.white)
//                .padding(.top, -5)
//                .shadow(color: .gray, radius: 1, x: 1, y: 1)
//                .shadow(color: .gray, radius: 1, x: 2, y: 2)
//                .shadow(color: .gray, radius: 1, x: 3, y: 3)
//                .rotation3DEffect(.degrees(30),axis: (x: 1, y: 0, z: 0),anchor: .center,perspective: 0.3
//                )
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        
//        .widgetBackground(Color.black.opacity(0.15))
//        .widgetBackground(GifImageView(gifName: "model_dog1", defaultImage: "test_default"))
//        .widgetBackground(Cdd_GifImageView(name: "model_dog1"))
//        GeometryReader { geo in
//            Cdd_GifImageView(name: "model_dog1")
//            
//        }
//    }
}


struct Entry: TimelineEntry {
    var date: Date = Date()
}

struct EntryView: View {
    let entry: Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        GeometryReader { geo in
//            switch family {
//            case .systemSmall: Cdd_GifImageView(name: "model_pink")
//            default: Cdd_GifImageView(name: "model_pink")
//            }
            Cdd_GifImageView(name: "model_pink")
        }
    }
}

struct GifAnimateWidget: Widget {
    let kind: String = "dd_clearWidget_1"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            GifAnimateWidgetEntryView(entry: entry)
                .widgetBackground(Color.black.opacity(0))
        }
        .configurationDisplayName("Gif动画小组件")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
//        .adoptableWidgetContentMargin()
    }
}
