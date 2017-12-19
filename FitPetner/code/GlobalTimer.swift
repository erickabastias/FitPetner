//
//  GlobalTimer.swift
//  Fitpetner
//
//  Created by Arnaud DELLINGER on 12/12/2017.
//  Copyright © 2017 Xenia Lin. All rights reserved.
//

import Foundation

class GlobalTimer {
    var counter: Int = 0
    var paused: Bool = false
    var timer: Timer!
    var duration: Int!
    var whenFinished: () -> Void
    var onTick: () -> Void
    
    init(duration: Int, onTick: @escaping () -> Void, whenFinished: @escaping () -> Void) {
        self.duration = duration
        self.onTick = onTick
        self.whenFinished = whenFinished
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
    }
    
    func pause() {
        self.paused = true
    }
    
    func play() {
        self.paused = false
    }
    
    @objc func tick() {
        if !self.paused {
            self.counter += 1
            self.onTick()
        }
        
        if self.counter == self.duration {
            self.timer.invalidate()
            self.whenFinished()
        }
    }
    
    func getCurrentStatus() -> String {
        // Duration = 30 * 60 = 1800 (seconds in 30min)
        // Counter = nb of seconds so far
        // Here we need to do Duration - Counter
        let remainingSeconds = self.duration - self.counter
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds - (minutes * 60)
        
        var minutesText = String(minutes)
        var secondsText = String(seconds)
        
        if minutesText.count == 1 {
            minutesText = "0" + minutesText
        }
        
        if secondsText.count == 1 {
            secondsText = "0" + secondsText
        }
        
        return minutesText + ":" + secondsText
    }
}
