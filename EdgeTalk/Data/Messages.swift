//
//  Messages.swift
//  EdgeTalk
//
//  Created by Michal Ukropec on 15/05/2025.
//

import Foundation

struct NegotiationPlan: Decodable {
    let importantInformation: String
    let setup: Setup
    let dealDesign: DealDesign
    let tactics: Tactics

    enum CodingKeys: String, CodingKey {
        case importantInformation = "important_information"
        case setup
        case dealDesign = "deal_design"
        case tactics
    }
}

struct Setup: Decodable {
    let environment: String
    let participants: [String]
}

struct DealDesign: Decodable {
    let terms: [String]
    let objectives: [String]
}

struct Tactics: Decodable {
    let approaches: [String]
    let counterStrategies: [String]

    enum CodingKeys: String, CodingKey {
        case approaches
        case counterStrategies = "counter_strategies"
    }
}

let json = """
    {
      "important_information": "You aim to negotiate a €12,000 fee for a 3-month website redesign project with a mid-sized tech company. Their previous payment to another agency was €3,500, indicating their historical price expectations. You believe your work is significantly higher quality and worth more, and you want to avoid lowering your price while designing a deal that appeals to them.",
      "setup": {
        "environment": "Negotiation will likely occur in a professional setting, possibly a virtual meeting or in-person at their office, given the nature of consulting engagements.",
        "participants": [
          "You (consultant)",
          "Decision makers from the mid-sized tech company, likely including a project manager, marketing lead, and a financial approver"
        ]
      },
      "deal_design": {
        "terms": [
          "Project scope covering complete website redesign over 3 months",
          "Fee of €12,000 fixed or phased payments",
          "Delivery milestones and timelines",
          "Quality standards and post-launch support",
          "Potential value-added services or bonuses"
        ],
        "objectives": [
          "Secure the €12,000 fee without discounting",
          "Clearly communicate the superior quality and value compared to prior agency",
          "Structure the deal to make the investment feel justified and strategic for the company"
        ]
      },
      "tactics": {
        "approaches": [
          "Use value-based selling emphasizing ROI and superior outcomes",
          "Explore their underlying needs and past dissatisfaction or limitations with previous agency",
          "Propose phased deliverables with milestones to demonstrate ongoing value",
          "Ask insightful questions to uncover constraints and decision criteria"
        ],
        "counter_strategies": [
          "They might push back referencing their previous €3,500 payment as a benchmark",
          "They could challenge the higher price without clear justification",
          "Ask for scope reduction or additional discounts"
        ]
      }
    }
    """

func getPlan() -> NegotiationPlan {
    let data = json.data(using: .utf8)!
    return try! JSONDecoder().decode(NegotiationPlan.self, from: data)
}
