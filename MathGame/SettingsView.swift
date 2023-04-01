//
//  SettingsView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-20.
//

import SwiftUI

enum CustomColor: String, CaseIterable, Identifiable {
    case Sapphire, Ruby, Emerald
    var id: Self { self }
}

struct SettingsView: View {
    
    @AppStorage ("fontSize") private var fontSize: Double = 25.00
    @AppStorage ("selectedColor") private var selectedColor: String = CustomColor.Emerald.rawValue
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Font Size (\(String(format: "%.1f", fontSize))px)")
                    Slider(
                        value: $fontSize,
                        in: 14.00...30.00
                    ).tint(Color(selectedColor))
                }
                .padding([.top, .leading])
                .padding(.trailing, 30.0)
                
                HStack {
                    Text("System Color").bold().padding(.leading)
                    Picker("Edge", selection: $selectedColor) {
                        Text("Sapphire").tag(CustomColor.Sapphire.rawValue)
                        Text("Ruby").tag(CustomColor.Ruby.rawValue)
                        Text("Emerald").tag(CustomColor.Emerald.rawValue)
                    }
                    .padding(.trailing)
                    .pickerStyle(.wheel)
                    Color(selectedColor).frame(width: 30.0, height: 30.0).padding(.trailing)
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
