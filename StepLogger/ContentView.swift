import SwiftUI

struct ContentView: View {
    private let health = HealthManager()

    @State private var text = ""
    @State private var date = Date()
    @State private var message: String?
    @State private var isError = false
    @State private var isSaving = false

    private var steps: Int? {
        guard let n = Int(text.trimmingCharacters(in: .whitespaces)), n > 0, n <= 200_000 else { return nil }
        return n
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Steps to add") {
                    TextField("e.g. 2500", text: $text)
                        .keyboardType(.numberPad)
                    DatePicker("Ending at", selection: $date, in: ...Date())
                }
                Section {
                    Button(action: save) {
                        if isSaving {
                            ProgressView().frame(maxWidth: .infinity)
                        } else {
                            Text("Add to Health").frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(steps == nil || isSaving)
                }
                if let message {
                    Section {
                        Text(message).foregroundColor(isError ? .red : .green)
                    }
                }
            }
            .navigationTitle("Step Logger")
        }
        .navigationViewStyle(.stack)
    }

    private func save() {
        guard let steps else { return }
        guard health.isAvailable else {
            show("Health data is not available on this device.", error: true)
            return
        }
        isSaving = true
        Task {
            do {
                try await health.addSteps(steps, endingAt: date)
                text = ""
                date = Date()
                show("Added \(steps) steps to Health.", error: false)
            } catch {
                show(error.localizedDescription, error: true)
            }
            isSaving = false
        }
    }

    private func show(_ msg: String, error: Bool) {
        message = msg
        isError = error
    }
}
