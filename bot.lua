local discordia = require('discordia')
local coro = require("coro-http")
local json = require("json")
local client = discordia.Client()

client:on("ready", function()
	-- client.user is the path for your bot
	print('Logged in as '.. client.user.username)
end)
function ChuckNorris(message)
	coroutine.wrap(function()
		local link = "https://api.chucknorris.io/jokes/random"
		local result, body = coro.request("GET", link)
		body = json.parse(body)
		message:reply("<@!"..message.member.id.."> "..body["value"])
	end)()
end
client:on("messageCreate", function(message)
	local content = message.content
	local member = message.member
	local memberid = message.member.id
	if content:lower() == "!chuck" then
		ChuckNorris(message)
	end
	if content:lower()=="!poulpi" then
		message:reply("Il est trop beau!")
	end
	if content:lower()=="!coucou" then
		message:reply("Zbeub")
	end
	if content:lower()=="!ping" then
		message:reply("Pong!")
	end
	if content:lower():sub(1,#"!cool")=="!cool" then
		local mentioned = message.mentionedUsers
		if #mentioned == 1 then
			message:reply("<@!"..mentioned[1][1].."> est à "..math.random(1,100).."% cool. :sunglasses:")
		elseif #mentioned==0 then
			message:reply("<@!"..memberid.."> est à "..math.random(1,100).."% cool. :sunglasses:")
		end
	end
end)


client:run('Bot Token')
