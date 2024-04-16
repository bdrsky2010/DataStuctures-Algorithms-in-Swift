import Foundation

/**
 # 그리디 알고리즘(탐욕)
 - 현재 상황에서 지금 당장 좋은 것만 고르는 방법
 - 특정한 문제를 만났을 때  단순히 현재 상황에서 가장 좋아보이는 것만을 선택해도 문제를 풀 수 있는지를 파악할 수 있어야 한다.
 - 좋은 것을 선택하는 알고리즘이므로 문제에서 '가장 큰 순서대로', '가장 작은 순서대로' 와 같은 기준을 알게 모르게 제시해준다.
 */

// 거스름돈
// 가장 큰 화폐 단위부터 돈을 거슬러 주는 것
func change(money: Int) -> Int {
	var result: Int = 0
	var money: Int = money
	let moneyBox: [Int] = [500, 100, 50, 10]
	moneyBox.forEach {
		result += $0 * (money / $0)
		money %= $0
	}
	return result
}

change(money: 1260)

// 큰 수의 법칙
func maxSum(method: String, input: String) -> Int {
	let method: [Int] = method.components(separatedBy: " ").map { Int($0)! }
	let input: [Int] = input.components(separatedBy: " ").map { Int($0)! }.sorted(by: >)
	print(input)
	let (N, K) = (method[0], method[2])
	var M = method[1]
	let (first, second) = (input[0], input[1])
	var result: Int = 0
	while true {
		for _ in 0..<K {
			if M == 0 {
				break
			}
			result += first
			M -= 1
		}
		
		if M == 0 {
			break
		}
		result += second
		M -= 1
	}
	
	return result
}

maxSum(method: "5 8 3", input: "2 4 5 4 6")
