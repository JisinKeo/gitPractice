

// <입력하는 방법> in 콘솔

// 띄어쓰기로 정수 7개 입력 + Enter를 2번 반복 후, ctrl + d
// ex) 1 5 7 2 9 13 10
//     2 3 9 10 4 8 11



const input = require('fs').readFileSync('/dev/stdin').toString().trim().split('\n');

array1 = input[0].split(' ').map(Number)
array2 = input[1].split(' ').map(Number)

console.log(`Result : ${isBigArray(array1,array2)}`)

// 배열의 요소들이 몇 개가 있는지 카운트
function count(array){
    let check = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    for (const n of array) check[n]+=1
    return check
}

// 카운트를 기반으로 집합(중복제거) 처리 
function setNums(count){
    Nums = []
    for (const i in count)
        if (count[i] > 0) Nums.push(Number(i))
    return Nums
}

// 오름차순으로 정렬
function sort(array){
    for (let i=0;i<array.length;i++){
        let min = i
        for (let j=i+1;j<array.length;j++)
            if (array[min] > array[j]) min = j
        temp = array[i]
        array[i] = array[min]
        array[min] = temp
    }
    return array
}

// [페어된 개수, 페어 수]
function pair(count){
    let [pairN, pairNum] = [0,0]
    for (const i in count)
        if (count[i]>1 && (pairN < count[i] || (pairN == count[i] && pairNum < i)))
            [pairN,pairNum] = [count[i],Number(i)]
    return [pairN,pairNum]
}


// 5개가 연속인 숫가자 있다면 [3.5, 5연속 끝 수], 아니라면 [0,0] 반환
// 5연속일 경우 우선순위가 3페어와 4페어 사이기 때문에 3.5로 지정
function fiveSeq(array){
    let [seq,N] = [0,0]
    while (array.length>4){
        let flag = true
        for (let i=1;i<5;i++)
            if (array[i] !== array[i-1]+1) flag=false
        if (flag) [seq,N] = [3.5,array[4]]
        array.splice(0,1)
    }
    return [seq,N]
}

// 각각의 배열에서 가장 큰 우선순위를 선택 후, 두 배열의 우선순위를 비교 
function isBigArray(array1,array2){
    let pair1 = pair(count(array1))
    let pair2 = pair(count(array2))
    let seq1 = fiveSeq(sort(setNums(count(array1))))
    let seq2 = fiveSeq(sort(setNums(count(array2))))
    let result1 = pair1[0]>seq1[0] ? pair1:seq1 // array1의 우선순위
    let result2 = pair2[0]>seq2[0] ? pair2:seq2 // array2의 우선순위
	
    // 두 배열 모두 페어와 5연속이 아니라면 0반환
    if (result1[0] === result2[0] && result1[1] === result2[1]) return 0
    return result1 > result2 ? 1:2
}
