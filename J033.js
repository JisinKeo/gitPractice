/*자바스크립트가 처음이라 입력값 입력을 어느 방식으로 구현해야 하는지
익숙하지 않아 하드코딩으로 진행하였습니다!
입력 방식을 꼭 공부해오겠습니다.
맨 밑에 제시된 테스트케이스를 정리해놓았습니다. 주석 하나씩 풀어 실행하면 vscode에서 결과가 나옵니다.*/
arr1_check = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
arr2_check = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
let two_temp1 = 0;
let two_temp2 = 0;
let three_temp1 = 0;
let three_temp2 = 0;
let four_temp1 = 0;
let four_temp2 = 0;
let cont_temp1 = 0;
let cont_temp2 = 0;
let check_temp1 = 0;
let check_temp2 = 0;

function reset_Variable() {
  for (let i = 0; i < arr1_check.length; i++) {
    arr1_check[i] = 0;
  }
  for (let i = 0; i < arr2_check.length; i++) {
    arr2_check[i] = 0;
  }
  two_temp1 = 0;
  two_temp2 = 0;
  three_temp1 = 0;
  three_temp2 = 0;
  four_temp1 = 0;
  four_temp2 = 0;
  cont_temp1 = 0;
  cont_temp2 = 0;
  check_temp1 = 0;
  check_temp2 = 0;
}

//기본 함수
function solution(arr1, arr2) {
  reset_Variable();
  for (let x of arr1) arr1_check[x] += 1;
  for (let x of arr2) arr2_check[x] += 1;
  if (noPair(arr1, arr2) == 0) return 0;
  for (let x of arr1_check) {
    if (x != 1 || x != 0) {
      if (solution2(arr1, arr2) == 1) return 1;
      else return 2;
    }
  }
  for (let x of arr2_check) {
    if (x != 1 || x != 0) {
      if (solution2(arr1, arr2) == 1) return 1;
      else return 2;
    }
  }
}

//배열 모두 페어가 없거나 규칙이 없는지 검사하는 함수
function noPair(arr1, arr2) {
  for (let i = 0; i < arr1_check.length - 2; i++) {
    if (arr1_check[i] >= 2) return 1;
    if (arr1_check[i] >= 1) check_temp1 += 1;
    else check_temp1 = 0;
    if (check_temp1 == 5) {
      check_temp1 = 0;
      return 1;
    }
    if (arr2_check[i] >= 2) return 1;
    if (arr2_check[i] >= 1) check_temp2 += 1;
    else check_temp2 = 0;
    if (check_temp2 == 5) {
      check_temp2 = 0;
      return 1;
    }
  }
  return 0;
}

//하나 이상의 배열에 페어가 포함된 경우
function solution2(arr1, arr2) {
  conti(arr1, arr2);
  twothreefour_check(arr1, arr2);
  if (four_temp1 < four_temp2) return 2;
  if (four_temp1 > four_temp2) return 1;
  if (cont_temp1 > cont_temp2) return 1;
  if (cont_temp1 < cont_temp2) return 2;
  if (three_temp1 < three_temp2) return 2;
  if (three_temp1 > three_temp2) return 1;
  if (two_temp1 < two_temp2) return 2;
  else return 1;
}

// 연속된 숫자 5개가 있는지 검사하는 함수
function conti(arr1, arr2) {
  for (let i = 0; i < arr1_check.length; i++) {
    if (arr1_check[i] >= 1) check_temp1 += 1;
    else check_temp1 = 0;
    if (check_temp1 == 5) {
      cont_temp1 = 1;
      break;
    }
  }
  for (let i = 0; i < arr2_check.length; i++) {
    if (arr2_check[i] >= 1) check_temp2 += 1;
    else check_temp2 = 0;
    if (check_temp2 == 5) {
      cont_temp2 = 1;
      break;
    }
  }
}

// arr1_check(Or arr2_check) 함수를 반복문으로 순환하면서 페어가 있는지 검사하는 함수
function twothreefour_check(arr1, arr2) {
  for (let i = 0; i < arr1_check.length; i++) {
    if (arr1_check[i] == 2) two_temp1 = i;
    if (arr2_check[i] == 2) two_temp2 = i;
    if (arr1_check[i] == 3) three_temp1 = i;
    if (arr2_check[i] == 3) three_temp2 = i;
    if (arr1_check[i] == 4) four_temp1 = i;
    if (arr2_check[i] == 4) four_temp2 = i;
  }
}

arr1 = [1, 5, 7, 2, 9, 13, 10];
arr2 = [2, 3, 9, 10, 4, 8, 11];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));



arr1 = [1, 4, 1, 3, 5, 6, 10];
arr2 = [9, 2, 3, 1, 3, 4, 10];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));


arr1 = [1, 1, 9, 4, 1, 3, 11];
arr2 = [2, 3, 3, 13, 12, 9, 9];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));


arr1 = [1, 4, 9, 4, 1, 10, 13];
arr2 = [11, 13, 9, 3, 1, 9, 1];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));

arr1 = [1, 3, 5, 4, 2, 10, 4];
arr2 = [11, 13, 11, 3, 11, 9, 1];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));


arr1 = [1, 1, 4, 4, 1, 1, 9];
arr2 = [1, 2, 11, 3, 11, 4, 5];
console.log("arr1 : [" + arr1 + "]");
console.log("arr2 : [" + arr2 + "]");
console.log(solution(arr1, arr2));