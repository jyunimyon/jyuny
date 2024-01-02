from telegram import ForceReply, Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes, MessageHandler, filters
import datetime

token = "6291716809:AAHd_ldXabXWJVW_6e-vczfnx8fpCrNTpY0"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE)->None:
    """/start 명령이 실행되면 메시지를 보내기"""
    user=update.effective_user
    await update.message.reply_html(
        rf"hi {user.mention_html()}! 시간을 물어보세요 😊",
        reply_markup=ForceReply(selective=True),
    )

async def help(update:Update, context:ContextTypes.DEFAULT_TYPE)-> None:
    """/help 명령이 실행되면 메시지를 보내기"""
    await update.message.reply_text("도와줄게!")

async def greeting(update:Update, context:ContextTypes.DEFAULT_TYPE)-> None:
    """/hi 명령이 실행되면 메시지를 보내기"""
    await update.message.reply_text("안녕하세요.")
       
async def get_time(update:Update, context:ContextTypes.DEFAULT_TYPE)-> None:
    """사용자가 '지금 몇시야?'라고 메시지를 보냈을 때 현재 시간을 보내기"""
    text = update.message.text
    if text == "지금 몇시야?":
        now = datetime.datetime.now()
        await update.message.reply_text(f'지금 시간은 {now.hour}시 {now.minute}분입니다.')
    else:
        await echo(update,context)

async def echo(update:Update, context:ContextTypes.DEFAULT_TYPE)-> None:
    """사용자 메시지 에코"""
    await update.message.reply_text(update.message.text)

app=ApplicationBuilder().token(token).build()

#app.add_handler(CommandHandler("명령어",실행할 함수))
app.add_handler(CommandHandler("start",start))
app.add_handler(CommandHandler("help",help))
app.add_handler(CommandHandler("hi",greeting))

#app.add_handler(MessageHandler("그냥 메세지",실행할 함수))
app.add_handler(MessageHandler(filters.TEXT&~filters.COMMAND,get_time))
app.add_handler(MessageHandler(filters.TEXT&~filters.COMMAND,echo))

app.run_polling()