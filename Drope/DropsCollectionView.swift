import SwiftUI

struct DropsCollectionView: View {
    // App state
    @State private var searchText: String = ""
    @State private var expandedSections: Set<String> = ["ESSENTIALS"]
    @State private var elapsedTime: TimeInterval = 0
    @State private var selectedTab: Tab = .collection
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment for RTL support
    @Environment(\.layoutDirection) var layoutDirection
    
    // Localized strings based on language
    var strings: LocalizedStrings {
        layoutDirection == .rightToLeft ? arabicStrings : englishStrings
    }
    
    // Tab enum for bottom navigation
    enum Tab {
        case topics, bot, collection, profile
    }
    
    // Theme colors - Chinese traditional inspired
    var themeColors: ThemeColors {
        colorScheme == .dark ? darkThemeColors : lightThemeColors
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header section
            headerSection
            
            // Main collection content
            ScrollView {
                VStack(spacing: 16) {
                    // Categories
                    categorySection(title: strings.kangxiRadicals1, icon: expandedSections.contains(strings.kangxiRadicals1) ? "chevron.up" : "chevron.down")
                    
                    if expandedSections.contains(strings.kangxiRadicals1) {
                        radicalGrid(radicals: ["人", "大", "天", "女", "子", "小", "山", "川", "水", "火", "土", "一"])
                            .padding(.bottom, 8)
                    }
                    
                    categorySection(title: strings.kangxiRadicals2, icon: expandedSections.contains(strings.kangxiRadicals2) ? "chevron.up" : "chevron.down")
                    
                    if expandedSections.contains(strings.kangxiRadicals2) {
                        radicalGrid(radicals: ["力", "口", "囗", "土", "士", "夕", "大", "女", "子", "宀", "寸", "尸"])
                            .padding(.bottom, 8)
                    }
                    
                    // Essentials section with words
                    VStack(spacing: 0) {
                        categorySection(title: strings.essentials, icon: expandedSections.contains(strings.essentials) ? "chevron.up" : "chevron.down")
                        
                        if expandedSections.contains(strings.essentials) {
                            // Word items
                            wordItem(
                                character: "是",
                                pinyin: "shì",
                                translation: strings.yes,
                                icon: "checkmark.circle.fill",
                                progress: 0.8
                            )
                            
                            wordItem(
                                character: "不",
                                pinyin: "bù",
                                translation: strings.no,
                                icon: "xmark.circle.fill",
                                progress: 0.7
                            )
                            
                            wordItem(
                                character: "你好",
                                pinyin: "nǐ hǎo",
                                translation: strings.hi,
                                icon: "hand.wave.fill",
                                progress: 0.9
                            )
                            
                            wordItem(
                                character: "谢谢",
                                pinyin: "xièxie",
                                translation: strings.thankYou,
                                icon: "heart.fill",
                                progress: 0.6
                            )
                            
                            wordItem(
                                character: "请",
                                pinyin: "qǐng",
                                translation: "please",
                                icon: "hand.raised.fill",
                                progress: 0.5
                            )
                        }
                    }
                    
                    // Weather category
                    categorySection(title: strings.weather, icon: expandedSections.contains(strings.weather) ? "chevron.up" : "chevron.down")
                    
                    if expandedSections.contains(strings.weather) {
                        wordItem(
                            character: "雨",
                            pinyin: "yǔ",
                            translation: "rain",
                            icon: "cloud.rain.fill",
                            progress: 0.4
                        )
                        
                        wordItem(
                            character: "雪",
                            pinyin: "xuě",
                            translation: "snow",
                            icon: "snow",
                            progress: 0.3
                        )
                        
                        wordItem(
                            character: "风",
                            pinyin: "fēng",
                            translation: "wind",
                            icon: "wind",
                            progress: 0.6
                        )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            // Tab bar
            tabBar
        }
        .background(themeColors.background.ignoresSafeArea())
    }
    
    // MARK: - Components
    
    var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                // Word count with progress circle
                ZStack {
                    Circle()
                        .stroke(themeColors.progressTrack, lineWidth: 3)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.32)
                        .stroke(themeColors.accent, lineWidth: 3)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: 0) {
                        Text("98")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(themeColors.text)
                        
                        //Text(strings.words)
                            //.font(.system(size: 10))
                            //.foregroundColor(themeColors.secondaryText)
                    }
                }
                
                Spacer()
                
                // Collection title
                //Text(strings.collection)
                    //.font(.headline)
                    //.foregroundColor(themeColors.text)
                    //.fontWeight(.bold)
                
                Spacer()
                
