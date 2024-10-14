import 'dart:async'; // Timer 사용을 위해 필요
import 'dart:developer'; // log 함수 사용을 위해 필요

void main() {
  PomodoroTimer().start(); // PomodoroTimer 객체 생성 및 타이머 시작
}

// Pomodoro 타이머 클래스 정의: 작업 시간과 휴식 시간을 관리하는 클래스
class PomodoroTimer {
  int workDuration = 25 * 60; // 25분을 초로 변환
  int shortBreak = 5 * 60; // 5분을 초로 변환
  int longBreak = 15 * 60; // 15분을 초로 변환
  int cycles = 0; // 현재 사이클 수

  Timer? timer; // nullable
  int remainingTime = 0; // 남은 시간 초기화

  // start() 메서드: 타이머의 시작점, 작업 세션 시작을 위해 _startWork() 메서드 호출
  void start() {
    log("Pomodoro 타이머를 시작합니다."); // 정보 출력
    _startWork(); // 작업 세션 시작
  }

  // _startWork() 메서드: remainingTime 설정, _startCountdown() 호출
  void _startWork() {
    remainingTime = workDuration; // 남은 시간을 작업 시간으로 설정
    log("작업 시간 시작: 25분"); // 작업 시작 시 출력
    _startCountdown(() {
      log("작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.\n"); // 작업 종료 시 출력
      cycles++; // 사이클 수 증가
      // 네 번째 작업 세션마다 _startLongBreak() 호출
      if (cycles % 4 == 0) {
        _startLongBreak(); // 긴 휴식 시작
      } else {
        _startShortBreak(); // 짧은 휴식 시작
      }
    });
  }

  // 짧은 휴식(5분) 시작, 휴식 후 자동으로 작업 세션 다시 시작
  void _startShortBreak() {
    remainingTime = shortBreak; // 남은 시간을 짧은 휴식으로 설정
    log("짧은 휴식 시간 시작: 5분\n"); // 짧은 휴식 시작 시 출력
    _startCountdown(_startWork); // 휴식 후 다시 작업 세션 시작
  }

  // 긴 휴식(15분) 시작, 휴식 후 자동으로 작업 세션 다시 시작
  void _startLongBreak() {
    remainingTime = longBreak; // 남은 시간을 긴 휴식으로 설정
    log("긴 휴식 시간 시작: 15분\n"); // 긴 휴식 시작 시 출력
    _startCountdown(_startWork); // 휴식 후 다시 작업 세션 시작
  }

  // Function onFinish을 매개변수로 하는 _startCountdown: 콜백 함수로 시간이 다 되면 호출된다
  void _startCountdown(Function onFinish) {
    timer?.cancel(); // 기존 타이머가 있으면 취소(중복 실행 방지), nullable
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--; // 매초마다 1초 줄이기

        // MM:SS 형식으로 남은 시간 계산
        final minutes = (remainingTime ~/ 60).toString().padLeft(2, '0');
        final seconds = (remainingTime % 60).toString().padLeft(2, '0');
        log("$minutes:$seconds"); // 현재 남은 시간 출력
      } else {
        // 시간이 다 되었을 때: 타이머를 취소하고, onFinish()를 호출해 다음 단계로 넘어감
        timer.cancel();
        onFinish(); // 다음 단계로 이동
      }
    });
  }
}
