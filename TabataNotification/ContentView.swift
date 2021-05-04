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
        case Finish
    }

    @State var timer : Timer!
    @State var time = 5
    @State var setCount = 0
    @State var statusText = "Ready..."
    @State var statusCode = StatusCode.Ready
    @State var isTimerMoving = false

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
            if isTimerMoving {
                Button(action: {
                    timerInit()
                }) {
                    Text("Reset")
                        .fontWeight(.bold)
                }
            } else {
                Button(action: {
                    timerInit()
                    
                    // タイマー開始
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (tim) in
                        time -= 1
                        if time == 0 {
                            switch statusCode {
                            case .Ready:
                                setStatus(targetStatus: .Workout)
                            case .Workout:
                                setCount += 1
                                setStatus(targetStatus: .Interval)
                            case .Interval:
                                if setCount == 8 {
                                    setStatus(targetStatus: .Finish)
                                    timer?.invalidate()
                                } else {
                                    setStatus(targetStatus: .Workout)
                                }
                            default:
                                print("unknown error")
                            }
                        }
                    }
                    
                }) {
                    Text("Start")
                        .fontWeight(.bold)
                }
            }
            Spacer()
        }
    }
    
    func timerInit() -> Void {
        isTimerMoving.toggle()
        setStatus(targetStatus: .Ready)
        setCount = 0
        timer?.invalidate()
    }
    
    func setStatus(targetStatus:StatusCode) -> Void {
        statusCode = targetStatus
        switch targetStatus {
        case .Ready:
            statusText = "Ready..."
            time = 5
        case .Workout:
            statusText = "Workout"
            time = 20
        case .Interval:
            statusText = "Interval"
            time = 10
        case .Finish:
            statusText = "Finish!"
            time = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
