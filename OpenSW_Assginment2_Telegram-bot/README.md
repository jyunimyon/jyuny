## Assignment 2: Using Telegram Bot(1)

### #1_ 코드 상세
- 텔레그램 봇 생성, 채널 아이디 설정
- `def sendMsg` : 30분에 한 번씩 채팅 보내기
    - 현재 시각 출력
    - 오후 11시부터 오전 6시까지를 제외하고, 채널로 메세지 전송
- 비동기 스케줄러로 30분마다 `sendMsg` 함수 실행되도록 스케줄링
- 키보드 입력 전까지 프로그램 계속 실행

> APScheduler는 기본적으로 동기로 작동하지만, AsyncIOScheduler를 사용함으로써 비동기적으로 동작하게 하였다. 따라서 **🎉asyncio 이벤트 루프와 함께 sendMsg 함수를 비동기적으로 실행🎉**할 수 있다.

### #2_ 결과
11시 이후부터 `every 30 minutes except 11pm~6am` 출력이 나타나지 않고 있다. 하지만 30분에 한 번씩 타임 스탬프가 찍히고 있다. <br><br>
<img width="340" alt="image" src="https://github.com/jyunimyon/2023_2_opensw_202111477_2/assets/101866554/98c0c38c-d9b9-49ef-b023-1773ef6cbea2"><br><br> 
또한 jyunimyon_chnl로 30분에 한 번씩 지정한 텍스트가 오는 것을 볼 수 있다 <br><br>
<img width="300" src="https://github.com/jyunimyon/2023_2_opensw_202111477_2/assets/101866554/fe318cf1-8f8e-481c-8bfe-6dcf5f08040e">
<img width="300" src="https://github.com/jyunimyon/2023_2_opensw_202111477_2/assets/101866554/af7ba482-2531-47d0-b267-79a61e673288">
