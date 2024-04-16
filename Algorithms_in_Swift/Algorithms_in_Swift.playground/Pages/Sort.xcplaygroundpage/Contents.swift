import Foundation

// 정렬 알고리즘

/**
 # 선택 정렬
 - 처리되지 않은 데이터 중에서 가장 작은 데이터를 선택해 맨 앞에 있는 데이터와 바꾸는 것을 반복
 - 선택 정렬은 N번 만큼 가장 작은 수를 찾아서 맨 앞으로 보내야 한다
 
 # 선택 정렬의 시간 복잡도
 - 구현 방식에 따라서 사소한 오차는 있을 수 있지만, 전체 연산 횟수는 다음과 같다.
	N + (N - 1) + (N - 2) + ... + 2
 - 이는 (N^2 + N - 2) / 2 로 표현할 수 있는데, 가장 차수가 높은 것만 확인하여
 - 빅오 표기법에 따라 O(N^2)이라고 작성
 */
var arr = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8]

for i in 0..<arr.count {
	var minIndex = i
	for j in i + 1..<arr.count {
		if arr[minIndex] > arr[j] { minIndex = j }
	}
	arr.swapAt(i, minIndex)
}

print(arr)

/**
 # 삽입 정렬
 - 처리되지 않은 데이터를 하나씩 골라 적절한 위치에 삽입
 - 선택 정렬에 비해 구현 난이도가 높은 편이지만, 일반적으로 더 효율적으로 동작
 - 앞쪽에 있는 원소는 이미 정렬돼있다고 가정하고 뒤에 있는 원소를 앞쪽에 있는 원소의 위치중 하나에 넣어준다
 
 # 삽입 정렬의 시간 복잡도
 - 삽입 정렬의 시간 복잡도는  O(N^2)이며, 선택 정렬과 마찬가지로 반복문이 두 번 중첩되어 사용된다
 - 삽입 정렬은 현재 리스트의 데이터가 거의 정렬되어 있는 상태라면 매우 빠르게 동작
	- 최선의 경우 O(N)의 시간 복잡도를 가진다.
	- 이미 정렬되어 있는 상태에서 다시 삽입 정렬을 수행하면 O(N)
 */
var arr2 = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8]

for i in 0..<arr2.count {
	for j in stride(from: i, to: 0, by: -1) { // 인덱스 i부터 1까지 1씩 감소하며 반복
		if arr2[j]  < arr2[j - 1] { arr2.swapAt(j, j - 1) } // 한 칸씩 왼쪽으로 이동
		else { break } // 자기보다 작은 데이터를 만나면 그 위치에서 멈춤
	}
}
print(arr2)

/**
 # 퀵 정렬
 - 기준 데이터를 설정하고 그 기준보다 큰 데이터와 작은 데이터의 위치를 바꾸는 방법
 - 일반적인 상황에서 가장 많이 사용되는 정렬 알고리즘 중 하나
 - 병합 정렬과 더불어 대부분의 프로그래밍 언어의 정렬 라이브러리의 근간이 되는 알고리즘
 - 가장 기본적인 퀵 정렬은 첫 번째 데이터를 기준 데이터(Pivot)로 설정
 
 # 퀵 정렬의 시간 복잡도
 - 퀵 정렬은 평균의 경우 O(NlogN)의 시간 복잡도를 가진다
 - 하지만 최악의 경우 O(N^2)의 시간 복잡도를 가진다
 */
var arr3 = [5, 7, 9, 0, 3, 1, 6, 2, 4, 8]

func quickSort(arr: inout [Int], start: Int, end: Int) {
	guard start < end else { return } // 원소가 1개인 경우 종료
	let pivot = start // 피벗은 첫 번째 원소
	var left = start + 1
	var right = end
	
	while left <= right {
		// 피벗보다 큰 데이터를 찾을 때까지 반복
		while left <= end && arr[left] <= arr[pivot] { left += 1 }
		// 피벗보다 작은 데이터를 찾을 때까지 반복
		while right > start && arr[right] >= arr[pivot] { right -= 1 }
		if left > right { // 엇갈렸다면 작은 데이터와 피벗을 교채
			arr.swapAt(right, pivot)
		} else { // 엇갈리지 않았다면 작은 데이터와 큰 데이터를 교체
			arr.swapAt(left, right)
		}
	}
	// 분할 이후 왼쪽 부분과 오른쪽 부분에서 각각 정렬 수행
	quickSort(arr: &arr, start: start, end: right - 1)
	quickSort(arr: &arr, start: right + 1, end: end)
}

// 좀 더 간결하게 구현한 퀵 정렬
func quickSort(_ arr: [Int]) -> [Int] {
	guard arr.count > 1 else { return arr } // 리스트가 하나 이하의 원소만을 담고 있다면 종료
	let pivot = arr[0] // 피벗은 첫 번째 원소
	let tail = arr[1...] // 피벗을 제외한 리스트
	
	let leftSide = tail.filter { $0 <= pivot } // 분할된 왼쪽 부분
	let rightSide = tail.filter { $0 > pivot } // 분할된 오른쪽 부분
	
	// 분할 이후 왼쪽 부분과 오른쪽 부분에서 각각 정렬 수행하고, 전체 리스트 반환
	return quickSort(leftSide) + [pivot] + quickSort(rightSide)
}

//quickSort(arr: &arr, start: 0, end: arr.count - 1)
//print(arr)

/*
 대부분의 프로그래밍 언어에서 지원하는 표준 정렬 라이브러리는 최악의 경우에도 O(NlogN)을 보장하도록 설계
 측정해보면 구현한 퀵 정렬함수: 0.004248 seconds
 표준 정렬 함수: 0.000018917 seconds
 */
let clock = ContinuousClock()
let time = clock.measure {
	//실행 시간 측정할 코드
	let _ = quickSort(arr)
}
print(time)
let time2 = clock.measure {
	//실행 시간 측정할 코드
	let _ = arr.sorted()
}
print(time2)

/**
 # 계수 정렬
 - 특정한 조건이 부합할 떄만 사용할 수 있지만 매우 빠르게 동작하는 정렬 알고리즘
	- 계수 정렬은 데이터의 크기 범위가 제한되어 정수 형태로 표현할 수 있을 떄 사용 가능
 - 데이터의 개수가 N, 데이터(양수) 중 최댓값이 K일 때 최악의 경우에도 수행 시간 O(N + K)를 보장
 
 # 계수 정렬의 복잡도
 - 계수 정렬의 시간 복잡도와 공간 복잡도는 모두 O(N + K)
 - 계수 정렬은 때에 따라서 심각한 비효율성을 초래할 수 있다
	- 데이터가 0과 999,999로 단 2개만 존재하는 경우
 - 계수 정렬은 동일한 값을 가지는 데이터가 여러 개 등장할 때 효과적으로 사용할 수 있다
	- 성적의 경우 100점을 맞은 학생이 여러 명일 수 있기 때문에 계수 정렬이 효과적
 */
let arr4 = [7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2]
var countArr = Array(repeating: 0, count: arr4.max()! + 1)

arr4.forEach { countArr[$0] += 1 }
print(countArr.enumerated()
	.map { Array(repeating: $0.offset, count: $0.element) }
	.flatMap { $0 })

