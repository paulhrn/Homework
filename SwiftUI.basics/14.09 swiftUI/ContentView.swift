//
//  ContentView.swift
//  14.09 swiftUI
//
//  Created by p h on 14.09.2022.
//

import SwiftUI

struct TrimSpaces {
    @Trimmed var trimSpaceIn: String
}

struct DateAccess {
    @GetDate var lastLoginAt: Date
}

struct CapitalizedWord {
    @Capitalized var capitalize: String
}

struct ContentView: View {
    let delete = TrimSpaces(trimSpaceIn: " I Love You ")
    let login = DateAccess(lastLoginAt: Date())
    let capitalized = CapitalizedWord(capitalize: "Hello. world")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(delete.trimSpaceIn).foregroundColor(.red)
            let _ = print(login.lastLoginAt)
            Text(capitalized.capitalize)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
