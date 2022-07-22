//
//  main.swift
//  development_environment
//
//  Created by Jaehoon So on 2022/07/18.
//

import Foundation

/// 배열과 배열의 원소의 수를 인덱스로 해 카운팅 해주는 함수.
/// Parameter
///     - array: 원소의 갯수를 셀 배열
///     - numberCount: 인덱스별로 array 배열에 담겨있는 숫자의 갯수를 저장한 정수 배열
func countNumbers(array: [Int], numberCount: inout [Int]) {
    for num in array {
        numberCount[num] += 1
    }
}

/// 배열의 (최대 페어 수, 페어 숫자의 최댓값) 튜플을 반환한다
/// Parameter
///     - arrayCount: 배열별로 가지고 있는 원소의 갯수를 가지고 있는 정수 배열 ex) 2를 3개 가지고 있을 경우 arrayCount[2] = 3
/// Return
///     - (페어를 이루는 최대 갯수, 숫자의 최댓값) 튜플
func getPairSizeAndMaximumNumber(arrayCount: [Int]) -> (Int, Int) {
    var pairAndNumber = (0, 0)
    
    for i in 1...13 {
        if arrayCount[i] > pairAndNumber.0 {
            pairAndNumber.0 = arrayCount[i]
            pairAndNumber.1 = i
        } else if arrayCount[i] == pairAndNumber.0 {
            pairAndNumber.1 = i
        }
    }
    return pairAndNumber
}

/// 배열 내부에 5개 이상의 연속된 숫자를 포함하고 있는지 검사한다
/// Parameter
///     - arrayCount: 배열별로 가지고 있는 원소의 갯수를 가지고 있는 정수 배열 ex) 2를 3개 가지고 있을 경우 arrayCount[2] = 3
/// Return
///     - 연속된 규칙이 존재할 경우
///         - (true, 규칙 내 숫자 중 최댓값)
///     - 연속된 규칙이 존재하지 않을 경우
///         - (false, -1))
func isContinuousAndMaximumNumber(arrayCount: [Int]) -> (Bool, Int) {
    var countConsecutive: Int = 0
    var maxValue = 0
    // 인덱스 13부터 역으로 검사하면서 연속된 규칙의 제일 큰수가 maxValue에 저장되도록 함
    for idx in stride(from: 13, to:1, by: -1) {
        if arrayCount[idx] > 0 {
            if countConsecutive == 0 { maxValue = idx }
            countConsecutive += 1
            if countConsecutive == 5 { return (true, maxValue) }
        } else { countConsecutive = 0 }
    }
    return (false, -1)
}

/// 두개의 페어를 조건에 맞도록 비교한다.
/// Parameter
///     - pair1, pair2: pairOfArray 함수에서 얻은 (페어를 이루는 숫자의 갯수, 숫자의 최댓값) 튜플
/// Return
///     - 두 페어의 정보가 동일한 경우 0을 반환
///     - 페어의 갯수가 다른 경우
///         - 첫번째 페어가 더 많은 경우 1을 반환
///         - 두번째 페어가 더 많은 경우 0을 반환
///     - 페어의 갯수가 같은 경우
///         - 첫번째 페어가 더 큰 수로 이루어진 경우 1을 반환
///         - 두번째 페어가 더 큰수로 이루어진 경우 0을 반환
func comparePair(pair1: (Int, Int), pair2: (Int, Int)) -> Int {
    // 두 배열의 페어가 동일할 경우 0을 반환한다(명세)
    if (pair1.0 == pair2.0 && pair1.1 == pair2.1) || (pair1.0 == 1 && pair2.0 == 1) { return 0 }
    
    if pair1.0 > pair2.0 {
        return 1
    } else if pair1.0 < pair2.0 {
        return 2
    } else {
        if pair1.1 > pair2.1 { return 1 }
        else { return 2 }
    }
}

