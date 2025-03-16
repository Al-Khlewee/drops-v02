import SwiftUI

struct TranslationView: View {
    let exercise: TranslationExercise
    @Binding var userAnswer: String
    @Environment(\.theme) var theme
    @State private var selectedHints: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.textToTranslate).font(.title).foregroundColor(theme.textPrimary).multilineTextAlignment(.center).padding()
            TextField("Your translation", text: $userAnswer).padding().background(theme.cardPurple.opacity(0.3)).cornerRadius(8)
            Text("Hints").font(.caption).foregroundColor(theme.textSecondary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(exercise.hintWords, id: \.self) { word in
                        Button(action: {
                            if !selectedHints.contains(word) {
                                selectedHints.append(word)
                                if !userAnswer.isEmpty && !userAnswer.hasSuffix(" ") { userAnswer += " " }
                                userAnswer += word
                            }
                        }) {
                            Text(word).foregroundColor(selectedHints.contains(word) ? theme.textSecondary : theme.textPrimary)
                                .padding(.horizontal, 12).padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 16).fill(selectedHints.contains(word) ? theme.textSecondary.opacity(0.3) : theme.cardPurple.opacity(0.5)))
                        }
                    }
                }
            }
        }
    }
}