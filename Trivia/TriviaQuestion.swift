//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation

struct TriviaAPIResponse: Decodable {
    let triviaQuestions: [TriviaQuestion]
    
    private enum CodingKeys: String, CodingKey {
        case triviaQuestions = "results"
    }
}

struct TriviaQuestion: Decodable { // conform to decodable protocol
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
