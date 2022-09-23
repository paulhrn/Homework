//
//  ContentView.swift
//  SwiftUI List filtering
//
//  Created by p h on 23.09.2022.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let messageText: String
    let date: Date
    var isFavorite: Bool = false
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class ViewModel: ObservableObject {
    @Published private(set) var buttonName = "Switch messages"
    @Published var isFavorite: Bool = false
    @Published var messages: [Message] = [
        .init(messageText: "My yesterday's message", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
        .init(messageText: "This is my today's message", date: Date()),
        .init(messageText: "My message from the future", date: Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date())
    ]
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        List {
            Section("Filter") {
                FilterView()
                    .environmentObject(viewModel)
            }
            ItemView()
                .environmentObject(viewModel)
        }
    }
}

struct ItemView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.messages.contains(where: { $0.isFavorite || !viewModel.isFavorite }) {
            Section("Items") {
                ForEach($viewModel.messages, id: \.id) { $message in
                    Group {
                        if !viewModel.isFavorite || message.isFavorite {
                            Button {
                                message.isFavorite.toggle()
                            } label: {
                                Image(systemName: "message.fill")
                                    .foregroundColor(.blue)
                                Text(message.messageText)
                                Label("\(message.date, style: .date)", systemImage: "calendar").frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}

struct FilterView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        Toggle(isOn: $viewModel.isFavorite) {
            Text(viewModel.buttonName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