/// 두 배열 중 하나가 연속인 경우
/// - 첫번째 배열이 연속인 경우
///     - 첫번째 배열이 4개의 페어를 가지고 있다면 두 배열을 비교
///     - 첫번째 배열이 4개의 페어를 가지고 있지 않고, 두번째 배열이 4개의 페어를 가지고 있다면 2을 반환 (두번째 배열이 더 크다)
///     - 두번째 배열이 4개 페어를 가지고 있지 않다면 1을 반환(첫번째 배열이 더 크다)
/// - 두번째 배열이 연속인 경우
///     - 두번째 배열이 4개의 페어를 가지고 있다면 두 배열을 비교
///     - 두번째 배열이 4개의 페어를 가지고 있지 않고, 첫번째 배열이 4개의 페어를 가지고 있다면 0을 반환 (첫번째 배열이 더 크다)
///     - 첫번째 배열이 4개 페어를 가지고 있지 않다면 1을 반환(두번째 배열이 더 크다)
func solveOneContinuousCase(array1Con: (Bool, Int), array2Con: (Bool, Int), arr1Pair: (Int, Int), arr2Pair: (Int, Int)) -> Int {
    if array1Con.0 {
        // 첫번째 배열이 연속인 경우
        if arr1Pair.0 >= 4 { return comparePair(pair1: arr1Pair, pair2: arr2Pair) }
        else if arr2Pair.0 >= 4 { return 2 }
        else { return 1 }
    } else {
        // 두번째 배열이 연속인 경우
        if arr2Pair.0 >= 4 { return comparePair(pair1: arr1Pair, pair2: arr2Pair) }
        else if arr1Pair.0 >= 4 { return 1 }
        else { return 1 }
    }
}

/// 두 배열이 모두 연속된 규칙이 없을 경우 수행되는 함수
func solveBothNotContinuousCase(array1Con: (Bool, Int), array2Con: (Bool, Int), arr1Pair: (Int, Int), arr2Pair: (Int, Int)) -> Int {
    if arr1Pair.0 >= 4 || arr2Pair.0 >= 4 {
        return comparePair(pair1: arr1Pair, pair2: arr2Pair)
    }
    else {
        if array1Con.1 > array2Con.1 {
            return 1
        }
        else {
            return 2
        }
    }
}

/// 1. 두 배열이 모두 연속된 규칙이 있을 경우
/// 2. 하나만 연속된 규칙이 있을 경우
/// 3. 두 배열이 모두 연속된 규칙이 없을 경우
/// 세가지의 케이스로 나누어 결과를 계산하는 함수
func checkCases(isArr1Con: (Bool, Int), isArr2Con: (Bool, Int), arr1Pair: (Int, Int), arr2Pair: (Int, Int)) -> Int {
    if !isArr1Con.0 && !isArr2Con.0 {
        // 두 배열 모두 5개 이상의 연속이 없을 때
        return comparePair(pair1: arr1Pair, pair2: arr2Pair)
    } else if isArr1Con.0 && isArr2Con.0 {
        // 두 배열 모두 5개 이상의 연속이 있을 때
        return solveBothNotContinuousCase(array1Con: isArr1Con, array2Con: isArr2Con, arr1Pair: arr1Pair, arr2Pair: arr2Pair)
    } else {
        // 두 배열 중 하나만 5개 이상의 연속이 있을 때
        return solveOneContinuousCase(array1Con: isArr1Con, array2Con: isArr2Con, arr1Pair: arr1Pair, arr2Pair: arr2Pair)
    }
}
func solve(_ first: [Int], _ second: [Int]) -> Int {
    
    var numberOfArray1: [Int] = Array(repeating: 0, count: 14)
    var numberOfArray2: [Int] = Array(repeating: 0, count: 14)

    // 각 배열의 숫자를 카운팅한다.
    countNumbers(array: first, numberCount: &numberOfArray1)
    countNumbers(array: second, numberCount: &numberOfArray2)
    
    // (페어에 포함된 숫자의 갯수, 동일한 페어중 숫자의 최댓값) 의 튜플 쌍
    let pairOfArray1: (Int, Int) = getPairSizeAndMaximumNumber(arrayCount: numberOfArray1)
    let pairOfArray2: (Int, Int) = getPairSizeAndMaximumNumber(arrayCount: numberOfArray2)
    
    // (배열의 연속 규칙 여부, 연속규칙 존재시 가장 큰 수)
    let isArray1Continue: (Bool, Int) = isContinuousAndMaximumNumber(arrayCount: numberOfArray1)
    let isArray2Continue: (Bool, Int) = isContinuousAndMaximumNumber(arrayCount: numberOfArray2)
    
    // 어떤 페어나 규칙도 없을 경우 0을 반환한다.
    if pairOfArray1.0 == 0 && pairOfArray2.0 == 0 && !isArray1Continue.0 && !isArray2Continue.0 { return 0 }
    return checkCases(isArr1Con: isArray1Continue, isArr2Con: isArray2Continue, arr1Pair: pairOfArray1, arr2Pair: pairOfArray2)
}

let array1 = readLine()!.split(separator: " ").map{ Int(String($0))! }
let array2 = readLine()!.split(separator: " ").map{ Int(String($0))! }

print(solve(array1, array2))
