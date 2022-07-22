//
//  solution.swift
//  BoostCamp
//
//  Created by  sangyeon on 2022/07/18.
//

var arr1: [Int] = []
var arr2: [Int] = []

func InputArray() -> [Int] {
    
    // 여러 정수를 입력받아 int Array로 리턴
    let input = readLine()
    var arr: [Int] = []
    
    if let input = input {
        arr = input.split(separator: " ").map{ Int(String($0))! }
    }
    
    return arr
}

func doComparison(){
    
    // order의 경우, 1: 2-pair, 2: 3-pair, 3: 다섯 숫자 연속, 4: 4-pair
    let order1 = findOrder(arr1)
    let order2 = findOrder(arr2)

    if order1.order > order2.order { print(1) }
    else if order1.order < order2.order { print(2) }
    else {  // order가 같다면 숫자를 비교
        if order1.order == 0 { print(0) }
        else if order1.number > order2.number { print(1) }
        else if order1.number < order2.number { print(2) }
        else { print(0) }
    }
    
}

func Solution(){
    
    // int array 입력 받기
    arr1 = InputArray()
    arr2 = InputArray()
    
    // array 정렬
    arr1.sort()
    arr2.sort()

    // array 비교 후 결과 출력
    doComparison()
 
}
