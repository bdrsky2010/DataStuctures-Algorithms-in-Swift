import Foundation

/**
 # 기약분수
 분자 분모의 최대공약수를 구해서
 각각에 나눠준다
 */

/**
 # 최소공배수 LCM
 최소공배수 = 두 수의 곱 / 최대공약수
 */

/**
 # 유클리드 호제법
 - 두 개의 자연수에 대한 최대공약수를 구하는 알고리즘
 - 두 자연수 A, B에 대하여 (A > B) A를 B로 나눈 나머지를 R이라고 할 때
 - A와 B의 최대공약수는 B와 R의 최대 공약수와 같다
 */
func gcd(_ a: Int, _ b: Int) -> Int {
	if a % b == 0 { return b }
	return gcd(b, a % b)
}
