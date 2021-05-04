//
//  ContentView.swift
//  TabataNotification
//
//  Created by hato on 2021/05/03.
//

import SwiftUI

struct ContentView: View {
    enum StatusCode {
        case Ready
        case Workout
        case Interval
    }

    @State var timer : Timer!
    @State var time = 5
    @State var setCount = 0
    @State var statusText = "Ready..."
    @State var statusCode = StatusCode.Ready
    
    var body: some View {
        VStack{
            Text("Tabata Timer")
                .font(.largeTitle)
            Spacer()
            Text(statusText)
                .font(.largeTitle)
            Text(String(time))
                .font(.largeTitle)
            Spacer()
            Button(action: {
                // 変数初期化
                time = 5
                setCount = 0
                statusText = "Ready..."
                statusCode = StatusCode.Ready
                timer?.invalidate()
                
                // タイマー開始
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (tim) in
                    time -= 1
                    if time == 0 {
                        switch statusCode {
                        case .Ready:
                            statusCode = .Workout
                            statusText = "Workout"
                            time = 20
                        case .Workout:
                            setCount += 1
                            statusCode = .Interval
                            statusText = "Interval"
                            time = 10
                        case .Interval:
                            if setCount == 8 {
                                statusCode = .Ready
                                statusText = "Finish!"
                                timer?.invalidate()
                            } else {
                                statusCode = .Workout
                                statusText = "Workout"
                                time = 20
                            }
                        }
                    }
                }
                
            }) {
                Text("Start")
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