                // Timer display
                HStack(spacing: 4) {
                    Text(formatTime(elapsedTime))
                        .foregroundColor(themeColors.text)
                        .font(.system(size: 14, weight: .medium))
                    
                    Image(systemName: "clock.fill")
                        .foregroundColor(themeColors.accent)
                        .font(.system(size: 16))
                }
                .padding(8)
                .background(themeColors.cardBackground)
                .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(themeColors.secondaryText)
                    .padding(.leading, 12)
                
                Text(strings.searchWords)
                    .foregroundColor(themeColors.secondaryText)
                
                Spacer()
            }
            .frame(height: 46)
            .background(themeColors.searchBarBackground)
            .cornerRadius(24)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
    }
    
    func categorySection(title: String, icon: String) -> some View {
        Button(action: {
            toggleSection(title)
        }) {
            HStack {
                Text(title)
                    .foregroundColor(themeColors.text)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: icon)
                    .foregroundColor(themeColors.accent)
                    .font(.system(size: 16, weight: .semibold))
            }
            .padding()
            .background(themeColors.cardBackground)
            .cornerRadius(16)
            .shadow(color: themeColors.shadow, radius: 3, x: 0, y: 2)
        }
    }
    
    func radicalGrid(radicals: [String]) -> some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 12) {
            ForEach(radicals, id: \.self) { radical in
                Button(action: {}) {
                    Text(radical)
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 60, height: 60)
                        .background(themeColors.cardBackground)
                        .foregroundColor(themeColors.text)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(themeColors.borderColor, lineWidth: 1)
                        )
                        .shadow(color: themeColors.shadow, radius: 2)
                }
            }
        }
        .padding(.horizontal, 4)
    }
    
    func wordItem(character: String, pinyin: String, translation: String, icon: String, progress: Double) -> some View {
        HStack(spacing: 16) {
            // Character circle
            ZStack {
                Circle()
                    .fill(themeColors.characterBackground)
                    .frame(width: 50, height: 50)
                
                Text(character)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(themeColors.characterText)
            }
            
            // Pronunciation and translation
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(pinyin)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(themeColors.text)
                    
                    Spacer()
                    
                    // Audio play button
                    Button(action: {}) {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(themeColors.accent)
                            .font(.system(size: 14))
                    }
                    .padding(6)
                    .background(themeColors.buttonBackground)
                    .cornerRadius(12)
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(themeColors.progressTrack)
                            .frame(height: 4)
                            .cornerRadius(2)
                        
                        Rectangle()
                            .fill(themeColors.accent)
                            .frame(width: geometry.size.width * progress, height: 4)
                            .cornerRadius(2)
                    }
                }
                .frame(height: 4)
                
                // Translation
                Text(translation)
                    .font(.system(size: 14))
                    .foregroundColor(themeColors.secondaryText)
            }
            
            Spacer()
            
            // Icon
            Image(systemName: icon)
                .foregroundColor(themeColors.iconColor)
                .font(.system(size: 22))
                .frame(width: 36, height: 36)
                .background(themeColors.iconBackground)
                .cornerRadius(10)
        }
        .padding()
        //.background(themeColors.cardBackground)
        .cornerRadius(16)
        .shadow(color: themeColors.shadow, radius: 3, x: 0, y: 2)
        .padding(.vertical, 4)
    }
    
    var tabBar: some View {
        HStack {
            tabButton(title: strings.topics, icon: "list.bullet", tab: .topics)
            tabButton(title: strings.bot, icon: "bubble.left.and.bubble.right", tab: .bot)
            tabButton(title: strings.collection, icon: "text.book.closed.fill", tab: .collection)
            tabButton(title: strings.profile, icon: "person.crop.circle", tab: .profile)
        }
        .padding(.vertical, 8)
        .background(themeColors.tabBarBackground)
    }
    
    func tabButton(title: String, icon: String, tab: Tab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(selectedTab == tab ? themeColors.accent : themeColors.inactiveTab)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? themeColors.accent : themeColors.inactiveTab)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Helper Functions
    
    func toggleSection(_ title: String) {
        if expandedSections.contains(title) {
            expandedSections.remove(title)
        } else {
            expandedSections.insert(title)
        }
    }
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Theme Colors

struct ThemeColors {
    let background: Color
    let cardBackground: Color
    let searchBarBackground: Color
    let text: Color
    let secondaryText: Color
    let accent: Color
    let iconColor: Color
    let iconBackground: Color
    let progressTrack: Color
    let characterBackground: Color
    let characterText: Color
    let tabBarBackground: Color
    let inactiveTab: Color
    let buttonBackground: Color
    let shadow: Color
    let borderColor: Color
}

