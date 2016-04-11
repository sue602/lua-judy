--
-- Author: SuYinXiang (sue602@163.com)
-- Date: 2016-03-29 17:20:07
--
local judycore = require "judy.core"
local judy = require "judy"

local myjudytest = nil
local myrettest = nil

myjudytest,myrettest = judycore.JSLI(myjudytest,"a2",10)
print("myjudytest = ",myjudytest, " ret=", myrettest )
print(" a2 == ",judycore.value(myjudytest,myrettest))
myjudytest,myrettest = judycore.JSLI(myjudytest,"a3",20)
print("2 myjudytest = ",myjudytest, " ret=", myrettest )
print(" a3 == ",judycore.value(myjudytest,myrettest))
myjudytest,myrettest = judycore.JSLI(myjudytest,"a4",30)
print("3 myjudytest = ",myjudytest, " ret=", myrettest )
print(" a4 == ",judycore.value(myjudytest,myrettest))

local testgot = judycore.JSLG(myjudytest,"a3")
print(" got a3 == ",judycore.value(myjudytest,testgot))

print(" judy 1 = ",judycore.NUMBER)
print(" judy 2 = ",judycore.STRING)
print(" judy 3 = ",judycore.ARRAY)

local innerjudytest = nil
local innerjudyret = nil
innerjudytest,innerjudyret = judycore.JSLI(innerjudytest,"b2",10)
innerjudytest,innerjudyret = judycore.JSLI(innerjudytest,"b3",myjudytest)
print("inner a2= ",judycore.JSLG(innerjudyret,"a2",judycore.NUMBER))
print("inner a3= ",judycore.JSLG(innerjudyret,"a3",judycore.NUMBER))
print("inner a4= ",judycore.JSLG(innerjudyret,"a4",judycore.NUMBER))

-- local myjudy = judycore.JudySL()
-- myjudy,_ = judycore.JSLI(myjudy,"a3",120)
-- myjudy,_ = judycore.JSLI(myjudy,"a4",130)
-- myjudy,_ = judycore.JSLI(myjudy,"a5",140)
-- myjudy,_ = judycore.JSLI(myjudy,"a6",150)
-- myjudy,_ = judycore.JSLI(myjudy,"a7","hello world")

-- print(" a5= ",judycore.JSLG(myjudy,"a5",judycore.NUMBER))
-- print(" a7= ",judycore.JSLG(myjudy,"a7",judycore.STRING))

-- judy.release(innerjudytest)


local judysl = judy.JudySL(judycore.JUDYSL)
for i=1,10 do
	judysl:JSLI(tostring(i),i*100)
end
print("judysl data[2]=",judysl:JSLG("2",judycore.NUMBER))	

local judyl = judy.JudyL(judycore.JUDYL)
for i=1,10 do
	judyl:JLI((i),i*5)
end
print("======judyl data[2]=",judyl:JLG(2,judycore.NUMBER))	
judyl:LForeach(function ( index,dd )
	print("judyl foreach dd = ",dd,index)
end,judycore.NUMBER)


for i=1,100 do
	collectgarbage("collect")
end

local function test_mem(  )
	local loopcount = 10
	local tab = {}
	local memcount1 = collectgarbage("count")
	for i=1,loopcount do
		tab[tostring(i)] = i
	end
	local memcount2 = collectgarbage("count")
	print("mem delta = ",memcount2-memcount1)

	local judyarray = judy.JudySL(judycore.JUDYSL)
	local memcount3 = collectgarbage("count")
	for i=1,loopcount do
		judyarray:JSLI(tostring(i),i)
	end
	local memcount4 = collectgarbage("count")
	print("mem delta2 = ",memcount4-memcount3)

	local t1 = os.time()
	for i=1,loopcount do			
		local d1 = tab[tostring(i)]
	end
	local t2 = os.time()
	print("time delta = ",t2-t1)

	local t3 = os.time()
	-- for i=1,loopcount do			
	-- 	local d1 = judyarray:JSLG(tostring(i),judycore.NUMBER)
	-- 	print("d1=====",d1)
	-- end
	judyarray:SLForeach(function ( dd,key )
		print("dd = ",dd,key)
	end,judycore.NUMBER)
	-- local dd,key = judyarray:JSLF("",judycore.NUMBER)
	-- print("dd = ",dd,key)
	-- while dd do
	-- 	dd,key = judyarray:JSLN(key,judycore.NUMBER)
	-- 	print("WHILE dd = ",dd,key)
	-- 	skynet.sleep(100)
	-- end

	local t4 = os.time()
	print("time delta2 = ",t4-t3)

	print("data[1234]=",tab["1234"],judyarray:JSLG("1234",judycore.NUMBER))
	judyarray = nil
	for i=1,10 do
		collectgarbage("collect")
	end
end
skynet.fork(test_mem)




----------------------------------嵌套-----------------------------------------
local myjudytest = nil
local myrettest = nil

