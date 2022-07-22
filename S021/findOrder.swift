//
//  findOrder.swift
//  BoostCamp
//
//  Created by  sangyeon on 2022/07/18.
//

var curPairOrder: Int = 0                                   // 1: 2-pair, 2: 3-pair, 3: 4-pair
var maxPairOrder: (order: Int, number: Int) = (0, 0)        // (pair order, 페어 숫자)를 저장
var cont: Int = 0                                           // 연속된 숫자의 개수
var continuousNum: Int = 0                                  // 연속된 숫자들 중 첫번째 수
var prev: Int = 0                                           // 이전 숫자


func initVariables(){
    
    // 사용할 변수 초기화
    curPairOrder = 0
    maxPairOrder = (0, 0)
    cont = 1
    continuousNum = 0
    prev = 0
}

func checkPair(_ cur: Int){
    
    if prev == cur {
        curPairOrder += 1
        if maxPairOrder.order <= curPairOrder { maxPairOrder = (curPairOrder, prev) }
    } else { curPairOrder = 0 }
    
}

func checkContinuous(_ cur: Int){
    
    if prev == cur {return}
    
    if (prev+1) == cur {
        cont += 1
        if cont >= 5 { continuousNum = cur - 4 }
    } else { cont = 1 }
    
}

func findOrder(_ arr: [Int]) -> (order: Int, number: Int) {
    
    initVariables()
    
    for cur in arr {
        checkPair(cur)
        checkContinuous(cur)
        prev = cur
    }
    
    if maxPairOrder.order == 3 { return (4, maxPairOrder.number) }      // 4-pair인 경우
    else if continuousNum != 0 { return (3, continuousNum) }            // 다섯 숫자가 연속으로 나오는 경우
    else { return (maxPairOrder.order, maxPairOrder.number) }           // 2-pair, 3-pair 혹은 아무것도 해당하지 않는 경우
    
}
