//
//  LocalizationManager.swift
//  Drope
//
//  Created by Hatem Al-Khlewee on 15/03/2025.
//



// MARK: - LocalizationManager.swift
import SwiftUI

struct LocalizationManager {
    let language: AppSettings.Language
    
    private let localizedStrings: [String: [String: String]] = [
        "topics": ["en": "Topics", "ar": "المواضيع"],
        "dictionary": ["en": "Dictionary", "ar": "القاموس"],
        "collection": ["en": "Collection", "ar": "المجموعة"],
        "profile": ["en": "Profile", "ar": "الملف"],
        "travelTalk": ["en": "Travel Talk", "ar": "محادثة السفر"],
        "foundation": ["en": "Foundation", "ar": "الأساسيات"],
        "foodAndDrinks": ["en": "Food & Drinks", "ar": "الطعام والمشروبات"],
        "continue": ["en": "Continue", "ar": "متابعة"],
        "essentials": ["en": "Essentials 01 - Today's Trip", "ar": "أساسيات ٠١ - رحلة اليوم"],
        "kangxiRadicals": ["en": "Kangxi Radicals", "ar": "جذور كانغشي"],
        "meetAndGreet": ["en": "Meet & Greet", "ar": "لقاء وتحية"],
        "basicProducts": ["en": "Basic\nProducts", "ar": "منتجات\nأساسية"],
        "travelPhrases": ["en": "Words and phrases for your travels", "ar": "كلمات وعبارات للاستخدام في رحلاتك"],
        "words": ["en": "98 words", "ar": "٩٨ كلمة"],
        "hello": ["en": "Hello", "ar": "مرحبا"],
        "goodbye": ["en": "Goodbye", "ar": "مع السلامة"],
        "please": ["en": "Please", "ar": "رجاء"],
        "thankYou": ["en": "Thank you", "ar": "شكرا"],
        "whereIs": ["en": "Where is...?", "ar": "أين...؟"],
        "bathroom": ["en": "bathroom", "ar": "الحمام"]
    ]
    
    func localized(_ key: String) -> String {
        localizedStrings[key]?[language.rawValue] ?? key
    }
    
    func localizedNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: language == .arabic ? "ar" : "en")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    func localizedFraction(_ numerator: Int, _ denominator: Int) -> String {
        "\(localizedNumber(numerator))/\(localizedNumber(denominator))"
    }
}