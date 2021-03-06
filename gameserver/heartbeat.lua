-- by: peimin@outlook.com

package.path = "lualib/?.lua;gameserver/?.lua"

local skynet	= require "skynet"
local netpack	= require "netpack"
local socket	= require "socket"
local packdeal  = require "packdeal"

local CMD = {}

function CMD.heartbeat_deal(client_fd, req_msg)
	print("hello: "..req_msg["hello"])

	local ack = {}
	ack["proto"] = "heartbeat_ack"
	ack["ret"] = 0

	packdeal.send_package(client_fd, ack)
end

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = CMD[cmd]
		f(...)
	end)
	skynet.register "heartbeat"
end)
