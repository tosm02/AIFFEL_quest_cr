import 'dart:async'; // Timer 클래스를 사용하기 위해 import

// Pomodoro 타이머를 시작하는 함수
void startPomodoroTimer() {
  int workSeconds = 25 * 60; // 25분을 초 단위로 변환
  int shortBreakSeconds = 5 * 60; // 5분을 초 단위로 변환
  int longBreakSeconds = 15 * 60; // 15분을 초 단위로 변환
  int cycles = 0; // 작업 사이클을 카운트하기 위한 변수

  // 1초마다 반복적으로 실행되는 Timer 생성
  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    if (workSeconds > 0) {
      // 작업 시간이 남아있다면
      print(
          "flutter: 남은 작업 시간: ${workSeconds ~/ 60}:${workSeconds % 60}"); // 남은 시간을 분:초 형식으로 출력
      workSeconds--; // 1초 감소
    } else {
      // 작업 시간이 끝나면
      cycles++; // 한 사이클이 끝났으므로 cycles 증가

      if (cycles % 4 == 0) {
        // 4번째 사이클일 때는 긴 휴식
        print("flutter: 작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.");
        timer.cancel(); // 현재 타이머를 중지
        startBreak(longBreakSeconds, timer); // 긴 휴식 타이머 시작
      } else {
        // 나머지 경우는 짧은 휴식
        print("flutter: 작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.");
        timer.cancel(); // 현재 타이머를 중지
        startBreak(shortBreakSeconds, timer); // 짧은 휴식 타이머 시작
      }
    }
  });
}

// 휴식 타이머를 시작하는 함수
void startBreak(int breakSeconds, Timer timer) {
  // 1초마다 반복적으로 실행되는 Timer 생성
  Timer.periodic(Duration(seconds: 1), (Timer breakTimer) {
    if (breakSeconds > 0) {
      // 휴식 시간이 남아있다면
      print(
          "flutter: ${breakSeconds ~/ 60}:${breakSeconds % 60}"); // 남은 시간을 분:초 형식으로 출력
      breakSeconds--; // 1초 감소
    } else {
      // 휴식 시간이 끝나면
      print("휴식 종료. 다시 작업을 시작합니다!");
      breakTimer.cancel(); // 휴식 타이머 중지
      startPomodoroTimer(); // 다시 작업 타이머 시작
    }
  });
}

// 프로그램 시작점
void main() {
  print("flutter: Pomodoro 타이머 시작"); // 프로그램 시작 시 메시지 출력
  startPomodoroTimer(); // Pomodoro 타이머 함수 호출
}
