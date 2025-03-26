//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Cheryl Chen on 3/26/25.
//

import Foundation

class TriviaQuestionService {
    static func fetchQuestions(amount: Int, completion: (([TriviaQuestion]) -> Void)? = nil) {
        let parameters = "amount=\(amount)"
        let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
        // create a data task and pass in the URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            // at this point, `data` contains the data received from the response
            // let triviaQuestions = parse(data: data)
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            // this response will be used to change the UI, so it must happen on the main thread
            DispatchQueue.main.async {
                completion?(response.triviaQuestions) // call the competion closure and pass in the TriviaQuestion data model
            }
        }
        task.resume() // resume the task and fire the request
    }
    
//    private static func parse(data: Data) -> [TriviaQuestion] {
//        // transform the data we received into a dictionary [String: Any]
//        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//        let results = jsonDictionary["results"] as! [[String: Any]]
//        var questionList: [TriviaQuestion] = []
//        for result in results {
//            let category = result["category"] as! String
//            let question = result["question"] as! String
//            let correctAnswer = result["correct_answer"] as! String
//            let incorrectAnswers = result["incorrect_answers"] as! [String]
//            let triviaQuestion = TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
//            questionList.append(triviaQuestion)
//        }
//        return questionList
//    }
}
