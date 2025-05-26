import Foundation

extension Date {
    func addingTimeInterval(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Date {
        let secondsInDay = Double(days) * 24 * 60 * 60
        let secondsInHour = Double(hours) * 60 * 60
        let secondsInMinute = Double(minutes) * 60
        return self.addingTimeInterval(secondsInDay + secondsInHour + secondsInMinute)
    }
}
