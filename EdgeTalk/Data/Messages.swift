//
//  Messages.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 15/05/2025.
//

import Foundation

struct NegotiationGuidance: Decodable {
    let clarifyValue: QA
    let setup: QA
    let dealDesign: SuggestionAdvice
    let tactics: SuggestionAdvice
    let warning: Warning

    enum CodingKeys: String, CodingKey {
        case clarifyValue = "clarify_value"
        case setup = "3d_setup"
        case dealDesign = "deal_design"
        case tactics
        case warning
    }
}

struct QA: Decodable {
    let question: String
    let advice: String
}

struct SuggestionAdvice: Decodable {
    let suggestion: String
    let advice: String
}

struct Warning: Decodable {
    let note: String
    let caution: String
}

let json = """
    {
        "clarify_value": {
          "question": "Can you specify what makes your work world-class compared to the past agency? For example, unique expertise, faster delivery, superior design, or guaranteed ROI?",
          "advice": "Clearly articulate the unique benefits and outcomes you bring that justify the higher price."
        },
        "3d_setup": {
          "question": "What do you know about the company's current challenges or goals related to the website? Have you researched their business situation?",
          "advice": "Use setup phase to uncover their real needs, constraints, and decision-making criteria before the meeting."
        },
        "deal_design": {
          "suggestion": "Consider adding value beyond just redesign, such as performance tracking, training, or phased payment tied to milestones to align incentives.",
          "advice": "Package your offer to address their hidden interests and risk concerns without lowering your headline price."
        },
        "tactics": {
          "suggestion": "Ask open-ended questions like 'What didn't the previous agency deliver that you'd like to see?' or 'What outcomes are most critical for you in this project?'",
          "advice": "Frame your price as an investment with clear returns, and be ready to explain why a low price might cost more in the long run."
        },
        "warning": {
          "note": "Avoid directly comparing your price to the €3,500 past payment as an inferior baseline; instead, emphasize the gap in quality and impact to justify your figure.",
          "caution": "Don't rush to concessions; listen carefully to signals that reveal their priorities or budget constraints first."
        }
    }
    """

func getGuidance() -> NegotiationGuidance {
    let data = json.data(using: .utf8)!
    return try! JSONDecoder().decode(NegotiationGuidance.self, from: data)
}
