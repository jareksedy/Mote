//
//  MoteWidget.swift
//  MoteWidget
//
//  Created by Ярослав on 06.03.2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MoteWidgetEntryView: View {
    var entry: Provider.Entry
    var body: some View {
        ZStack {
            Color(UIColor(named: "WidgetBackground")!)
            Image("moteWatchAppWidgetIcon")
                .resizable()
                .scaledToFill()
        }
    }
}

@main
struct MoteWidget: Widget {
    let kind: String = "MoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MoteWidgetEntryView(entry: entry)
                .containerBackground(.widgetBackground, for: .widget)
        }
        .configurationDisplayName("Mote Widget")
        .description("Mote Watch App Widget")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    MoteWidget()
} timeline: {
    SimpleEntry(date: .now)
}
