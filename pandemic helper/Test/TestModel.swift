//
//  TestModel.swift
//  test_h
//
//  Created by Mac-HOME on 04.05.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation

class TestModel {
    // Questions to indentify availability
    let indentQuestions = [
        "Хорошо ли вы себя чувствуете?",
        "Есть ли у вас хотя бы один из перечисленных симптомов: \n\n температура | тошнота | понос | озноб | слабость | потеря аппетита | боль в мышцах",
        "У вас есть одышка или затруднения с дыханием?",
        "У вас наблюдается кашель?",
        "У вас есть лихорадка?",
        "Сделайте глубокий вдох и задержите дыхание более чем на 10 секунд. \n\n Ошущаете ли вы боль в грудной клетке?"
    ]
    // weight of answer yes: min - -3 / max - 3
    let indentQuestionsWeight = [1, 2, 3, 4, 5, 5]
    
    // Questions to estimate riscs
    let riskQuestions = [
        "Вам больше 60 лет?",
        "Часто ли вам приходится находиться в оживлённых местах?",
        "Есть ли у вас астма?",
        "Есть ли у вас диабет?",
        "Есть ли у вас другие хронические заболевания?",
        "Вы общались с теми, у кого был потдверждён диагноз, за последние 14 дней?",
        "Если вы выходите на улицу, вы надеваете маску, соблюдаете дистанцию?",
        "Вы часто болели ОРВИ в течение последнего года?"
    ]
    // weight of answer yes: min - -5 / max - 5
    let riskQuestionsWeight = [5, 2, 4, 4, 2, 5, 1, 1]
    
    // Indentity test answers
    let positiveIndentAnswer = "У вас нет подозрений на наличие COVID-19"
    let negativeIndentAnswer = "У вас имеются подозрения на наличие COVID-19"
    
    // Risc test answers
    let positiveRiscAnswer = "Основываясь на ваших ответах, вы не находитесь в зоне риска"
    let negativeRiscAnswer = "Основываясь на ваших ответах, вы находитесь в зоне риска"
    
    // Warnings for indentification test
    let warning1 = "Лихорадка - наиболее распространенный симптом коронавирусной инфекции. Рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    let warning2 = "Кашель - второй по распространенности симптом коронавирусной инфекции. Рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    let warning3 = "Кашель и боль в грудной клетке при задержке дыхания с высокой долей вероятности указывает на наличие болезни. Пройдите консультацию у врача\n"
    let asking = "Это очень важно! Пожалуйста, ограничьте круг общения и звоните на горячую линию\n(тел. 103)\n"
    
    // Warnings for risc test
    let warning4 = "У людей с астмой с большей вероятностью может развиться тяжёлая форма болезни. При появлении первых симптомов рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    let warning5 = "У людей с диабетом с большей вероятностью может развиться тяжёлая форма болезни. При появлении первых симптомов рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    let warning6 = "У пожилых людей с большей вероятностью может развиться тяжёлая форма болезни. Берегите себя! При появлении первых симптомов рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    
    // Recomendations and instructions
    let recommendation = "Если у вас появятся симптомы, пройдите тест ещё раз или обратитесь к врачу\n"
    let wish = "Будьте осторожны! При появлении первых симптомов рекомендуем позвонить на горячую линию\n(тел. 103)\n"
    let instruction = "При появлении первых симптомов рекомендуем позвонить на горячую линию\n(тел. 103)\n"
   
    // Advertisments
    let advertisment = "Вам необходимо проконсультироваться с врачом по поводу вашего хронического заболевания\n\n"
    
    let a = ""
    
    var questions : [String]
    var weight: [Int]
    var questionInd : Int
    var weightScore: Int
    var positiveAnswer : String
    var negativeAnswer : String
    var isIndentTest: Bool
    var isUserNeedAdv : Bool
    var isUserNeedWarning1 : Bool
    var isUserNeedWarning2 : Bool
    var isUserNeedWarning3 : Bool
    var isUserNeedWarning4 : Bool
    var isUserNeedWarning5 : Bool
    var isUserNeedWarning6 : Bool
    
    init() {
        questionInd = 0
        weightScore = 0
        questions = []
        weight = []
        positiveAnswer = ""
        negativeAnswer = ""
        isIndentTest = false
        isUserNeedAdv = false
        isUserNeedWarning1 = false
        isUserNeedWarning2 = false
        isUserNeedWarning3 = false
        isUserNeedWarning4 = false
        isUserNeedWarning5 = false
        isUserNeedWarning6 = false
    }
    
    func startIndentTest() {
        reset()
        questions = indentQuestions
        weight = indentQuestionsWeight
        positiveAnswer = positiveIndentAnswer
        negativeAnswer = negativeIndentAnswer
        isIndentTest = true
    }
    
    func startRiskTest() {
        reset()
        questions = riskQuestions
        weight = riskQuestionsWeight
        positiveAnswer = positiveRiscAnswer
        negativeAnswer = negativeRiscAnswer
        isIndentTest = false
    }
    
    func getCurQuestion() -> String {
        return questions[questionInd]
    }
    
    func nextQuestion() {
        questionInd += 1
    }
    
    func answerYes() {
        if questionInd == 1 {
            isUserNeedWarning6 = true
        } else if questionInd == 3 {
            isUserNeedWarning4 = true
        } else if questionInd == 4 {
            isUserNeedAdv = true
            isUserNeedWarning2 = true
            isUserNeedWarning5 = true
        } else if questionInd == 5 {
            isUserNeedWarning1 = true
        } else if questionInd == 6 {
            isUserNeedWarning3 = true
        }
        weightScore += weight[questionInd - 1]
    }
    
    func getProgress() -> Float {
        return Float(questionInd) / Float(questions.count)
    }
    
    func isPositiveAnswer() -> Bool {
        return weightScore < 5
    }
    
    func getAnswer() -> String {
        return isPositiveAnswer() ? positiveAnswer : negativeAnswer
    }
    
    // Get more detailed result
    func getDiscription() -> String {
        var description : String
        if isPositiveAnswer() {
            // Positive answers
            if isIndentTest {
                description = recommendation
            } else {
                if (isUserNeedAdv) {
                    description = advertisment
                } else {
                    description = instruction
                }
            }
        } else {
            // Negative answers
            if isIndentTest {
                if (isUserNeedWarning1) {
                    description = warning1
                } else if (isUserNeedWarning2) {
                    description = warning2
                } else if (isUserNeedWarning3) {
                    description = warning3
                } else {
                    description = asking
                }
            } else {
                if (isUserNeedWarning4) {
                    description = warning4
                } else if (isUserNeedWarning5) {
                    description = warning5
                } else if (isUserNeedWarning6) {
                    description = warning6
                } else {
                    description = wish
                }
            }
        }
        
        return description
    }
    
    func getWarning() -> String {
        return "Пожалуйста, оставайтесь дома. Не подвергайте риску себя и окружающих.\n"
    }
    
    func reset() {
        questionInd = 0
        weightScore = 0
        isUserNeedAdv = false
        isUserNeedWarning1 = false
        isUserNeedWarning2 = false
        isUserNeedWarning3 = false
        isUserNeedWarning4 = false
        isUserNeedWarning5 = false
        isUserNeedWarning6 = false
    }
}
