## Assignment 3: Using Telegram Bot(2)
> ChatGPT 연동 실패로(429 에러), 과제 2안인 메세지 또는 명령어를 보냈을 때 답장을 받을 수 있는 코드 구현

### #1_코드 상세
- 텔레그램 봇 토큰 설정
- 답변 정의
  - `def start` : /start 명령어 실행 시 답변 정의
  - `def help` : /help 명령어 실행 시 답변 정의 
  - `def greeting` : /hi 명령어 실행 시 답변 정의 
  - `def get_time` : "지금 몇시야?" 라고 보냈을 때 현재 시각을 보내는 답변 정의
  - `def echo` : "지금 몇시야?" 이외의 모든 텍스트에 대해 똑같은 텍스트를 보내는 답변 정의
- `ApplicationBuilder`로 봇 어플리케이션 생성
- `CommandHandler`와 `MessageHandler`를 이용하여 각 명령어와 메세지에 대한 핸들러 추가
- `app.run_polling()` 으로 메세지를 주기적으로 폴링하여 새로운 메세지가 들어올 때마다 적합한 핸들러 호출

### #2_ 결과 
<img width="270" src="https://github.com/jyunimyon/2023_2_opensw_202111477_3/assets/101866554/af292675-f436-42e7-862f-801a9cd31c0b">
