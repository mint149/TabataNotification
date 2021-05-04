//
//  ContentView.swift
//  TabataNotification
//
//  Created by hato on 2021/05/03.
//

import SwiftUI

struct ContentView: View {
    @State var timer : Timer!
    @State var time = 5
    
    var body: some View {
        VStack{
            Text("\(time)")
            Button(action: {
                time = 5
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (tim) in
                    time -= 1
                    if time == 0 {
                        timer?.invalidate()
                    }
                }
                
            }) {
                Text("Start")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
