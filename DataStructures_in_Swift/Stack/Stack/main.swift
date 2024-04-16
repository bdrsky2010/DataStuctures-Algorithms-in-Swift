import Foundation

struct Stack<T: Equatable> {
	// 스택을 선형 형태로 저장하기 위한 저장 프로퍼티
	var stack: [T] = []
	
	// 스택의 사이즈를 계산해주는 연산 프로퍼티
	var count: Int {
		return stack.count
	}
	// 스택이 비어있는 지 참,거짓을 반환해주는 프로퍼티
	var isEmpty: Bool {
		return stack.isEmpty
	}
	
	// 스택의 모든 원소를 삭제하는 메서드
	mutating func clear() {
		stack.removeAll()
	}
	
	// 스택의 top에 값을 추가해주는 메서드
	mutating func push(_ el: T) {
		stack.append(el)
	}
	
	// 스택의 top 원소를 지우면서 값을 반환해주는 메서드
	mutating func pop() -> T? {
		return stack.popLast()
	}
	
	// 스택의 top 원소의 값을 반환해주는 메서드
	func top() -> T? {
		return stack.last
	}
}

var stack = Stack<Int>()
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)
stack.push(6)
print(stack)
print(stack.count)
print(stack.isEmpty)
print(stack.pop() ?? 0)
print(stack.top() ?? 0)
stack.clear()
print(stack.isEmpty)
