import HealthKit

final class HealthManager {
    private let store = HKHealthStore()
    private let stepType = HKQuantityType(.stepCount)

    var isAvailable: Bool { HKHealthStore.isHealthDataAvailable() }

    func requestAuthorization() async throws {
        try await store.requestAuthorization(toShare: [stepType], read: [])
    }

    func addSteps(_ count: Int, endingAt end: Date) async throws {
        let status = store.authorizationStatus(for: stepType)
        if status == .notDetermined {
            try await requestAuthorization()
        }
        if store.authorizationStatus(for: stepType) == .sharingDenied {
            throw HealthError.denied
        }
        // Spread the steps over a short window ending at the chosen time.
        let start = end.addingTimeInterval(-60)
        let sample = HKQuantitySample(
            type: stepType,
            quantity: HKQuantity(unit: .count(), doubleValue: Double(count)),
            start: start,
            end: end
        )
        try await store.save(sample)
    }
}

enum HealthError: LocalizedError {
    case denied

    var errorDescription: String? {
        "Step writing is turned off.  Open Settings > Health > Data Access & Devices > Step Logger and allow Steps."
    }
}
