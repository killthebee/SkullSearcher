func makeLookingNumberText(_ num: Int?) -> String? {
    guard let num = num else { return nil }
    var text = "Сейчас"
    if num > 2 {
        text = text + " " + "просматривают"
    } else {
        text = text + " " + "просматриваeт"
    }
    text = text + " " + String(num)
    let digits = Array(String(num))
    let lastDigit = digits[digits.count - 1]
    
    if num > 10 && num < 20 {
        text = text + " " + "человек"
        
        return text
    }
    
    let ekDigits: Set<Character> = ["1", "5", "6", "7", "8", "9", "0"]
    if ekDigits.contains(lastDigit) {
        text = text + " " + "человек"
    } else {
        text = text + " " + "человека"
    }
    return text
}

func makePublishedData(_ dateString: String) -> String {
    var text = "Опубликованно"
    let dateArray = Array(dateString)
    if dateArray[8] == "0" {
        text = text + " " + String(dateArray[9])
    } else {
        text = text + " " + String(dateArray[8]) + String(dateArray[9])
    }
    if dateArray[6] == "1" && dateArray[5] == "0" {
        text = text + " " + "января"
    } else if dateArray[6] == "2" && dateArray[5] == "0"{
        text = text + " " + "февраля"
    } else if dateArray[6] == "3" {
        text = text + " " + "марта"
    } else if dateArray[6] == "4" {
        text = text + " " + "апреля"
    } else if dateArray[6] == "5" {
        text = text + " " + "мая"
    } else if dateArray[6] == "6" {
        text = text + " " + "июня"
    } else if dateArray[6] == "7" {
        text = text + " " + "июля"
    } else if dateArray[6] == "8" {
        text = text + " " + "августа"
    } else if dateArray[6] == "9" {
        text = text + " " + "сентября"
    } else if dateArray[6] == "0" {
        text = text + " " + "октября"
    } else if dateArray[6] == "1" {
        text = text + " " + "ноября"
    } else if dateArray[6] == "2" {
        text = text + " " + "декабря"
    }
    
    return text
}

func makeFullAddress(_ address: Adress) -> String {
    let result = "\(address.town), \(address.street), \(address.house),"
    
    return result
}

func makeExpText(_ exp: Experience) -> String {
    if exp.text == "не требуется" {
        return "Опыт не требуется"
    }
    let expArr = Array(exp.text)
    let minExp = expArr[0]
    let maxExp = expArr[2]
    
    return "Требуемый опыт: от \(minExp) до \(maxExp) лет"
}

func makeAppliedText(_ num: Int?) -> String {
    guard let num = num else { return "Будь первыйм кто откликнулся"}
    if num == 1 {
        return "1 человек уже\nоткликнулся"
    }
    return "\(num) человек уже\nоткликнулись"
}
