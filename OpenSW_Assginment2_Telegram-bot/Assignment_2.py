import telegram
import asyncio
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from datetime import datetime

token = "6291716809:AAHd_ldXabXWJVW_6e-vczfnx8fpCrNTpY0"
bot = telegram.Bot(token = token)
text = 'Hello, Jyunimyon! My fav food is avocado.'

public_chat_name='@jyunimyon' 

async def sendMsg():
    time=datetime.now()
    hour=time.hour
    print(f"Current time:{time.strftime('%Y-%m-%d %H:%M:%S')}")
    if 6<= hour <23:
        print("every 30 minutes except 11pm~6am")
        await bot.sendMessage(chat_id = public_chat_name , text=text)

sched = AsyncIOScheduler()
sched.add_job(sendMsg, 'interval', minutes=30)
sched.start()

try:
    asyncio.get_event_loop().run_forever()
except (KeyboardInterrupt, SystemExit):
    pass