// Light theme colors - Chinese traditional inspired
let lightThemeColors = ThemeColors(
    background: Color(hex: "#F7F2E9"),        // Rice paper: evokes traditional Chinese scrolls.
    cardBackground: Color.white,
    searchBarBackground: Color(hex: "#F0EBE2"), // Light cream: subtle and warm.
    text: Color(hex: "#3A3A3A"),               // Dark gray for optimal readability.
    secondaryText: Color(hex: "#6D6D6D"),      // Medium gray for less dominant info.
    accent: Color(hex: "#D2553F"),             // Chinese cinnabar: a traditional red that conveys luck.
    iconColor: Color(hex: "#D2553F"),          // Consistent use of cinnabar for visual cues.
    iconBackground: Color(hex: "#FFF5F3"),     // Very light red, softening icon emphasis.
    progressTrack: Color(hex: "#EEEEEE"),      // Neutral light gray for progress indicators.
    characterBackground: Color(hex: "#EBF2FF"), // Light blue: cool and calming for learning modules.
    characterText: Color(hex: "#1A6BBF"),      // Deep blue for clear contrast.
    tabBarBackground: Color.white,
    inactiveTab: Color(hex: "#B8B8B8"),        // Subtle gray to mark inactive elements.
    buttonBackground: Color(hex: "#F5F5F5"),   // Soft, inviting button background.
    shadow: Color.black.opacity(0.05),
    borderColor: Color(hex: "#E5E5E5")         // Light gray borders for clean separation.
)


// Dark theme colors - Chinese traditional inspired
let darkThemeColors = ThemeColors(
    background: Color(hex: "#272727"),         // Deep charcoal: reduces eye strain.
    cardBackground: Color(hex: "#353535"),     // Slightly lighter for depth.
    searchBarBackground: Color(hex: "#404040"), // Clear distinction with medium gray.
    text: Color(hex: "#F2F2F2"),               // Off-white text for high contrast.
    secondaryText: Color(hex: "#B8B8B8"),      // Consistent secondary information.
    accent: Color(hex: "#FF7D6B"),             // Lighter cinnabar for emphasis in dark mode.
    iconColor: Color(hex: "#FF7D6B"),          // Matching accent for icons.
    iconBackground: Color(hex: "#4A3F3E"),     // Dark red-gray: enriches the traditional feel.
    progressTrack: Color(hex: "#505050"),      // Medium gray to stand out without overwhelming.
    characterBackground: Color(hex: "#364352"), // Dark blue-gray: reinforces a calm learning environment.
    characterText: Color(hex: "#9DC8FF"),      // Light blue for readable contrast.
    tabBarBackground: Color(hex: "#272727"),
    inactiveTab: Color(hex: "#6D6D6D"),        // Balanced medium gray for inactive elements.
    buttonBackground: Color(hex: "#454545"),   // Consistent button styling.
    shadow: Color.black.opacity(0.15),
    borderColor: Color(hex: "#505050")         // Medium gray border to maintain structure.
)


// MARK: - Localization

struct LocalizedStrings {
    let words: String
    let wordCount: String
    let collection: String
    let searchWords: String
    let kangxiRadicals1: String
    let kangxiRadicals2: String
    let essentials: String
    let yes: String
    let no: String
    let hi: String
    let thankYou: String
    let weather: String
    let topics: String
    let bot: String
    let profile: String
}

// English strings
let englishStrings = LocalizedStrings(
    words: "Words",
    wordCount: "98",
    collection: "My List",
    searchWords: "Search words",
    kangxiRadicals1: "KANGXI RADICALS 人-一",
    kangxiRadicals2: "KANGXI RADICALS 力-车",
    essentials: "ESSENTIALS",
    yes: "yes",
    no: "no",
    hi: "hi",
    thankYou: "thank you",
    weather: "WEATHER",
    topics: "Topics",
    bot: "Bot",
    profile: "Profile"
)

// Arabic strings
let arabicStrings = LocalizedStrings(
    words: "كلمات",
    wordCount: "٩٨",
    collection: "مجموعتي",
    searchWords: "ابحث عن كلمات",
    kangxiRadicals1: "جذور كانجي 人-一",
    kangxiRadicals2: "جذور كانجي 力-车",
    essentials: "أساسيات",
    yes: "نعم",
    no: "لا",
    hi: "مرحباً",
    thankYou: "شكراً",
    weather: "الطقس",
    topics: "مواضيع",
    bot: "بوت",
    profile: "الملف الشخصي"
)

// MARK: - Helper Extensions

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview

struct DropsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // English (LTR) version
            DropsCollectionView()
                .environment(\.layoutDirection, .leftToRight)
                .previewDisplayName("English (LTR)")
            
            // Arabic (RTL) version
            DropsCollectionView()
                .environment(\.layoutDirection, .rightToLeft)
                .previewDisplayName("Arabic (RTL)")
        }
        .previewLayout(.device)
        .previewDisplayName("Auto Color Scheme")
    }
}