myjudytest,myrettest = judycore.JSLI(myjudytest,"a2",10)
print("myjudytest = ",myjudytest, " ret=", myrettest )
print(" a2 == ",judycore.value(myjudytest,myrettest))
myjudytest,myrettest = judycore.JSLI(myjudytest,"a3",20)
print("2 myjudytest = ",myjudytest, " ret=", myrettest )
print(" a3 == ",judycore.value(myjudytest,myrettest))
myjudytest,myrettest = judycore.JSLI(myjudytest,"a4",30)
print("3 myjudytest = ",myjudytest, " ret=", myrettest )
print(" a4 == ",judycore.value(myjudytest,myrettest))

local testgot = judycore.JSLG(myjudytest,"a3")
print(" got a3 == ",judycore.value(myjudytest,testgot))

print(" judy 1 = ",judycore.NUMBER)
print(" judy 2 = ",judycore.STRING)
print(" judy 3 = ",judycore.ARRAY)

local innerjudytest = nil
local innerjudyret = nil
innerjudytest,innerjudyret = judycore.JSLI(innerjudytest,"b2",10)
innerjudytest,innerjudyret = judycore.JSLI(innerjudytest,"b3",myjudytest)
print("inner a2= ",judycore.JSLG(innerjudyret,"a2",judycore.NUMBER))
print("inner a3= ",judycore.JSLG(innerjudyret,"a3",judycore.NUMBER))
print("inner a4= ",judycore.JSLG(innerjudyret,"a4",judycore.NUMBER))

-- local myjudy = judycore.JudySL()
-- myjudy,_ = judycore.JSLI(myjudy,"a3",120)
-- myjudy,_ = judycore.JSLI(myjudy,"a4",130)
-- myjudy,_ = judycore.JSLI(myjudy,"a5",140)
-- myjudy,_ = judycore.JSLI(myjudy,"a6",150)
-- myjudy,_ = judycore.JSLI(myjudy,"a7","hello world")

-- print(" a5= ",judycore.JSLG(myjudy,"a5",judycore.NUMBER))
-- print(" a7= ",judycore.JSLG(myjudy,"a7",judycore.STRING))

-- judy.release(innerjudytest)


local judysl = judy.JudySL(judy.JUDYSL)
for i=1,10 do
	judysl:JSLI(tostring(i),i*100)
end
print("judysl data[2]=",judysl:JSLG("2",judy.NUMBER))	

local judyl = judy.JudyL(judy.JUDYL,false)
for i=1,10 do
	judyl:JLI((i),"jli=" .. tostring(i*5))
end
print("======judyl data[2]=",judyl:JLG(2,judy.STRING))	
judyl:LForeach(function ( index,dd )
	print("judyl foreach dd = ",dd,index)
end,judycore.STRING)
print("judy JLMU======= ",judyl:JLMU())

-- for i=1,100 do
-- 	collectgarbage("collect")
-- end

local function test_mem(  )
	local loopcount = 10
	local tab = {}
	local memcount1 = collectgarbage("count")
	for i=1,loopcount do
		tab[tostring(i)] = i
	end
	local memcount2 = collectgarbage("count")
	print("mem delta = ",memcount2-memcount1)

	local judyarray = judy.JudySL(judy.JUDYSL)
	local memcount3 = collectgarbage("count")
	for i=1,loopcount do
		judyarray:JSLI(tostring(i),i)
	end
	local memcount4 = collectgarbage("count")
	print("mem delta2 = ",memcount4-memcount3)

	local t1 = os.time()
	for i=1,loopcount do			
		local d1 = tab[tostring(i)]
	end
	local t2 = os.time()
	print("time delta = ",t2-t1)

	local t3 = os.time()
	for i=1,loopcount do			
		local d1 = judyarray:JSLG(tostring(i),judy.NUMBER)
		print("d1=====",d1)
	end

	print("object before == ",judyl:cobject())
	judyarray:JSLI(tostring(11),judyl:cobject())
	local judylobject = judyarray:JSLG(tostring(11),judy.ARRAY)
	print("object after = ",judylobject)
	local constructJudyl = judy.JudyL(judy.JUDYL,false,judylobject)
	constructJudyl:LForeach(function ( index,dd )
		print("=====>inner judyl foreach dd = ",dd,index)
	end,judy.STRING)

	-- judyarray:SLForeach(function ( dd,key )
	-- 	print("dd = ",dd,key)
	-- end,judy.NUMBER)
	-- local dd,key = judyarray:JSLF("",judy.NUMBER)
	-- print("dd = ",dd,key)
	-- while dd do
	-- 	dd,key = judyarray:JSLN(key,judy.NUMBER)
	-- 	print("WHILE dd = ",dd,key)
	-- 	skynet.sleep(100)
	-- end

	local t4 = os.time()
	print("time delta2 = ",t4-t3)

	print("data[1234]=",tab["1234"],judyarray:JSLG("1234",judy.NUMBER))
	judyarray = nil
	for i=1,10 do
		collectgarbage("collect")
	end
end
skynet.fork(test_mem)