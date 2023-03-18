module("extensions.huai", package.seeall)

extension = sgs.Package("huai")
-- for var=1,13,1 do
--     local shits = sgs.Sanguosha:cloneCard("slash",sgs.Card_Diamond,var)
--     shits:setParent(extension)
-- end
dabusi = sgs.General(extension, "dabusi", "god", "7")
dummy = sgs.General(extension1, "dummy", "god", "100")
idle = sgs.CreatePhaseChangeSkill{
    name = "idle",
    frequency = sgs.Skill_Compulsory,
	on_phasechange = function(self, target)
        local room = target:getRoom()
        room:throwEvent(sgs.TurnBroken)
        target:drawCards(1)
    end
}
dummy:addSkill(idle)
--界徐�?
jiexusheng = sgs.General(extension, "jiexusheng", "wu")
jiexushengPojun = sgs.CreateTriggerSkill{
    name = "jiexushengPojun",
    events = {sgs.TargetConfirmed,sgs.DamageCaused,sgs.EventPhaseChanging},
    -- if frequent, then dont ask for fadong
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.TargetConfirmed then
            if not (player:isAlive() and player:hasSkill(self:objectName())) then return end
            local use = data:toCardUse()
            local player = use.from
            if use.card:isKindOf("Slash") and player:hasSkill(self:objectName()) then
                sgs.Sanguosha:playSkillAudioEffect("jiexushengPojun",2)
                for i = 0, use.to:length()-1 do
                    local to = use.to:at(i)
                    for j = 0, to:getHp()-1 do
                        if to:isNude() then break end
                        if player:getPhase() == sgs.Player_Play or room:askForSkillInvoke(player, self:objectName(), data) then
                            local id = room:askForCardChosen(player, to, "he", self:objectName())
                            to:addToPile("pojun", id, false)
                        else break end
                    end
                end
            end
        end
        if event == sgs.DamageCaused then
            local damage = data:toDamage()
            if not (player:isAlive() and player:hasSkill(self:objectName())) then return end
            local player = damage.from
            if damage.chain or damage.transfer or (not damage.by_user) then return false end
            local reason = damage.card
            if reason and reason:isKindOf("Slash") and player:hasSkill(self:objectName()) 
                and damage.to:getHandcardNum()<=player:getHandcardNum() and damage.to:getEquips():length()<=player:getEquips():length()
                and (player:getPhase() == sgs.Player_Play or room:askForSkillInvoke(player, self:objectName(), data)) then
                local msg = sgs.LogMessage()
                msg.type = "#jiexushengPojunDamage"
                msg.from = damage.from
                msg.to:append(damage.to)
                room:sendLog(msg)
                damage.damage = damage.damage + 1
                data:setValue(damage)
                sgs.Sanguosha:playSkillAudioEffect("jiexushengPojun",1)
            end
            return false
        end
        if event == sgs.EventPhaseChanging then
            if data:toPhaseChange().to == sgs.Player_Finish then
                local room = player:getRoom()
                local all_players = room:getAllPlayers()
                for _, p in sgs.qlist(all_players) do
                    local pile = p:getPile("pojun")
                    for i=0, pile:length()-1 do
                        local card = pile:at(i)
                        room:obtainCard(p,card,false)
                    end
                end
            end
            return false
        end
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
jiexusheng:addSkill(jiexushengPojun)

caojinyu = sgs.General(extension, "caojinyu", "wei", "3", false)
Yuqi = sgs.CreateTriggerSkill{
    name = "Yuqi",
    events = {sgs.Damaged, sgs.GameStart, sgs.EventPhaseChanging},
    frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
        if event == sgs.GameStart and player:hasSkill(self:objectName()) then
            -- pt(player:getRoom(), "YuqiInit")
            for _, player in sgs.qlist(player:getRoom():getAllPlayers()) do
                if player:hasSkill(self:objectName()) then
                    player:gainMark("@Yuqi2",3)
                    player:gainMark("@Yuqi3",1)
                    player:gainMark("@Yuqi4",1)
                    break
                end
            end
            return
        end
        if event == sgs.EventPhaseChanging then
            if data:toPhaseChange().to == sgs.Player_Finish then
                local room = player:getRoom()
                local all_players = room:getAllPlayers()
                for _, p in sgs.qlist(all_players) do
                    p:loseAllMarks("@Yuqi6")
                end
            end
            return
        end
        if event ~= sgs.Damaged then return end
        local room = player:getRoom()
        local damage = data:toDamage()
        for _, caojinyu in sgs.qlist(room:getAllPlayers()) do
            if not caojinyu or caojinyu:isDead() or not caojinyu:hasSkill(self:objectName()) or caojinyu:getMark("@Yuqi6")>=2 then else
            if caojinyu:distanceTo(damage.to) <= caojinyu:getMark("@Yuqi1") and room:askForSkillInvoke(caojinyu, self:objectName(), data) then
                caojinyu:gainMark("@Yuqi6",1)
                sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
                local card_ids = room:getNCards(caojinyu:getMark("@Yuqi2"))
                caojinyu:addToPile("Yuqi", card_ids)
                -- for _,id in sgs.qlist(card_ids) do caojinyu:addToPile("Yuqi", id) end
                room:fillAG(card_ids)
                pile = caojinyu:getPile("Yuqi")
                caojinyu:setTag("yuqigive", sgs.QVariant("give"))
                caojinyu:setTag("yuqigiveto", data)
                caojinyu:setTag("yuqirefusable", sgs.QVariant(0))
                -- self.y1 = 5 一定不要这样写，无法赋�?
                for i=1, caojinyu:getMark("@Yuqi3") do
                    local card_id = room:askForAG(caojinyu, card_ids, caojinyu:getTag("yuqirefusable"):toInt()==1, self:objectName())
                    caojinyu:setTag("yuqirefusable", sgs.QVariant(1))
                    if card_id == -1 then break end
                    room:clearAG()
                    card_ids:removeOne(card_id)
                    if damage.to:isAlive() then room:obtainCard(damage.to, card_id) end
                    room:fillAG(card_ids)
                    if card_ids:isEmpty() then break end
                end
                caojinyu:setTag("yuqigive", sgs.QVariant("notgive"))
                if card_ids:isEmpty() then 
                    room:clearAG()
                    return false 
                end
                room:getThread():delay()
                for i=1, caojinyu:getMark("@Yuqi4") do
                    local card_id = room:askForAG(caojinyu, card_ids, true, self:objectName())
                    if card_id == -1 then break end
                    room:clearAG()
                    card_ids:removeOne(card_id)
                    room:obtainCard(caojinyu, card_id)
                    room:fillAG(card_ids)
                    if card_ids:isEmpty() then break end
                end
                local move = sgs.CardsMoveStruct()
                move.to_place = sgs.Player_DrawPile
                for i=card_ids:length()-1,0,-1 do
                    move.card_ids:append(card_ids:at(i))
                end
                room:moveCardsAtomic(move, true)
				-- room:returnToTopDrawPile(card_ids)
                room:clearAG()
            end
            end
        end
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end,
}
Shanshen = sgs.CreateTriggerSkill{
    name = "Shanshen",
	events = {sgs.Death,sgs.Damage},
    frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.Death then
            local all_players = room:getAllPlayers()
            local death = data:toDeath()
            for _, caojinyu in sgs.qlist(all_players) do
                if not caojinyu or not caojinyu:isAlive() or not caojinyu:hasSkill(self:objectName()) then else
                local choice = room:askForChoice(caojinyu, self:objectName(), "yuqirange+yuqiget+yuqigive+yuqitake")
                -- self.player = caojinyu
                -- caojinyu:drawCards(10)
                if choice == "yuqirange" then
                    caojinyu:gainMark("@Yuqi1",2)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),1)
                    while caojinyu:getMark("@Yuqi1") > 5 do caojinyu:loseMark("@Yuqi1") end
                elseif choice == "yuqiget" then
                    caojinyu:gainMark("@Yuqi2",2)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),2)
                    while caojinyu:getMark("@Yuqi2") > 5 do caojinyu:loseMark("@Yuqi2") end
                elseif choice == "yuqigive" then
                    caojinyu:gainMark("@Yuqi3",2)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),1)
                    while caojinyu:getMark("@Yuqi3") > 5 do caojinyu:loseMark("@Yuqi3") end
                elseif choice == "yuqitake" then
                    caojinyu:gainMark("@Yuqi4",2)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),2)
                    while caojinyu:getMark("@Yuqi4") > 5 do caojinyu:loseMark("@Yuqi4") end
                end
                if death.who:getMark("@Yuqi5") == 0 then
                    local recover = sgs.RecoverStruct()
                    recover.who = caojinyu
                    recover.recover = 1
                    room:recover(caojinyu, recover)
                end
                end
            end
        end
        if event == sgs.Damage then
            local damage = data:toDamage()
            if not damage.to:isAlive() or not damage.from:hasSkill(self:objectName()) then return end
            if damage.to:getMark("@Yuqi5")==0 then damage.to:gainMark("@Yuqi5",1) end
        end    
    end,
}
Xianjing = sgs.CreatePhaseChangeSkill{
    name = "Xianjing",
    frequency = sgs.Skill_Frequent,
	on_phasechange = function(self, caojinyu)
        if caojinyu:getPhase() == sgs.Player_Start then
            local room = caojinyu:getRoom()
            sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
            local choice = room:askForChoice(caojinyu, self:objectName(), "yuqirange+yuqiget+yuqigive+yuqitake")
            if choice == "yuqirange" then
                caojinyu:gainMark("@Yuqi1")
                while caojinyu:getMark("@Yuqi1") > 5 do caojinyu:loseMark("@Yuqi1") end
            elseif choice == "yuqiget" then
                caojinyu:gainMark("@Yuqi2")
                while caojinyu:getMark("@Yuqi2") > 5 do caojinyu:loseMark("@Yuqi2") end
            elseif choice == "yuqigive" then
                caojinyu:gainMark("@Yuqi3")
                while caojinyu:getMark("@Yuqi3") > 5 do caojinyu:loseMark("@Yuqi3") end
            elseif choice == "yuqitake" then
                caojinyu:gainMark("@Yuqi4")
                while caojinyu:getMark("@Yuqi4") > 5 do caojinyu:loseMark("@Yuqi4") end
            end
            if not caojinyu:isWounded() then
                local choice = room:askForChoice(caojinyu, self:objectName(), "yuqirange+yuqiget+yuqigive+yuqitake")
                if choice == "yuqirange" then
                    caojinyu:gainMark("@Yuqi1")
                    while caojinyu:getMark("@Yuqi1") > 5 do caojinyu:loseMark("@Yuqi1") end
                elseif choice == "yuqiget" then
                    caojinyu:gainMark("@Yuqi2")
                    while caojinyu:getMark("@Yuqi2") > 5 do caojinyu:loseMark("@Yuqi2") end
                elseif choice == "yuqigive" then
                    caojinyu:gainMark("@Yuqi3")
                    while caojinyu:getMark("@Yuqi3") > 5 do caojinyu:loseMark("@Yuqi3") end
                elseif choice == "yuqitake" then
                    caojinyu:gainMark("@Yuqi4")
                    while caojinyu:getMark("@Yuqi4") > 5 do caojinyu:loseMark("@Yuqi4") end
                end
            end
        end
    end,
}
caojinyu:addSkill(Yuqi)
caojinyu:addSkill(Shanshen)
caojinyu:addSkill(Xianjing)

shendiaochan = sgs.General(extension, "shendiaochan", "god", "3", false)
function toTagPlayer(room, tag)
    local all_players = room:getAllPlayers(true)
    local liege
    for _, p in sgs.qlist(all_players) do
        if p:getTag(tag):toInt() == 1 then liege = p end
    end
    return liege
end
DimengCard = function(room, a,b)
    a:setFlags("DimengTarget")
    b:setFlags("DimengTarget")
    local exchangeMove = sgs.CardsMoveList()
    local move1 = sgs.CardsMoveStruct(a:handCards(), b, sgs.Player_PlaceHand, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, a:objectName(), b:objectName(), "dimeng", ""))
    local move2 = sgs.CardsMoveStruct(b:handCards(), a, sgs.Player_PlaceHand, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, b:objectName(), a:objectName(), "dimeng", ""))
    exchangeMove:append(move1)
    exchangeMove:append(move2)
    room:moveCardsAtomic(exchangeMove, false)
    local exchangeMovej = sgs.CardsMoveList()
    
    -- local msg = sgs.LogMessage()
    -- msg.type = sgs.QVariant(sgs.Player_PlaceDelayedTrick):toString().."hhhh"--:toString()
    -- room:sendLog(msg)
    local ag, bg = sgs.IntList(), sgs.IntList()
    for _,c in sgs.qlist(a:getJudgingArea()) do ag:append(c:getEffectiveId()) end
    for _,c in sgs.qlist(b:getJudgingArea()) do bg:append(c:getEffectiveId()) end
    local move1j = sgs.CardsMoveStruct(ag, b, sgs.Player_PlaceDelayedTrick, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, a:objectName(), b:objectName(), "dimeng", ""))
    local move2j = sgs.CardsMoveStruct(bg, a, sgs.Player_PlaceDelayedTrick, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, b:objectName(), a:objectName(), "dimeng", ""))
    exchangeMovej:append(move1j)
    exchangeMovej:append(move2j)
    room:moveCardsAtomic(exchangeMovej, false)
    pt(room, "startpile")
    local p1, p2 = a:getPileNames(), b:getPileNames()
    local use1, use2 = {},{}
    for _,pile in sgs.list(p1) do if not a:getPile(pile):isEmpty() then table.insert(use1, pile) end end
    for _,pile in sgs.list(p2) do if not b:getPile(pile):isEmpty() then table.insert(use2, pile) end end
    for _,pile in ipairs(use1) do b:addToPile(pile, a:getPile(pile)) end
    for _,pile in ipairs(use2) do a:addToPile(pile, b:getPile(pile)) end
    pt(room, "endpile")
    a:setFlags("-DimengTarget")
    b:setFlags("-DimengTarget")
end
GanluCard = function(first, second)
	local room = first:getRoom()
	local equips1, equips2 = sgs.IntList(), sgs.IntList()
    local e1 = first:getEquips()
    local e2 = second:getEquips()
	for i=0, e1:length()-1 do equips1:append(e1:at(i):getEffectiveId()) end
	for i=0, e2:length()-1 do equips2:append(e2:at(i):getEffectiveId()) end
	local exchangeMove = sgs.CardsMoveList()
	local move1 = sgs.CardsMoveStruct(equips1, second, sgs.Player_PlaceEquip, 
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, first:objectName(), second:objectName(), "LuaGanlu", ""))
	local move2 = sgs.CardsMoveStruct(equips2, first, sgs.Player_PlaceEquip,
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, first:objectName(), second:objectName(), "LuaGanlu", ""))
	exchangeMove:append(move2)
	exchangeMove:append(move1)
	room:moveCardsAtomic(exchangeMove, false)
end
MarkCard = function(first, second)
    local aName = first:getMarkNames()
    local bName = second:getMarkNames()
    local aNum = sgs.IntList()
    for i=1, #aName do
        local name = aName[i]
        aNum:append(first:getMark(name))
        -- if first:getMark(name) > 0 then first:loseAllMarks(name) end
    end
    local bNum = sgs.IntList()
    for i=1, #bName do
        local name = bName[i]
        bNum:append(second:getMark(name))
        -- if second:getMark(name) > 0 then second:loseAllMarks(name) end
    end
    for i=1, #aName do
        for j=1, #bName do
            if aName[i] ~= bName[j] or aNum:at(i-1) == bNum:at(j-1) then else
            second:gainMark(aName[i], aNum:at(i-1)-bNum:at(j-1))
            first:gainMark(aName[i], bNum:at(j-1)-aNum:at(i-1))
            end
        end
    end
    for i=1, #aName do
        if not table.contains(bName, aName[i]) and aNum:at(i-1) > 0 then
            second:gainMark(aName[i], aNum:at(i-1))
            first:gainMark(aName[i], -aNum:at(i-1))
        end
    end
    for j=1, #bName do
        if not table.contains(aName, bName[j]) and bNum:at(j-1) > 0 then
            second:gainMark(bName[j], -bNum:at(j-1))
            first:gainMark(bName[j], bNum:at(j-1))
        end
    end
    -- for i=1, #aName do
    --     if aNum:at(i-1) > 0 then second:gainMark(aName[i], aNum:at(i-1)) end
    -- end
    -- for i=1, #bName do
    --     if bNum:at(i-1) > 0 then first:gainMark(bName[i], bNum:at(i-1)) end
    -- end
end

LuaJijiangCard = sgs.CreateSkillCard{
	name = "LuaJijiangCard" ,
	filter = function(self, targets, to_select)
        local room = self:getRoom()
		local slash = sgs.Sanguosha:cloneCard(room:getTag("MeiCard"), sgs.Card_NoSuit, 0)
		room:setPlayerCardLimitation(self.player, "use,response", ".|.|.|hand", true)
		local plist = sgs.PlayerList()
		for i = 1, #targets, 1 do
			plist:append(targets[i])
		end
        return slash:targetFilter(plist, to_select, sgs.Self)
	end ,
}
hasShuGenerals = function(player)
	for _, p in sgs.qlist(player:getSiblings()) do
		if p:isAlive() and (p:getMark("Meihuo")==1) then
			return true
		end
	end
	return false
end
LuaJijiangVS = sgs.CreateViewAsSkill{
	name = "LuaJijiang" ,
	n = 0 ,
	view_as = function()
		return LuaJijiangCard:clone()
	end ,
	-- enabled_at_play = function(self, player)
	-- 	return hasShuGenerals(player)
	-- 	   and (not player:hasFlag("Global_LuaJijiangFailed"))
	-- 	   and sgs.Slash_IsAvailable(player)
	-- end ,
	-- enabled_at_response = function(self, player, pattern)
	-- 	return hasShuGenerals(player)
	-- 	   and ((pattern == "slash") or (pattern == "@jijiang"))
	-- 	   and (sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE_USE)
	-- 	   and (not player:hasFlag("Global_LuaJijiangFailed"))
	-- end
}
LuaJijiang = sgs.CreateTriggerSkill{
	name = "LuaJijiang" ,
	events = {sgs.CardAsked} ,
    frequency = sgs.Skill_Compulsory,
	view_as_skill = LuaJijiangVS ,
	on_trigger = function(self, event, player, data)
        if player:getTag("Meihuoing"):toInt() ~= 1 then return false end
		local room = player:getRoom()
		local pattern = data:toStringList()[1]
		local prompt = data:toStringList()[2]
		-- if (pattern ~= "slash") then return false end
        local liege = toTagPlayer(room, "Meihuo")
        local cards = SelectCard(liege, player, pattern)
        if cards then
            local uselist = sgs.IntList()
            for _, c in ipairs(cards) do uselist:append(tonumber(c)) end
            local move = sgs.CardsMoveStruct()
            move.to_place = sgs.Player_DiscardPile
            move.card_ids = uselist
            room:moveCardsAtomic(move, true)
            room:removePlayerCardLimitation(player, "use,response", ".|.|.|hand$1")
            room:provide(sgs.Sanguosha:cloneCard(pattern))
            -- else room:provide(slash) end
            room:setTag("MeiCard", sgs.QVariant(pattern))
        end
        if slash then return true end
        return false
	end ,
}
LuaGuidao = sgs.CreateTriggerSkill{
	name = "#LuaGuidao" ,
	events = {sgs.AskForRetrial} ,
    frequency = sgs.Skill_Compulsory,
	can_trigger = function(self, target)
        if not target:getTag("Meihuoing"):toInt() == 1 then return false end
		if not (target and target:isAlive() and (target:hasSkill("guidao") or target:hasSkill("guicai"))) then return false end
		if target:isKongcheng() then
            if target:hasSkill("guidao") then return false end
			local has_black = false
			for i = 0, 3, 1 do
				local equip = target:getEquip(i)
				if equip and equip:isBlack() then
					has_black = true
					break
				end
			end
			return has_black
		else
			return true
		end
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local judge = data:toJudge()
		local prompt_list = {
			"@guidao-card" ,
			judge.who:objectName() ,
			self:objectName() ,
			judge.reason ,
			tostring(judge.card:getEffectiveId())
		}
		local prompt = table.concat(prompt_list, ":")
        local pattern
        if player:hasSkill("guicai") then pattern = ".|."
        elseif player:hasSkill("guidao") then pattern = ".|black" end
        local cardlist = sgs.IntList()
        local cards = player:getHandcards()
        local equips = player:getEquips()
        -- player:drawCards(3)
        for _,c in sgs.qlist(cards) do cardlist:append(c:getEffectiveId()) end
        if player:hasSkill("guidao") then
            for _,c in sgs.qlist(equips) do cardlist:append(c:getEffectiveId()) end
        end
        local disablelist = sgs.IntList()
        for _,c in sgs.qlist(cardlist) do
            if player:hasSkill("guidao") and sgs.Sanguosha:getCard(c):isRed() then
                disablelist:append(c)
            end
        end
        local liege = toTagPlayer(room ,"Meihuo")
        if not liege then return false end
        room:fillAG(cardlist, liege, disablelist)
        local card = room:askForAG(liege, cardlist, true, self:objectName())
        room:clearAG()
        card = sgs.Sanguosha:getCard(card)
		-- local card = room:askForCard(liege, pattern, prompt, data, sgs.Card_MethodResponse, judge.who, true)
		if card then
			room:retrial(card, player, judge, self:objectName(), player:hasSkill("guidao"))
		end
		return false
	end
}
shendiaochan:addSkill(LuaGuidao)
--[[
LuaLeiji = sgs.CreateTriggerSkill{
	name = "#LuaLeiji" ,
	events = {sgs.CardResponded} ,
    frequency = sgs.Skill_Compulsory,
	on_trigger = function(self, event, player, data)
        if player:getTag("Meihuoing"):toInt() ~= 1 then return false end
        local room = player:getRoom()
        room:setPlayerCardLimitation(player, "use,response", ".|.|.|hand", true)
        return false
	end
}]]
GetPeach = sgs.CreateTriggerSkill{
    name = "#GetPeach",
    events = {sgs.AskForPeaches},
    frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local liege = toTagPlayer(room, "Meihuoing")
        if room:askForSkillInvoke(player, "GetPeach", data) then
        local card = AskMaster(self, player, "Peach")
        -- player:drawCards(3)
        -- local msg = sgs.LogMessage()
        -- msg.type = liege:getGeneralName()
        -- room:sendLog(msg)
        if card then
            local origin = player:getTag("Kanpo"):toString():split("+")
            local uselist = sgs.IntList()
            for _, c in ipairs(origin) do uselist:append(tonumber(c)) end
            player:removeTag("Kanpo")
            local move = sgs.CardsMoveStruct()
            move.to_place = sgs.Player_DiscardPile
            move.card_ids = uselist
            room:moveCardsAtomic(move, true)
            local use = sgs.CardUseStruct(sgs.Sanguosha:cloneCard("peach"), liege, data:toDying().who)
            room:useCard(use)
        end
        end
    end,
    -- can_trigger = function(self, target)
	-- 	return target ~= nil
	-- end
}
-- shendiaochan:addSkill(GetPeach)
SelectCard = function(player, liege, card)
    local room = player:getRoom()
    local cardlist = sgs.IntList()
    local disablelist = sgs.IntList()
    local cards = liege:getHandcards()
    local need = 1
    for _,c in sgs.qlist(cards) do
        local valid = false
        if c:isKindOf(card) or c:match(card) then
            if card ~= "slash" and liege:hasSkill("wushen") and c:getSuit() == 2 then
            else valid = true end
        end
        if card == "Nullification" and liege:hasSkill("kanpo") then
            valid = c:isBlack()
        elseif card == "Peach" and liege:hasSkill("jijiu") then
            valid = c:isRed()
        elseif card == "Peach" and liege:getHp() <= 0 then
            valid = c:isKindOf("Analeptic") and not liege:hasSkill("jinjiu") or liege:hasSkill("jiuchi") and c:getSuit() == 0
        elseif card == "Nullification" and liege:hasSkill("longhun") then
            valid = c:getSuit() == 0
            need = math.max(liege:getHp(),1)
        elseif card == "Peach" and liege:hasSkill("longhun") then
            valid = c:getSuit() == 2
            need = math.max(liege:getHp(),1)
        elseif card == "slash" and liege:hasSkill("wusheng") then
            valid = c:isRed()
        elseif card == "slash" and liege:hasSkill("wushen") then
            valid = c:getSuit() == 2
        elseif card == "slash" and liege:hasSkill("longdan") then
            valid = c:isKindOf("Jink")
        elseif card == "slash" and liege:hasSkill("jinjiu") then
            valid = c:isKindOf("Analeptic")
        elseif card == "jink" and liege:hasSkill("longdan") then
            valid = c:isKindOf("Slash")
        elseif card == "jink" and liege:hasSkill("qingguo") then
            valid = c:isBlack()
        elseif card == "slash" and liege:hasSkill("longhun") then
            valid = c:getSuit() == 3
            need = math.max(liege:getHp(),1)
        elseif card == "jink" and liege:hasSkill("longhun") then
            valid = c:getSuit() == 1
            need = math.max(liege:getHp(),1)
        end
        if not valid then disablelist:append(c:getEffectiveId()) end
        cardlist:append(c:getEffectiveId())
    end
    if cardlist:length() < need then return nil end
    local cards = {}
    for i=1,need do
        room:fillAG(cardlist, player, disablelist)
        local slash = room:askForAG(player, cardlist, true, card)
        room:clearAG(player)
        disablelist:append(slash)
        if slash == -1 then break end
        table.insert(cards,tostring(slash))
    end
    -- if slash == -1 then return nil end
    -- slash = sgs.Sanguosha:getCard(slash)
    -- if not slash:isKindOf(card) then return nil end
    -- player:drawCards(#cards)
    if #cards ~= 0 then
        local valid = false
        if #cards == 1 then
            if need == 1 then 
                valid = true
            elseif sgs.Sanguosha:getCard(tonumber(cards[1])):isKindOf(card) then
                valid = true
            end
        elseif #cards == need then 
            -- player:drawCards(3)
            valid = true end
        -- player:addToPile("Meihuo",slash)
        if valid then return cards
        else return nil end
    end
end
AskMaster = function(self, player, card)
    if not player:getPile("Meihuo"):isEmpty() then return true end
    local room = player:getRoom()
    local liege = toTagPlayer(room, "Meihuoing")
    if not liege or not liege:isAlive() then return nil end
    local cards = SelectCard(player, liege, card)
    if cards and #cards ~= 0 then
        player:setTag("Kanpo", sgs.QVariant(table.concat(cards,"+")))
        -- player:drawCards(4)
        return liege
    end
end
KanpoInit = sgs.CreateTriggerSkill{
    name = "#KanpoInit",
    events = {sgs.GameStart},
    frequency = sgs.Skill_Compulsory,
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        room:detachSkillFromPlayer(player, "LuaKanpo")
        room:detachSkillFromPlayer(player, "#GetPeach")
    end
}
KanpoCard = sgs.CreateSkillCard{
    name = "KanpoCard",
    target_fixed = true,
	on_use = function(self, room, source, targets)
        if type(source:getTag("Kanpo")) ~= "string" then return end
        local origin = source:getTag("Kanpo"):toString():split("+")
        local uselist = sgs.IntList()
        for _, c in ipairs(origin) do uselist:append(tonumber(c)) end
        source:removeTag("Kanpo")
        local move = sgs.CardsMoveStruct()
        move.to_place = sgs.Player_DiscardPile
        move.card_ids = uselist
        room:moveCardsAtomic(move, true)
        room:useCard(sgs.CardUseStruct(sgs.Sanguosha:cloneCard("nullification"), source, targets), false)
    end
}
LuaKanpo = sgs.CreateZeroCardViewAsSkill{
	name = "LuaKanpo",
	view_as = function(self, originalCard)
        -- return sgs.Sanguosha:cloneCard("nullification", originalCard:getSuit(), originalCard:getNumber())
        return KanpoCard:clone()
	end,
    enabled_at_response = function(self, player, pattern)
        return pattern == "nullification"
	end ,
    enabled_at_play = true,
	enabled_at_nullification = function(self, player)
        return AskMaster(self,player,"Nullification") ~= nil
	end
}
HuoxinEffect = function(self, diaochan, target)
    local room = diaochan:getRoom()
    -- local msg = sgs.LogMessage()
    -- msg.type = type(diaochan.hp)
    -- room:sendLog(msg)
    local all_players = room:getAllPlayers(true)
    local diaochan_skills, target_skills
    for _, player in sgs.qlist(all_players) do
        local LuaChanyuan_skills = player:getTag("LuaChanyuanSkills"):toString():split("+")
        local skills = player:getVisibleSkillList()
        for _, skill in sgs.qlist(skills) do
            -- if skill:objectName() ~= self:objectName() and skill:getLocation() == sgs.Skill_Right and not skill:inherits("SPConvertSkill") and not skill:isAttachedLordSkill() and not (Set(LuaChanyuan_skills))[skill:objectName()] then
            room:addPlayerMark(player, "Qingcheng"..skill:objectName())
            table.insert(LuaChanyuan_skills, skill:objectName())
            -- end
        end
        if diaochan == player then diaochan_skills = LuaChanyuan_skills end
        if target == player then target_skills = LuaChanyuan_skills end
        player:setTag("LuaChanyuanSkills", sgs.QVariant(table.concat(LuaChanyuan_skills, "+")))
    end
    local h1, h2 = math.max(diaochan:getHp(),0), math.max(target:getHp(),0)
    local m1, m2 = math.max(diaochan:getMaxHp(),0), math.max(target:getMaxHp(),0)
    local k1, k2 = diaochan:getKingdom(), target:getKingdom()
    local f1, f2 = diaochan:faceUp(), target:faceUp()
    if f1 ~= f2 then
        diaochan:turnOver()
        target:turnOver()
    end
    DimengCard(room,diaochan,target)
    GanluCard(diaochan,target)
    local n1,n2 = diaochan:getGeneralName(), target:getGeneralName()
    local nn1,nn2 = diaochan:getGeneral2Name(), target:getGeneral2Name()
    local c1,c2 = diaochan:isChained(), target:isChained()
    room:setPlayerProperty(diaochan, "chained", sgs.QVariant(c2))
    room:setPlayerProperty(target, "chained", sgs.QVariant(c1))
    for _, player in sgs.qlist(all_players) do
        local LuaChanyuan_skills = player:getTag("LuaChanyuanSkills"):toString():split("+")
        for _, skill_name in ipairs(LuaChanyuan_skills) do
            room:removePlayerMark(player, "Qingcheng"..skill_name)
        end
        player:setTag("LuaChanyuanSkills", sgs.QVariant())
    end
    room:changeHero(diaochan,n2,true,false,false,false)
    room:changeHero(target,n1,true,false,false,false)
    room:changeHero(diaochan,nn2,true,false,true,false)
    room:changeHero(target,nn1,true,false,true,false)
    room:swapSeat(diaochan,target)
    local skills = diaochan:getVisibleSkillList()
    local now_diaochan = {}
    for _, skill in sgs.qlist(skills) do table.insert(now_diaochan, skill:objectName()) end
    local skills = target:getVisibleSkillList()
    local now_target = {}
    for _, skill in sgs.qlist(skills) do table.insert(now_target, skill:objectName()) end
    for _, skill in ipairs(diaochan_skills) do
        if not table.contains(now_target, skill) then room:acquireSkill(target, skill) end
    end
    for _, skill in ipairs(target_skills) do
        if not table.contains(now_diaochan, skill) then room:acquireSkill(diaochan, skill) end
    end
    for _, skill in ipairs(now_diaochan) do
        if not table.contains(target_skills, skill) then room:detachSkillFromPlayer(diaochan, skill) end
    end
    for _, skill in ipairs(now_target) do
        if not table.contains(diaochan_skills, skill) then room:detachSkillFromPlayer(target, skill) end
    end
    room:setPlayerProperty(diaochan, "kingdom", sgs.QVariant(k2))
    room:setPlayerProperty(target, "kingdom", sgs.QVariant(k1))
    MarkCard(diaochan,target)
    if h1 <= 0 then room:killPlayer(target) end
    if h2 <= 0 then room:killPlayer(diaochan) end
    if h1 > 0 and not target:isAlive() then room:revivePlayer(target) end
    if h2 > 0 and not diaochan:isAlive() then room:revivePlayer(diaochan) end
    -- room:setPlayerCardLimitation(target, "use,response", ".|.|.|hand", true)
    if diaochan:isAlive() and diaochan:getMaxHp()-m2 ~= 0 then room:setPlayerProperty(diaochan, "maxhp", sgs.QVariant(m2)) end
    if target:isAlive() and target:getMaxHp()-m1 ~= 0 then room:setPlayerProperty(target, "maxhp", sgs.QVariant(m1)) end
    if diaochan:isAlive() and diaochan:getHp()-h2 ~= 0 then room:setPlayerProperty(diaochan, "hp", sgs.QVariant(h2)) end
    if target:isAlive() and target:getHp()-h1 ~= 0 then room:setPlayerProperty(target, "hp", sgs.QVariant(h1)) end
end
LuaFuzuo = sgs.CreateTriggerSkill{
	name = "#LuaFuzuo" ,
	events = {sgs.PindianVerifying} ,
    frequency = sgs.Skill_Compulsory,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local pindian = data:toPindian()
        if pindian.reason ~= "huoxinpindian" then return false end
        if pindian.from_number <= pindian.to_number then pindian.from:gainMark("@Mei") end
        if pindian.from_number >= pindian.to_number then pindian.to:gainMark("@Mei") end
		return false
	end ,
	can_trigger = function(self, target)
		return target
	end
}
luanosrendeCard = sgs.CreateSkillCard{
	name = "luanosrendeCard" ,
	will_throw = false ,
	handling_method = sgs.Card_MethodNone ,
	filter = function(self, targets, to_select)
		return #targets < 2 and to_select:objectName() ~= sgs.Self:objectName()
	end ,
	feasible = function(self, targets)
		return #targets == 2
	end,
	on_use = function(self, room, source, targets)
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, source:objectName(), targets[1]:objectName(), "luanosrende", "")
		local cards = self:getSubcards()
        -- local msg = sgs.LogMessage()
        -- msg.type = sgs.QVariant(cards:at(0)):toString()
        -- room:sendLog(msg)
        local rende_card1 = luanosrendeCard:clone()
        rende_card1:addSubcard(cards:at(0))
        local rende_card2 = luanosrendeCard:clone()
        rende_card2:addSubcard(cards:at(1))
        room:obtainCard(targets[1], rende_card1, reason, false)
		room:obtainCard(targets[2], rende_card2, reason, false)
        sgs.Sanguosha:playSkillAudioEffect("Luanosrende",math.random(2))
		targets[1]:pindian(targets[2], "huoxinpindian", nil)
	end
}
luanosrende = sgs.CreateViewAsSkill{
	name = "luanosrende" ,
	n = 2,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return not to_select:isEquipped()
		elseif #selected == 1 then
			local card = selected[1]
			if to_select:getSuit() == card:getSuit() then
				return not to_select:isEquipped()
			end
		else
			return false
		end
	end,
	view_as = function(self, cards)
		if #cards < 2 then return nil end
		local rende_card = luanosrendeCard:clone()
		for _, c in ipairs(cards) do
			rende_card:addSubcard(c)
		end
		return rende_card
	end ,
	enabled_at_play = function(self, player)
		return not player:isKongcheng() and  not player:hasUsed("#luanosrendeCard")
	end
}
Huoxin = sgs.CreatePhaseChangeSkill{
    name = "#Huoxin",
    frequency = sgs.Skill_Frequent,
	on_phasechange = function(self, target)
        local room = target:getRoom()
        if target:hasSkill(self:objectName()) then return false end
		if target:getPhase() == 0 and target:getMark("@Mei") >= 2 then
			local all_players = room:getAllPlayers()
			for _, diaochan in sgs.qlist(all_players) do
                if not diaochan:isAlive() or not diaochan:hasSkill(self:objectName()) then else
                if room:askForSkillInvoke(diaochan, self:objectName(), sgs.QVariant(1)) then
                    target:loseAllMarks("@Mei")
                    sgs.Sanguosha:playSkillAudioEffect("lihun",math.random(2))
                    diaochan:setTag("Meihuo", sgs.QVariant(1))
                    target:setTag("Meihuoing", sgs.QVariant(1))
                    HuoxinEffect(self, diaochan, target)
                    local role1 = diaochan:getRole()
                    local role2 = target:getRole()
                    room:setTag("MeihuoRole", sgs.QVariant(role2))
                    target:setRole(role1)
                    room:acquireSkill(diaochan,"LuaKanpo")
                    room:acquireSkill(diaochan, "#GetPeach")
                    -- room:detachSkillFromPlayer(target, "LuaKanpo")
                    -- room:detachSkillFromPlayer(target, "#GetPeach")
                    room:detachSkillFromPlayer(target, "#Huoxin")
                    -- pt(room, "output")
                    -- pt(room, target:getState())
                    if target:getState() == "online" then target:setTag("human", sgs.QVariant(true))
                    else target:setTag("human", sgs.QVariant(false)) end
                    target:setState("robotxx")
                    diaochan:gainAnExtraTurn()
                    -- pt(room, "output")
                    -- pt(room, target:getState())
                    if target:getTag("human"):toBool() then target:setState("online") end
                    room:throwEvent(sgs.TurnBroken)
                    return true
                end
                end
            end
        end
        return false
    end,
	can_trigger = function(self, target)
		return target
	end,
    priority = 5
}
EndHuoxin = sgs.CreatePhaseChangeSkill{
    name = "#EndHuoxin",
    frequency = sgs.Skill_Compulsory, 
    priority = -10,
	on_phasechange = function(self, player)
		if player:getPhase() == sgs.Player_NotActive and player:getTag("Meihuo"):toInt() == 1 then
            local room = player:getRoom()
			local all_players = room:getAllPlayers(true)
			for _, p in sgs.qlist(all_players) do
                if p:getTag("Meihuoing"):toInt() == 1 then
                    HuoxinEffect(self, player, p)
                    -- local msg = sgs.LogMessage()
                    -- msg.type = room:getTag("MeihuoRole"):toString().."zzzzzzzzzzzzzz"
                    -- room:sendLog(msg)
                    p:setRole(room:getTag("MeihuoRole"):toString())
                    -- p:drawCards(10)
                    local msg = sgs.LogMessage()
                    msg.type = sgs.QVariant(p:getRole()):toString()
                    room:sendLog(msg)
                    local msg = sgs.LogMessage()
                    msg.type = room:getTag("MeihuoRole"):toString()
                    room:sendLog(msg)
                    room:removePlayerCardLimitation(p, "use,response", ".|.|.|hand$1")
                    room:detachSkillFromPlayer(player, "LuaKanpo")
                    room:detachSkillFromPlayer(p, "LuaKanpo")
                    room:detachSkillFromPlayer(player, "#GetPeach")
                    room:detachSkillFromPlayer(p, "LuaKanpo")
                    room:acquireSkill(player, "#Huoxin")
                    player:removeTag("Meihuo")
                    p:removeTag("Meihuoing")
                end
			end
		end
		return false
	end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
EndHuoxinDeath = sgs.CreateTriggerSkill{
    name = "#EndHuoxinDeath",
    frequency = sgs.Skill_Compulsory,
    events = {sgs.AskForPeachesDone},
	on_trigger = function(self, event, player, data)
        if player:getHp() > 0 then return end
        local room = player:getRoom()
        local all_players = room:getAllPlayers()
		if player:getTag("Meihuo"):toInt() == 1 then
			for _, p in sgs.qlist(all_players) do
                if p:getTag("Meihuoing"):toInt() == 1 then
                    player:removeTag("Meihuo")
                    p:removeTag("Meihuoing")
                    HuoxinEffect(self, player, p)
                    room:removePlayerCardLimitation(p, "use,response", ".|.|.|hand$1")
                    room:detachSkillFromPlayer(player, "LuaKanpo")
                    room:detachSkillFromPlayer(player, "#GetPeach")
                    room:acquireSkill(player, "#Huoxin")
                end
			end
            room:throwEvent(sgs.TurnBroken)
		-- elseif player:getTag("Meihuoing"):toInt() == 1 then
        --     for _, p in sgs.qlist(all_players) do
        --         if p:getTag("Meihuo"):toInt() == 1 then
        --             player:removeTag("Meihuoing")
        --             p:removeTag("Meihuo")
        --             HuoxinEffect(self, p, player)
        --             room:removePlayerCardLimitation(player, "use,response", ".|.|.|hand$1")
        --             room:detachSkillFromPlayer(p, "LuaKanpo")
        --             room:detachSkillFromPlayer(p, "LuaKanpo")
        --             room:detachSkillFromPlayer(p, "#GetPeach")
        --             room:detachSkillFromPlayer(p, "#GetPeach")
        --             room:acquireSkill(p, "#Huoxin")
        --         end
        --     end
        end
	end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
-- shendiaochan:addSkill(LuaLeiji)
shendiaochan:addSkill(Huoxin)
-- shendiaochan:addSkill(LuaJijiang)
-- shendiaochan:addSkill(LuaKanpo)
shendiaochan:addSkill(EndHuoxin)
-- shendiaochan:addSkill(KanpoInit)
shendiaochan:addSkill(luanosrende)
shendiaochan:addSkill(LuaFuzuo)
shendiaochan:addSkill(EndHuoxinDeath)
-- caojinyu:addSkill(LuaJijiang)

meihunCard = sgs.CreateSkillCard{
    name = "meihunCard",
	filter = function(self, targets, to_select)
		return #targets < 1 and not to_select:isKongcheng() and to_select:objectName() ~= sgs.Self:objectName()
	end ,
	feasible = function(self, targets)
		return #targets == 1
	end,
	on_use = function(self, room, source, targets)
        local target = targets[1]
        local suit = room:askForSuit(source, self:objectName())
        local msg = sgs.LogMessage()
        msg.type = "#meihunsuit"
        msg.from = source
        msg.arg = sgs.Card_Suit2String(suit)
        room:sendLog(msg)
        sgs.Sanguosha:playSkillAudioEffect("Meihun",math.random(2))
		local card = room:askForCard(target, ".|"..sgs.Card_Suit2String(suit), "meihun"..sgs.Card_Suit2String(suit), sgs.QVariant(), self:objectName())
        if card then
            local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, source:objectName(), target:objectName(), "luanosrende", "")
		    local rende_card1 = luanosrendeCard:clone()
            rende_card1:addSubcard(card)
            room:obtainCard(source, rende_card1, reason)
            -- local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_EXTRACTION, source:objectName())
            -- room:obtainCard(source, sgs.Sanguosha:getCard(card), reason, false)
        else
            local cardlist = sgs.IntList()
            local cards = target:getHandcards()
            for _,c in sgs.qlist(cards) do cardlist:append(c:getEffectiveId()) end
            if cardlist:length() == 0 then return nil end
            room:fillAG(cardlist)
            local slash = room:askForAG(source, cardlist, false, self:objectName())
            room:clearAG()
            local move = sgs.CardsMoveStruct()
            move.to_place = sgs.Player_DiscardPile
            move.card_ids:append(slash)
            room:moveCardsAtomic(move, true)
        end
    end

}
-- room:getThread():delay()
meihunVS = sgs.CreateZeroCardViewAsSkill{
    name = "meihun",
	response_pattern = "@meihun" ,
    view_as = function(self)
		return meihunCard:clone()
	end ,
    -- enabled_at_play = false
}
meihun = sgs.CreateTriggerSkill{
    name = "meihun",
    events = {sgs.EventPhaseStart, sgs.TargetConfirmed},
    frequency = sgs.Skill_Frequent,
    view_as_skill = meihunVS,
    on_trigger = function(self, event, player, data)
        -- return true
        local room = player:getRoom()
        local diaochan = nil
        if event == sgs.EventPhaseStart then
            if player:getPhase() ~= sgs.Player_Finish or not player:hasSkill(self:objectName()) then
                return false
            else diaochan = player end
        end
        if event == sgs.TargetConfirmed then
            if not player:hasSkill(self:objectName()) then return false end
            -- player:drawCards(1)
			local all_players = room:getAllPlayers()
			for _, p in sgs.qlist(all_players) do
                if p:hasSkill(self:objectName()) then diaochan = p end
            end
            -- player:drawCards(1)
            local card = data:toCardUse()
            if not card.card:isKindOf("Slash") or not card.to:contains(diaochan) then return false end
        end
        if true or room:askForSkillInvoke(diaochan, self:objectName(), data) then
            room:askForUseCard(diaochan, "@meihun", "")
        end
        return true
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
shendiaochan:addSkill(meihun)

zhangxiu = sgs.General(extension, "zhangxiu", "qun")
LuaNosQianxun = sgs.CreateProhibitSkill{
	name = "#LuaNosQianxun",
	is_prohibited = function(self, from, to, card)
        if from:getMark("@xiongluan") == 1 then return false end
		return to:hasSkill(self:objectName()) and (card:getTypeId() == sgs.Card_TypeEquip or card:getTypeId() == sgs.Card_TypeTrick and not card:isNDTrick())
	end
}
endXiongluan = sgs.CreatePhaseChangeSkill{
    name = "#endXiongluan",
    frequency = sgs.Skill_Compulsory, 
	on_phasechange = function(self, player)
		if player:getPhase() == sgs.Player_NotActive and player:getTag("xiaoxiong"):toInt() == 1 then
            player:removeTag("xiaoxiong")
            local room = player:getRoom()
            local assignee_list = player:property("extra_slash_specific_assignee"):toString():split("+")
            local target
            for _,p in sgs.qlist(room:getAllPlayers()) do
                if p:getMark("@luan") >= 1 then
                    p:loseAllMarks("@luan")
                    target = p
                    room:removePlayerCardLimitation(target, "use,response", ".|.|.|hand")
                end
            end
			table.removeOne(assignee_list,target:objectName())
			room:setPlayerProperty(player, "extra_slash_specific_assignee", sgs.QVariant(table.concat(assignee_list,"+")))
			room:setFixedDistance(player, target, -1)
        end
    end
}
XiongluanCard = sgs.CreateSkillCard{
    name = "XiongluanCard",
    on_effect = function(self, effect)
        local zhangxiu = effect.from
        zhangxiu:setTag("xiaoxiong", sgs.QVariant(1))
        local target = effect.to
        local room = zhangxiu:getRoom()
        zhangxiu:loseAllMarks("@xiongluan")
        local move = sgs.CardsMoveStruct()
        move.to_place = sgs.Player_DiscardPile
        for _, c in sgs.qlist(zhangxiu:getEquips()) do
            move.card_ids:append(c:getEffectiveId())
        end
        for _, c in sgs.qlist(zhangxiu:getJudgingArea()) do
            move.card_ids:append(c:getEffectiveId())
        end
        room:moveCardsAtomic(move, true)
        target:gainMark("@luan")
        local assignee_list = effect.from:property("extra_slash_specific_assignee"):toString():split("+")
        table.insert(assignee_list,target:objectName())
        room:setPlayerProperty(effect.from, "extra_slash_specific_assignee", sgs.QVariant(table.concat(assignee_list,"+")))
        room:setFixedDistance(effect.from, effect.to, 1);
        room:setPlayerCardLimitation(target, "use,response", ".|.|.|hand", true)
    end
}
xiongluanVS = sgs.CreateZeroCardViewAsSkill{
	name = "xiongluan" ,
	view_as = function()
		return XiongluanCard:clone()
	end ,
	enabled_at_play = function(self, player)
		return player:getMark("@xiongluan") >= 1
	end
}
xiongluan = sgs.CreateTriggerSkill{
    name = "xiongluan",
    frequency = sgs.Skill_Limited,
    limit_mark = "@xiongluan",
    view_as_skill = xiongluanVS ,
	on_trigger = function()
    end
}
congjian = sgs.CreateTriggerSkill{
	name = "congjian" ,
	events = {sgs.TargetConfirmed} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		if player:getHandcardNum() <= 0 or use.to:length() <= 1 or not use.to:contains(player) or not use.card:isKindOf("TrickCard") 
			or not room:askForSkillInvoke(player, self:objectName(), data) then
			return false
		end
        local target = room:askForPlayerChosen(player, use.to, self:objectName(), "@congjian-to", false)
        if target == player then return end
        sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
        local card = room:askForCard(player, ".|.|.|hand", "@congjian", data, sgs.Card_MethodNone)
        if card then target:obtainCard(card) end
        -- player:drawCards(1)
        -- local msg = sgs.LogMessage()
        -- msg.type = type(card:getTypeId())
        -- room:sendLog(msg)
        if card:getTypeId() == sgs.Card_TypeEquip then
            player:drawCards(2)
        else
            player:drawCards(1)
        end
	end,
    can_trigger = function(self, target)
		return target:hasSkill(self:objectName())
	end
}
zhangxiu:addSkill(xiongluan)
zhangxiu:addSkill(congjian)
zhangxiu:addSkill(LuaNosQianxun)
zhangxiu:addSkill(endXiongluan)

mengda = sgs.General(extension, "mengda", "wei")
wuchang = sgs.CreateTriggerSkill{
	name = "wuchang" ,
	events = {sgs.HpChanged, sgs.GameStart} ,
    frequency = sgs.Skill_Compulsory,
	on_trigger = function(self, event, player, data)
        if event == sgs.GameStart then player:setShownRole(true) end
        local room = player:getRoom()
        if player:getHp() >= 1 and player:getHp() <= 4 then
            sgs.Sanguosha:playSkillAudioEffect("wuchang",player:getHp())
        elseif player:getHp() >= 5 then
            sgs.Sanguosha:playSkillAudioEffect("wuchang",4)
        end
        if player:getHp() == 1 or player:getHp() == 3 then
            player:setRole("loyalist")
            room:setPlayerProperty(player, "kingdom", sgs.QVariant(room:getLord():getGeneral():getKingdom()))
        elseif player:getHp() <= 0 then
            player:setRole("renegade")
            room:setPlayerProperty(player, "kingdom", sgs.QVariant("wei"))
        else
            player:setRole("rebel")
            room:setPlayerProperty(player, "kingdom", sgs.QVariant("wei"))
        end
	end
}
zhuni = sgs.CreateTriggerSkill{
    name = "zhuni" ,
    events = {sgs.BuryVictim},
    frequency = sgs.Skill_Compulsory,
    priority = 5,
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local death = data:toDeath()
        local victim = death.who
        local killer = death.damage.from
        -- room:setTag("SkipGameRule", sgs.QVariant(true))
        -- victim:clearFlags();
        -- victim:clearHistory();
        -- victim:throwAllCards();
        -- victim:throwAllMarks();
        -- victim:clearPrivatePiles();
        -- return false
        if victim:getRole() == "rebel" then
            room:setTag("SkipGameRule", sgs.QVariant(true))
            victim:bury()
            room:setTag("SkipGameRule", sgs.QVariant(false))
            local choices = {}
            -- pt(room, "zhuni1")
            for i=0, math.min(3, killer:getHandcardNum()) do
                table.insert(choices, i)
            end
            -- pt(room, "zhuni2")
            local disc = room:askForChoice(killer, self:objectName(), table.concat(choices, "+"))
            -- pt(room, "zhuni3")
            room:askForDiscard(killer, self:objectName(), disc, disc)
            room:askForDiscard(room:getLord(), self:objectName(), 3-disc, 3-disc)
            -- pt(room, "zhuni4")
        end
    end,
    can_trigger = function(self, target)
        return target ~= nil
    end
}
shijiu = sgs.CreateFilterSkill{
	name = "shijiu", 
	view_filter = function(self,to_select)
		local room = sgs.Sanguosha:currentRoom()
		local place = room:getCardPlace(to_select:getEffectiveId())
		return (to_select:getSuit() == sgs.Card_Heart) and (place == sgs.Player_PlaceHand)
	end,
	view_as = function(self, originalCard)
		local slash = sgs.Sanguosha:cloneCard("analeptic", originalCard:getSuit(), originalCard:getNumber())
		slash:setSkillName(self:objectName())
		local card = sgs.Sanguosha:getWrappedCard(originalCard:getId())
		card:takeOver(slash)
		return card
	end
}
mengda:addSkill(wuchang)
mengda:addSkill(zhuni)
mengda:addSkill(shijiu)


duyou = sgs.General(extension, "duyou", "qun", "3")
xuncha = sgs.CreateDistanceSkill{
	name = "xuncha",
	correct_func = function(self, from, to)
        local correction = 0
        if from:getMark("huilu") == 1 and not from:hasSkill(self:objectName()) and from:getHandcardNum()>from:getMaxHp() and from:faceUp() and not (from:getMark("@huilu")==1) then
			correction = correction + from:getHandcardNum()-from:getHp()
        end
		if to:getMark("huilu") == 1 and not to:hasSkill(self:objectName()) and to:getHandcardNum()>to:getMaxHp() and to:faceUp() and not (to:getMark("@huilu")==1) then
			correction = correction - (to:getHandcardNum()-to:getHp())
        end
        return correction
	end,
}
huiluCard = sgs.CreateSkillCard{
	name = "huiluCard",
	target_fixed = true,
	will_throw = false,
	handling_method = sgs.Card_MethodNone ,
	on_use = function(self, room, source)
        local duyou
        for _,p in sgs.qlist(room:getOtherPlayers(source)) do
            if p:hasSkill("huilu") then duyou = p end
        end
		room:moveCardTo(self, duyou, sgs.Player_PlaceHand, false)
        source:gainMark("@huilu")
	end
}
huiluVS = sgs.CreateViewAsSkill{
	name = "huilu",
	n = 999,
	response_pattern = "@@huilu" ,
	view_filter = function(self, selected, to_select)
		if to_select:isEquipped() then return false end
		local length = math.floor(sgs.Self:getHandcardNum() / 2)
		return #selected < length
	end,
	view_as = function(self, cards)
		if #cards < 1 or #cards ~= math.floor(sgs.Self:getHandcardNum() / 2) then return nil end
		local card = huiluCard:clone()
		for _, c in ipairs(cards) do
			card:addSubcard(c)
		end
		return card
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@huilu"
	end
}
huilu = sgs.CreateTriggerSkill{
    name = "huilu" ,
    events = {sgs.EventPhaseChanging, sgs.GameStart, sgs.Death},
    view_as_skill = huiluVS,
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.GameStart and player:hasSkill(self:objectName()) then
            for _,p in sgs.qlist(room:getOtherPlayers(player)) do
                p:gainMark("huilu")
                room:acquireSkill(p, "zhizui")
            end
            return
        end
        if event == sgs.Death and data:toDeath().who:hasSkill(self:objectName()) then
            for _,p in sgs.qlist(room:getOtherPlayers(data:toDeath().who)) do
                room:detachSkillFromPlayer(p, "zhizui")
                p:loseAllMarks("huilu")
            end
            return
        end
        if player:hasSkill("huilu") then return end
        local phase = data:toPhaseChange().to
        if phase == sgs.Player_Start then
            if room:askForSkillInvoke(player, self:objectName(), data) then
                room:askForUseCard(player, "@@huilu", "@huilu", -1, sgs.Card_MethodNone)
            end
        elseif phase == sgs.Player_NotActive then
            player:loseAllMarks("@huilu")
        end
    end,
    can_trigger = function(self, target)
        return target:getMark("huilu") == 1 or target:hasSkill("huilu")
    end
}
zhizuiCard = sgs.CreateSkillCard{
	name = "zhizuiCard",
	will_throw = false,
    -- filter = function(self, targets, to_select)
	-- 	if (#targets ~= 0) or to_select:objectName() == sgs.Self:objectName() then return false end
	-- 	return to_select:hasSkill("xuncha") and to_select:getHandcardNum() > to_select:getMaxHp()
	-- end,
    target_fixed = true,
	handling_method = sgs.Card_MethodNone,
	on_use = function(self, room, source)
        -- if source:isKongcheng() then return end
		local room = source:getRoom()
        local duyou
        for _,p in sgs.qlist(room:getOtherPlayers(source)) do
            if p:hasSkill("huilu") then duyou = p end
        end
        local hand_num = source:getHandcardNum()
        source:throwAllHandCards()
		room:showAllCards(duyou)
        local cards = sgs.IntList()
        local disabled = sgs.IntList()
        local abled = sgs.IntList()
		for _, cd in sgs.qlist(duyou:getHandcards()) do
            cards:append(cd:getEffectiveId())
            if cd:isKindOf("Collateral") or cd:isKindOf("Slash") then
                abled:append(cd:getEffectiveId())
            else disabled:append(cd:getEffectiveId()) end
        end
        for i=0, hand_num-1 do
            room:fillAG(cards, source, disabled)
            local slash = room:askForAG(source, abled, true, self:objectName())
            room:clearAG()
            if slash == -1 then break end
            disabled:append(slash)
            abled:removeOne(slash)
            room:obtainCard(source, slash)
        end
        source:turnOver()
        duyou:turnOver()
	end,
}
zhizui = sgs.CreateZeroCardViewAsSkill{
	name = "zhizui",
	view_as = function(self, cards)
		return zhizuiCard:clone()
	end,
	enabled_at_play = function(self, player)
		return (not player:hasSkill("huilu")) and (not player:hasUsed("#zhizuiCard")) and (not player:isKongcheng())
	end,
}
jinmi = sgs.CreateFilterSkill{
	name = "jinmi", 
	view_filter = function(self,to_select)
		local room = sgs.Sanguosha:currentRoom()
		local place = room:getCardPlace(to_select:getEffectiveId())
		return (to_select:isKindOf("Weapon")) and (place == sgs.Player_PlaceHand)
	end,
	view_as = function(self, originalCard)
		local slash = sgs.Sanguosha:cloneCard("collateral", originalCard:getSuit(), originalCard:getNumber())
		slash:setSkillName(self:objectName())
		local card = sgs.Sanguosha:getWrappedCard(originalCard:getId())
		card:takeOver(slash)
		return card
	end
}
duyou:addSkill(xuncha)
duyou:addSkill(zhizui)
duyou:addSkill(jinmi)
duyou:addSkill(huilu)

pt = function(room, x)
    local msg = sgs.LogMessage()
    msg.type = x
    room:sendLog(msg)
end
wifemi = sgs.General(extension, "wifemi", "shu", "3", false)
toEdou = function(player, order)
    -- pt(room, "toEdouStart")
    if order == "" or order == "cancel" then return end
    local room = player:getRoom()
    local skillList = player:getVisibleSkillList()
    local skillTable = {}
    for _, skill in sgs.qlist(skillList) do
        table.insert(skillTable, skill:objectName())
        room:detachSkillFromPlayer(player, skill:objectName())
    end
    skills = table.concat(skillTable, "+")
    player:setTag("originalSkills", sgs.QVariant(skills))
    player:setTag("edouSkill", sgs.QVariant(order))
    room:acquireSkill(player, order)
    -- pt(room, "toEdouOver")
end
changeEdou = function(player, order)
    -- pt(room, "changeEdouStart")
    if player:hasSkill(order) then return end
    local room = player:getRoom()
    local tolose = player:getTag("edouSkill"):toString()
    room:detachSkillFromPlayer(player, tolose)
    player:setTag("edouSkill", sgs.QVariant(order))
    room:acquireSkill(player, order)
    -- pt(room, "changeEdouOver")
end
toOriginal = function(player)
    local room = player:getRoom()
    pt(room, "oriStart")
    local skillList = player:getTag("originalSkills"):toString():split("+")
    for _, skill in ipairs(skillList) do room:acquireSkill(player, skill) end
    player:removeTag("originalSkills")
    room:detachSkillFromPlayer(player, player:getTag("edouSkill"):toString())
    player:removeTag("edouSkill")
    pt(room, "oriEnd")
end
Edou = sgs.CreateTreasure{
    name = "edou",
    on_install = function(self, player)
        if player:getTag("Meihuoing"):toInt() == 1 then return false end
        if player:getTag("Meihuo"):toInt() == 1 then return false end
        local room = player:getRoom()
        player:drawCards(2)
        room:acquireSkill(player, self:objectName())
        -- room:acquireSkill(player, "jinmi")
        -- pt(room, player:getTag("edouSkill"):toString().."GiveSkill")
        toEdou(player, player:getTag("edouSkill"):toString())
        room:acquireSkill(player, "#EdouNumber")
        room:acquireSkill(player, "#EdouDefense")
        room:acquireSkill(player, "#EdouLimit")
        -- pt(room, "on_install")
    end,
    on_uninstall = function(self, player)
        if player:getTag("Meihuoing"):toInt() == 1 then return false end
        if player:getTag("Meihuo"):toInt() == 1 then return false end
        if not player:isAlive() then return false end
        local room = player:getRoom()
        player:removePileByName("hufu")
        room:detachSkillFromPlayer(player, self:objectName())
        room:detachSkillFromPlayer(player, "#EdouNumber")
        room:detachSkillFromPlayer(player, "#EdouDefense")
        room:detachSkillFromPlayer(player, "#EdouLimit")
        toOriginal(player)
        room:loseHp(player)
        -- pt(room, "on_uninstall")
    end
}
EdouNumber = sgs.CreateFilterSkill{
	name = "#EdouNumber",
	view_filter = function(self, to_select)
        -- return to_select:getSuit() ~= sgs.Card_Heart
        for _,c in sgs.qlist(sgs.Self:getPile("hufu")) do
            if sgs.Sanguosha:getCard(c):getNumber() == to_select:getNumber() then
                return true
            end
        end
        return false
	end,
	view_as = function(self, card)
        local id = card:getEffectiveId()
        local new_card = sgs.Sanguosha:getWrappedCard(id)
        new_card:setSkillName(self:objectName())
        new_card:setNumber(1)
        new_card:setModified(true)
        return new_card
	end
}
EdouDefense = sgs.CreateTriggerSkill{
	name = "#EdouDefense" ,
	events = {sgs.CardEffected} ,
	frequency = sgs.Skill_Compulsory ,
	on_trigger = function(self, event, player, data)
		local effect = data:toCardEffect()
        local room = player:getRoom()
        local msg = sgs.LogMessage()
		if effect.card:isKindOf("Dismantlement") or effect.card:isKindOf("Snatch") then
			if effect.to:hasSkill(self:objectName()) and effect.from then
				local hufu = effect.to:getPile("hufu")
                if hufu:isEmpty() then return false end
                room:fillAG(hufu, effect.from)
                local cd = room:askForAG(effect.from, hufu, false, "edou")
                room:clearAG(effect.from)
                if effect.card:isKindOf("Snatch") then
                    room:moveCardTo(sgs.Sanguosha:getCard(cd), effect.from, sgs.Player_PlaceHand)
                else
                    room:throwCard(cd, effect.to, effect.from)
                end
                return true
			end
		end
		return false
	end ,
	can_trigger = function(self, target)
		return target
	end
}
EdouLimit = sgs.CreateMaxCardsSkill{
	name = "#EdouLimit",
	extra_func = function(self, target)
		if target:hasSkill(self:objectName()) then
			return math.min(0,target:getHp()-target:getPile("hufu"):length())
		end
	end
}
edouChangeCard = sgs.CreateSkillCard{
	name = "edouChangeCard" ,
	handling_method = sgs.Card_MethodDiscard ,
    target_fixed = true,
	on_use = function(self, room, source)
        pt(room, "changeStart")
        local room = source:getRoom()
        local edouTags = room:getTag("edouTags"):toString()
        local skill = room:askForChoice(source, self:objectName(), edouTags)
        if skill == "cancel" then toOriginal(source)
        else changeEdou(source, skill) end
        pt(room, "changeStart")
	end
}
edouGiveCard = sgs.CreateSkillCard{
	name = "edouGiveCard" ,
	filter = function(self, targets, to_select, erzhang)
		if #targets ~= 0 or to_select:objectName() == erzhang:objectName() then return false end
		return to_select:getEquip(4) == nil
	end,
	on_use = function(self, room, source, targets)
        -- pt(room, "giveEdouStart")
        local edouTags = room:getTag("edouTags"):toString()
        pt(room, edouTags)
        -- pt(room, edouTags)
        local skill = room:askForChoice(source, self:objectName(), edouTags)
        targets[1]:setTag("edouSkill", sgs.QVariant(skill))
        local msg = sgs.LogMessage()
        msg.from = source
        msg.to:append(targets[1])
        if skill ~= "cancel" then
            msg.type = "#edouSkillOrder"
            msg.arg = skill
            room:sendLog(msg)
        else
            msg.type = "#edouSkillEmpty"
            room:sendLog(msg)
        end
        targets[1]:addToPile("hufu",source:getPile("hufu"))
		room:moveCardTo(source:getEquip(4), targets[1], sgs.Player_PlaceEquip)
        -- pt(room, "giveEdouOver")
	end
}
edouCard = sgs.CreateSkillCard{
	name = "edouCard" ,
	will_throw = false ,
	handling_method = sgs.Card_MethodNone ,
    target_fixed = true,
	on_use = function(self, room, source)
        local room = source:getRoom()
		local cards = self:getSubcards()
        source:addToPile("hufu", cards, true)
        local skills = source:getVisibleSkillList()
        local skillTable = {}
        -- pt(room, room:getTag("edouTags"):toString())
        for _, skill in sgs.qlist(skills) do
            if table.contains(room:getTag("edouTags"):toString():split("+"), skill:objectName()) then else
            table.insert(skillTable, skill:objectName())
            end
        end
        table.insert(skillTable, "cancel")
        skills = table.concat(skillTable, "+")
        local skill = room:askForChoice(source, self:objectName(), skills)
        if skill == "cancel" then return end
        local msg = sgs.LogMessage()
        msg.type = "#edouSkillInput"
        msg.from = source
        msg.arg = skill
        room:sendLog(msg)
        if room:getTag("edouTags"):toString() == "" then room:setTag("edouTags", sgs.QVariant("cancel")) end
        room:setTag("edouTags", sgs.QVariant(skill.."+"..room:getTag("edouTags"):toString()))
	end
}
edou = sgs.CreateViewAsSkill{
	name = "edou" ,
	n = 999,
	expand_pile = "hufu",
	response_pattern = "@edou" ,
	filter_pattern = ".|.|.|hand,hufu" ,
	view_filter = function(self, selected, to_select)
        local edouPile = sgs.Self:getPile("hufu")
        -- if #selected + edouPile:length() >= sgs.Self:getHp() and not edouPile:contains(to_select:getEffectiveId()) then return false end
        if #selected == 0 and edouPile:contains(to_select:getEffectiveId()) then return true end
        local numbers = {}
        for _, c in sgs.qlist(edouPile) do
            if to_select:getEffectiveId() == c or #selected > 0 and selected[1]:getEffectiveId() == c then return false end
            table.insert(numbers, sgs.Sanguosha:getCard(c):getNumber())
        end
        for _, c in ipairs(selected) do table.insert(numbers, sgs.Sanguosha:getCard(c:getEffectiveId()):getNumber()) end
        return not table.contains(numbers, sgs.Sanguosha:getCard(to_select:getEffectiveId()):getNumber())
	end,
	view_as = function(self, cards)
		if #cards < 1 then return edouGiveCard:clone() end
        local rende_card
        if sgs.Self:getPile("hufu"):contains(cards[1]:getEffectiveId()) then
            rende_card = edouChangeCard:clone()
        else
            rende_card = edouCard:clone()
        end
		for _, c in ipairs(cards) do rende_card:addSubcard(c) end
		return rende_card
	end,
	enabled_at_play = function(self, player)
		return not player:isKongcheng() and not player:hasUsed("#edouCard") and not player:hasUsed("#edouGiveCard") and not player:hasUsed("#edouChangeCard")
	end
}
xieyou = sgs.CreateTriggerSkill{
    name = "xieyou",
    events = {sgs.GameStart, sgs.EventPhaseChanging, sgs.BuryVictim, sgs.Death},
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.BuryVictim then
            local death = data:toDeath()
            local victim = death.who
            room:setTag("SkipGameRule", sgs.QVariant(true))
            victim:clearFlags();
            victim:clearHistory();
            victim:throwAllCards();
            victim:throwAllMarks();
            victim:clearPrivatePiles();
            return false
        end
        if event == sgs.GameStart and player:hasSkill(self:objectName()) then
            room:setTag("edouTags", sgs.QVariant("cancel"))
            room:moveCardTo(sgs.Sanguosha:getCard(230), player, sgs.Player_PlaceEquip)
        elseif event == sgs.Death and player:hasSkill(self:objectName()) or player:hasSkill(self:objectName()) and event == sgs.EventPhaseChanging and data:toPhaseChange().to == sgs.Player_NotActive then
            for _,p in sgs.qlist(room:getAllPlayers(true)) do
                if p:hasSkill(self:objectName()) then
                    if p:getTreasure() ~= nil and p:getTreasure():getEffectiveId() == 230 then 
                        pt(room, "XieyouStart")
                        room:askForUseCard(p, "@edou", self:objectName())
                        pt(room, "XieyouOver")
                    end
                    break
                end
            end
        end
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
nichang = sgs.CreateTriggerSkill{
    name = "nichang",
	frequency = sgs.Skill_Compulsory,
    -- event = sgs.Damage,
	events = {sgs.CardAsked},
	on_trigger = function(self, event, wolong, data)
		local pattern = data:toStringList()[1]
		if pattern ~= "jink" and pattern ~= "slash" or wolong:getPhase() ~= sgs.Player_NotActive then return false end
		local room = wolong:getRoom()
        -- pt(room, "nichang1")
        local suits, numbers, hufu = {}, {}, {}
        sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
        for i=1, 13 do table.insert(numbers,false) end
        for i=1, 13 do table.insert(hufu,false) end
        for _,p in sgs.qlist(room:getAllPlayers()) do
            for _,e in sgs.qlist(p:getEquips()) do
                local suit = sgs.Card_Suit2String(e:getSuit())
                if not table.contains(suits, suit) then table.insert(suits, suit) end
                numbers[e:getNumber()] = true
            end
        end
        for _,c in sgs.qlist(wolong:getPile("hufu")) do
            hufu[sgs.Sanguosha:getCard(c):getNumber()] = true
        end
        -- pt(room, "nichang3")
        local s_j = sgs.IntList()
        local sho = 0
        for i=0, 999 do
            if #suits == 0 then break end
            local showed
            --[[
                -- local msg = sgs.LogMessage()
                -- msg.type = table.concat(suits,"+")
                -- room:sendLog(msg)
                -- if sho <= X then
                --     local cd = room:askForCard(wolong, ".|.|.|hand", "@nichang", data, sgs.Card_MethodNone)
                --     local id = cd:getEffectiveId()
                --     if id >= 0 then
                --         room:showCard(wolong, id)
                --         showed = cd
                --         sho = sho + 1
                --     end
                -- end
            ]]
            local judge = sgs.JudgeStruct()
            judge.pattern = ".|"..table.concat(suits,",")
            judge.good = true
            judge.who = wolong
            judge.play_animation = true
            room:judge(judge)
            showed = judge.card
            if showed:getTypeId() == sgs.Card_TypeBasic then
                s_j:append(showed:getEffectiveId()) 
            end
            -- pt(room, "nichang4")
            local failed = false
            for j=showed:getNumber()-wolong:getLostHp(), showed:getNumber()+wolong:getLostHp() do
                if numbers[j] and not hufu[j] then failed = true break end
            end
            if table.contains(suits, sgs.Card_Suit2String(showed:getSuit())) then
                table.removeOne(suits, sgs.Card_Suit2String(showed:getSuit()))
                if #suits == 0 then
                    -- local msg = sgs.LogMessage()
                    -- msg.type = s_j:length().."sj"
                    -- room:sendLog(msg)
                    if not s_j:isEmpty() then
                        wolong:setTag("nichang", sgs.QVariant(pattern))
                        room:fillAG(s_j, wolong)
                        local jink = room:askForAG(wolong, s_j, false, self:objectName())
                        room:clearAG(wolong)
                        wolong:removeTag("nichang")
                        if jink >= 0 then 
                            wolong:obtainCard(sgs.Sanguosha:getCard(jink))
                        end
                        --room:provide(sgs.Sanguosha:getCard(jink)) end
                    end
                    break
                end
            end
            -- pt(room, "nichang5")
            if failed then
                room:loseHp(wolong, math.max(1,math.floor(wolong:getHp() / 2)))
                -- pt(room, "nichang7")
                if not wolong:isAlive() then
                    -- pt(room, "nichang8")
                    room:provide(Edou:clone())
                    return true end
                break
            end
            -- pt(room, "nichang6")
        end
        return false
    end
}
yuyi = sgs.CreateTriggerSkill{
    name = "yuyi",
    -- event = sgs.Damage,
	events = {sgs.TargetConfirming, sgs.CardFinished} ,-- 卡过bug，触发时机太奇�?，需要加标�??
	on_trigger = function(self, event, player, data)
        -- return
		local room = player:getRoom()
        -- local msg = sgs.LogMessage()
        -- msg.type = event
        -- room:sendLog(msg)
        local player
        for _, p in sgs.qlist(room:getAllPlayers()) do
            if p:hasSkill(self:objectName()) then player = p end
        end
        if not player then return end
		local use = data:toCardUse()
        if event == sgs.TargetConfirming then
            if use.to:length() > 1 then return end
            local to = use.to:at(0)
            if to == player or not use.card:isBlack() or not (use.card:isNDTrick() or use.card:getTypeId() == sgs.Card_TypeBasic) then return false end
            if not to:isAdjacentTo(player) then return end
            if not player:askForSkillInvoke(self:objectName(), data) then return end
            player:setTag("yuyi", data)
            sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
            local choices = {}
            local total = math.min(player:getHp(), to:getHp())
            for i=0, total do table.insert(choices,i) end
            local decide = to:getHandcardNum() >= player:getHandcardNum()
            to:setTag("yuyiDecide", sgs.QVariant(decide))
            local choice = sgs.QVariant(room:askForChoice(to, self:objectName(), table.concat(choices, "+"), data)):toInt()
            pt(room, choice..table.concat(choices, "+"))
            to:removeTag("yuyiDecide")
            to:drawCards(choice)
            player:drawCards(total-choice)
            use.to:append(player)
            data:setValue(use)
            room:getThread():trigger(sgs.TargetConfirming, room, player, data)
        elseif event == sgs.CardFinished and player:getTag("yuyi"):toCardUse().card == use.card then
            local choices = {}
            player:removeTag("yuyi")
            local to = use.to:at(0)
            local total = math.max(player:getHp(), to:getHp())
            for i=0, total do table.insert(choices,i) end
            local decide = to:getHandcardNum() < player:getHandcardNum()
            to:setTag("yuyiDecide", sgs.QVariant(decide))
            local choice = sgs.QVariant(room:askForChoice(to, self:objectName(), table.concat(choices, "+"), data)):toInt()
            pt(room, choice..table.concat(choices, "+"))
            to:removeTag("yuyiDecide")
            -- local msg = sgs.LogMessage()
            -- msg.type = "fin"..choice
            -- room:sendLog(msg)
            local to_discard = math.min(to:getHandcardNum(), choice)
            if choice > 0 then room:askForDiscard(to, self:objectName(), to_discard, to_discard) end
            if choice ~= total then room:askForDiscard(player, self:objectName(), total-choice, total-choice) end
        end
	end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
wifemi:addSkill(xieyou)
wifemi:addSkill(nichang)
wifemi:addSkill(yuyi)
-- wifemi:addSkill(zhuni)
ed = Edou:clone(2,2)
ed:setParent(extension)


tianxu = sgs.General(extension, "tianxu", "wei", "5")
zhushaCard = sgs.CreateSkillCard{
    name = "zhushaCard",
    target_fixed = true
}
zhushaVS = sgs.CreateViewAsSkill{
    name = "zhusha",
    n = 999,
    response_pattern = "@zhusha", 
    view_filter = function(self, selected, to_select)
        if (#selected) >= sgs.Self:getHp() then return false end
        for _, c in ipairs(selected) do
            if c:getSuit() == to_select:getSuit() then return false end
        end
        return true
	end ,
    view_as = function(self, cards)
        local card = zhushaCard:clone()
        for _, c in ipairs(cards) do card:addSubcard(c) end
        return card
    end,
    enabled_at_play = false
}
zhusha = sgs.CreateTriggerSkill{
    name = "zhusha",
    view_as_skill = zhushaVS,
    events = {sgs.DamageCaused, sgs.AskForPeachesDone},
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        -- pt(room, "zhusha")
        local tianxu
        for _, p in sgs.qlist(room:getAllPlayers()) do
            if p:hasSkill(self:objectName()) then
                tianxu = p
            end
        end
        if event == sgs.DamageCaused and tianxu:hasSkill(self:objectName()) then
            local damage = data:toDamage()
            if damage.to:getHp() == 1 then
                room:setTag("zhushaTarget", data)
                local card = room:askForUseCard(tianxu, "@zhusha", "")
                if card then
                    local num = card:getSubcards():length()
                    pt(room, "endzhusha21")
                    damage.damage = damage.damage + num
                    data:setValue(damage)
                    room:loseHp(tianxu, num)
                    local tag = sgs.QVariant()
                    tag:setValue(tianxu)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),1)
                    damage.to:setTag("zhushaRevenge", tag)
                end
                room:removeTag("zhushaTarget")
            end
        else
            local tianxu = player:getTag("zhushaRevenge"):toPlayer()
            if tianxu then
                player:removeTag("zhushaRevenge")
                if player:getHP() > 0 then room:damage(sgs.DamageStruct(self:objectName(), player, tianxu)) end
            end
        end
    end,
    can_trigger = function(self, target)
		return target
	end
}
tianxu:addSkill(zhusha)

zhoushan = sgs.General(extension1, "zhoushan", "wu", "4")
duoziCard = sgs.CreateSkillCard{
    name = "duoziCard",
    target_fixed = true
}
duoziVS = sgs.CreateViewAsSkill{
    name = "duozi",
    n = 999,
    response_pattern = "@duozi", 
    view_filter = function(self, selected, to_select)
        if (#selected) >= sgs.Self:getHp() then return false end
        for _, c in ipairs(selected) do
            if c:getSuit() == to_select:getSuit() then return false end
        end
        return true
	end ,
    view_as = function(self, cards)
        local card = zhushaCard:clone()
        for _, c in ipairs(cards) do card:addSubcard(c) end
        return card
    end,
    enabled_at_play = false
}
duozi = sgs.CreateTriggerSkill{
    name = "duozi",
    view_as_skill = duoziVS,
    events = {sgs.DamageCaused, sgs.AskForPeachesDone},
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        -- pt(room, "zhusha")
        local tianxu
        for _, p in sgs.qlist(room:getAllPlayers()) do
            if p:hasSkill(self:objectName()) then
                tianxu = p
            end
        end
        if event == sgs.DamageCaused and tianxu:hasSkill(self:objectName()) then
            local damage = data:toDamage()
            if damage.to:getHp() == 1 then
                room:setTag("zhushaTarget", data)
                local card = room:askForUseCard(tianxu, "@zhusha", "")
                if card then
                    local num = card:getSubcards():length()
                    pt(room, "endzhusha21")
                    damage.damage = damage.damage + num
                    data:setValue(damage)
                    room:loseHp(tianxu, num)
                    local tag = sgs.QVariant()
                    tag:setValue(tianxu)
                    sgs.Sanguosha:playSkillAudioEffect(self:objectName(),1)
                    damage.to:setTag("zhushaRevenge", tag)
                end
                room:removeTag("zhushaTarget")
            end
        else
            local tianxu = player:getTag("zhushaRevenge"):toPlayer()
            if tianxu then
                player:removeTag("zhushaRevenge")
                if player:getHP() > 0 then room:damage(sgs.DamageStruct(self:objectName(), player, tianxu)) end
            end
        end
    end,
    can_trigger = function(self, target)
		return target
	end
}
zhoushan:addSkill(duozi)

shenzhangjiao = sgs.General(extension1, "shenzhangjiao", "god", "3")
fushui = sgs.CreatePhaseChangeSkill{
    name = "fushui",
    on_phasechange = function()
    end
}
fushui_use = sgs.CreateTriggerSkill{
    name = "#fushui_use",
    events = {sgs.askForCard},
    on_trigger = function()
    end
}
leicai = sgs.CreateTriggerSkill{
    name = "leicai",
    events = {sgs.CardsMoveOneTime},
    on_trigger = function()
    end
}
tiangong = sgs.CreateTriggerSkill{
    name = "tiangong",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
shenzhangjiao:addSkill(fushui)
shenzhangjiao:addSkill(fushui_use)
shenzhangjiao:addSkill(leicai)
shenzhangjiao:addSkill(tiangong)
kuangshouren = sgs.General(extension1, "kuangshouren", "god", "6")
bingju = sgs.General(extension1, "bingju", "god", "3", false)
kuangfengtank = sgs.General(extension1, "kuangfengtank", "god", "6")
gaitetank = sgs.General(extension1, "gaitetank", "god", "4")
naoche = sgs.General(extension1, "naoche", "god", "10")
feidie = sgs.General(extension1, "feidie", "god", "6")
kuangshou = sgs.CreateTriggerSkill{
    name = "kuangshou",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
kuangshouren:addSkill(kuangshou)
yuanshe = sgs.CreateTriggerSkill{
    name = "yuanshe",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
bingdu = sgs.CreateTriggerSkill{
    name = "bingdu",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
infection = sgs.CreateTriggerSkill{
    name = "infection",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
bingju:addSkill(yuanshe)
bingju:addSkill(bingdu)
bingju:addSkill(infection)
huopao = sgs.CreateTriggerSkill{
    name = "huopao",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
nianya = sgs.CreateTriggerSkill{
    name = "nianya",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
zhanche = sgs.CreateTriggerSkill{
    name = "zhanche",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
kuangfengtank:addSkill(huopao)
kuangfengtank:addSkill(nianya)
kuangfengtank:addSkill(zhanche)
jipao = sgs.CreateTriggerSkill{
    name = "jipao",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
gaitetank:addSkill(jipao)
gaitetank:addSkill(zhanche)
zhunao = sgs.CreateTriggerSkill{
    name = "zhunao",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
xiufu = sgs.CreateTriggerSkill{
    name = "xiufu",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
naoche:addSkill(zhanche)
naoche:addSkill(zhunao)
naoche:addSkill(xiufu)
xuanfu = sgs.CreateTriggerSkill{
    name = "xuanfu",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
bossdidong = sgs.CreateTriggerSkill{
    name = "bossdidong",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
tuxi = sgs.CreateTriggerSkill{
    name = "nostuxi",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
feidie:addSkill(xiufu)
feidie:addSkill(xuanfu)
feidie:addSkill(bossdidong)
feidie:addSkill(tuxi)
youli = sgs.General(extension1, "youli", "god", "4")
xinkong = sgs.CreateTriggerSkill{
    name = "xinkong",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
naobo = sgs.CreateTriggerSkill{
    name = "naobo",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
bossguimei = sgs.CreateTriggerSkill{
    name = "bossguimei",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
youli:addSkill(xinkong)
youli:addSkill(naobo)
youli:addSkill(bossguimei)

--OL王荣
-- ol_wangrong = sgs.General(extension, "ol_wangrong", "qun", 3, false)

-- fengzi = sgs.CreateTriggerSkill{
-- name = "fengzi",
-- events = sgs.CardUsed,
-- on_trigger = function(self, event, player, data, room)
--     if player:getPhase() ~= sgs.Player_Play or player:getMark("fengzi_Used-PlayClear") > 0 then return false end
--     local use = data:toCardUse()
--     if not use.card:isKindOf("BasicCard") and not use.card:isNDTrick() then return false end
--     if not player:canDiscard(player, "h") then return false end
--     local typee = (use.card:isKindOf("BasicCard") and "BasicCard") or "TrickCard"
--     local card = room:askForCard(player, ""..typee .. "|.|.|hand", "@fengzi-discard:" .. use.card:getType() .. "::" .. use.card:objectName(), data, self:objectName())
--     if not card then return false end
--     room:broadcastSkillInvoke(self)
--     player:addMark("fengzi_Used-PlayClear")
--     room:setCardFlag(use.card, "fengzi_double")
--     return false
-- end
-- }

-- fengziDouble = sgs.CreateTriggerSkill{
-- name = "#fengziDouble",
-- events = sgs.CardFinished,
-- can_trigger = function(self, player)
--     return player and player:isAlive()
-- end,
-- on_trigger = function(self, event, player, data, room)
--     local use = data:toCardUse()
--     if not use.card:isKindOf("BasicCard") and not use.card:isNDTrick() then return false end
--     if not use.card:hasFlag("fengzi_double") then return false end
--     room:setCardFlag(use.card, "-fengzi_double")
--     --if use.card:hasPreAction() then end
--     if use.card:isKindOf("Slash") then  --【杀】需要单独处理
--         for _,p in sgs.qlist(use.to) do
--             local se = sgs.SlashEffectStruct()
--             se.from = use.from
--             se.to = p
--             se.slash = use.card
--             se.nullified = table.contains(use.nullified_list, "_ALL_TARGETS") or table.contains(use.nullified_list, p:objectName())
--             se.no_offset = table.contains(use.no_offset_list, "_ALL_TARGETS") or table.contains(use.no_offset_list, p:objectName())
--             se.no_respond = table.contains(use.no_respond_list, "_ALL_TARGETS") or table.contains(use.no_respond_list, p:objectName())
--             se.multiple = use.to:length() > 1
--             se.nature = sgs.DamageStruct_Normal
--             if use.card:objectName() == "fire_slash" then
--                 se.nature = sgs.DamageStruct_Fire
--             elseif use.card:objectName() == "thunder_slash" then
--                 se.nature = sgs.DamageStruct_Thunder
--             elseif use.card:objectName() == "ice_slash" then
--                 se.nature = sgs.DamageStruct_Ice
--             end
--             if use.from:getMark("drank") > 0 then
--                 room:setCardFlag(use.card, "drank")
--                 use.card:setTag("drank", sgs.QVariant(use.from:getMark("drank")))
--             end
--             se.drank = use.card:getTag("drank"):toInt()
--             room:slashEffect(se)
--         end
--     else
--         use.card:use(room, use.from, use.to)
--     end
--     return false
-- end
-- }

-- jizhanw = sgs.CreatePhaseChangeSkill{
-- name = "jizhanw",
-- on_phasechange = function(self, player)
--     if player:getPhase() ~= sgs.Player_Draw or not player:askForSkillInvoke(self) then return false end
--     local room = player:getRoom()
--     room:broadcastSkillInvoke(self)
    
--     local gets = sgs.IntList()
--     local ids = room:showDrawPile(player, 1, self:objectName())
--     gets:append(ids:first())
--     local num = sgs.Sanguosha:getEngineCard(ids:first()):getNumber()
    
--     while player:isAlive() do
--         local choices = {}
--         table.insert(choices, "more=" .. num)
--         table.insert(choices, "less=" .. num)
--         table.insert(choices, "cancel")
--         local choice = room:askForChoice(player, self:objectName(), table.concat(choices, "+"), sgs.QVariant(num))
--         if choice == "cancel" then break end
        
--         ids = room:showDrawPile(player, 1, self:objectName())
--         gets:append(ids:first())
--         local next_num = sgs.Sanguosha:getEngineCard(ids:first()):getNumber()
--         if (next_num == num) or (next_num > num and choice:startsWith("less")) or (next_num < num and choice:startsWith("more")) then break end
--         num = next_num
--     end
    
--     local slash = sgs.Sanguosha:cloneCard("slash")
--     slash:deleteLater()
--     for _,id in sgs.qlist(gets) do
--         if room:getCardPlace(id) ~= sgs.Player_PlaceTable then continue end
--         slash:addSubcard(id)
--     end
    
--     if slash:subcardsLength() > 0 then
--         if player:isDead() then
--             local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_NATURAL_ENTER, player:objectName(), self:objectName(), "")
--             room:throwCard(slash, reason, nil)
--             return true
--         end
--         room:obtainCard(player, slash)
--     end
--     return true
-- end
-- }

-- fusong = sgs.CreateTriggerSkill{
-- name = "fusong",
-- events = sgs.Death,
-- can_trigger = function(self, player)
--     return player and player:hasSkill(self)
-- end,
-- on_trigger = function(self, event, player, data, room)
--     local death = data:toDeath()
--     if death.who:objectName() ~= player:objectName() then return false end
    
--     local players = sgs.SPlayerList()
--     local max_hp = player:getMaxHp()
--     for _,p in sgs.qlist(room:getOtherPlayers(player)) do
--         if p:getMaxHp() <= max_hp then continue end
--         players:append(p)
--     end
    
--     if players:isEmpty() then return false end
--     local target = room:askForPlayerChosen(player, players, self:objectName(), "@fusong-invoke", true, true)
--     if not target then return false end
--     room:broadcastSkillInvoke(self)
    
--     local skills = {}
--     if not target:hasSkill("fengzi", true) then table.insert(skills, "fengzi") end
--     if not target:hasSkill("jizhanw", true) then table.insert(skills, "jizhanw") end
--     if #skills == 0 then return false end
--     local skill = room:askForChoice(target, self:objectName(), table.concat(skills, "+"))
--     room:acquireSkill(target, skill)
--     return false
-- end
-- }

-- ol_wangrong:addSkill(fengzi)
-- ol_wangrong:addSkill(fengziDouble)
-- ol_wangrong:addSkill(jizhanw)
-- ol_wangrong:addSkill(fusong)
-- extension:insertRelatedSkills("fengzi", "#fengziDouble")


sgs.LoadTranslationTable{
    ["kuangshouren"] = "狂兽人",
    ["kuangshou"] = "狂兽",
    [":kuangshou"] = "<font color=\"blue\"><b>锁定技</b></font>，你的装备牌均视为【杀】，你的牌对攻击范围外的角色无效，你的【杀】伤害始终为2。",
    ["bingju"] = "病毒狙击手",
    ["yuanshe"] = "远射",
    [":yuanshe"] = "<font color=\"blue\"><b>锁定技</b></font>，你的【杀】无距离限制。",
    ["bingdu"] = "病毒",
    [":bingdu"] = "当你的【杀】造成伤害后，你可以弃置一张手牌并免除此伤害，令其获得一个“病毒”标记。",
    ["infection"] = "感染",
    [":infection"] = "<font color=\"blue\"><b>锁定技</b></font>，一名角色的回合开始阶段，若其拥有“病毒”标记，增加一个“病毒”标记，若一名角色的“病毒”标记大于等于其体力值，该角色流失“病毒”标记数等量的体力，然后将“病毒”标记随机分配给自己及相邻角色。当一名角色使用【桃】时，移除其全部“病毒”标记。",
    ["kuangfengtank"] = "狂风坦克",
    ["huopao"] = "火炮",
    [":huopao"] = "<font color=\"blue\"><b>锁定技</b></font>，当你造成伤害时，弃置一张“弹药”牌，受伤角色须弃置一张牌，然后你进行判定，若为黑色，此伤害-1，若为红色，你此伤害+1且视为火属性。",
    ["nianya"] = "碾压",
    [":nianya"] = "出牌阶段限一次，你可以与一名与你距离为1的角色拼点，若你赢，该角色流失1点体力。",
    ["zhanche"] = "战车",
    [":zhanche"] = "<font color=\"blue\"><b>锁定技</b></font>，你登场时，展示与体力值相同张牌置于武将牌上称为“弹药”，若你没有“弹药”牌，你造成的伤害-1，黑色非属性【杀】对你无效。",
    ["gaitetank"] = "盖特坦克",
    ["jipao"] = "机炮",
    [":jipao"] = "当你使用【杀】时，可令目标展示一张手牌，若如此做，你须弃置一张手牌或“弹药”牌，若此牌与展示牌颜色相同，视为对一名不同角色使用一张【杀】。",
    ["naoche"] = "精神控制车",
    ["zhunao"] = "主脑",
    [":zhunao"] = "<font color=\"blue\"><b>锁定技</b></font>，当一名其他角色的回合开始时，你须流失一点体力，其本回合改为由你操控。",
    ["xiufu"] = "修复",
    [":xiufu"] = "<font color=\"blue\"><b>锁定技</b></font>，你的回合结束阶段，进行一次判断，若为黑桃，你回复一点体力。",
    ["feidie"] = "镭射幽浮",
    ["xuanfu"] = "悬浮",
    [":xuanfu"] = "<font color=\"blue\"><b>锁定技</b></font>，其他角色与你计算距离时+4。",
    ["youli"] = "尤里X",
    ["xinkong"] = "心控",
    [":xinkong"] = "出牌阶段限一次，你可以操控一名其他角色进行一个额外的回合。",
    ["naobo"] = "脑波",
    [":naobo"] = "出牌阶段限一次，你可以令与你相邻的全部角色流失一点体力。",
    ["zhoushan"] = "周善",
    ["~zhoushan"] = "周善",
    ["duozi"] = "夺子",
    [":duozi"] = "每回合限一次，你可以弃置一张手牌，选择场上一张点数小于此牌的装备，当作一张基本牌使用或打出。",
    ["tianxu"] = "田续",
    ["~tianxu"] = "田续",
    ["#tianxu"] = "奸贼之手",
    ["zhusha"] = "诛杀",
    [":zhusha"] = "当一名体力值为1的角色受到伤害时，你可弃置X张不同花色手牌并自减X点体力，若如此做该角色所受伤害+X，并且其脱离濒死状态后对你造成一点伤害。",
    ["wifemi"] = "糜夫人",
    ["~wifemi"] = "糜夫人",
    ["#wifemi"] = "烽烟碎玉",
    ["xieyou"] = "携幼",
    ["nichang"] = "霓裳",
    ["yuyi"] = "羽衣",
    [":xieyou"] = "游戏开始时，你装备【阿斗】。回合结束或有人死亡时，你可额外发动一次“教子”。",
    [":nichang"] = "<font color=\"blue\"><b>锁定技</b></font>，回合外当你需要打出【杀】/【闪】时，你重复判定，直到：出现与场上装备区点数差异小于等于你已损失的体力值：流失一半体力（向下取整至少为1）；已出现花色包括了场上装备区所有花色：获得其中一张基本牌。",
    [":yuyi"] = "当一名与你相邻的角色成为黑色基本牌/非延时锦囊的唯一目标时，你可与其摸共计X张牌，若如此做你也成为此牌的目标，结算后你与其共计弃置Y张手牌。X为你与其当前体力较小值，Y为较大值，分配方式由对方选择。",
    ["edou"] = "阿斗",
    ["hufu"] = "护符",
    [":edou"] = "教子：出牌阶段限一次，你可展示至少一张手牌并置于【阿斗】牌上称为“护符”，并向【阿斗】中添加一个你拥有的技能；或弃一张“护符”将当前技能替换为【阿斗】牌上的一项技能；或将【阿斗】及“护符”置于其他角色的装备区，可指定一项技能替换原有技能。<font color=\"blue\"><b>锁定技</b></font>：“护符”不允许数量超过你的体力值或有点数重复，当你的牌点数与“护符”点数有重复时，视为A；你成为【过河拆桥】/【顺手牵羊】目标时，若你有“护符”，使用者只能从“护符”中选择弃置或获得牌。你装备【阿斗】时，摸2张牌；你卸载【阿斗】时，流失一点体力，失去其全部效果。",
    ["#edouSkillInput"] = "%from 将技能【%arg】放入【阿斗】中",
    ["#edouSkillOrder"] = "%from 令 %to 获得技能【%arg】",
    ["#edouSkillEmpty"] = "%from 未向 %to 指定技能",
    ["duyou"] = "督邮",
    ["~duyou"] = "督邮",
    ["#duyou"] = "监察九州",
    ["xuncha"] = "巡查",
    [":xuncha"] = "<font color=\"blue\"><b>锁定技</b></font>，手牌数超过其体力上限的其他角色，武将牌正面朝上时，其与其他角色计算距离时+X，其他角色与其计算距离时-X（X为其手牌数-其体力值）",
    ["huilu"] = "贿赂",
    ["@huilu"] = "贿赂",
    [":huilu"] = "其他角色可以于其回合开始阶段交给你一半手牌（向下取整，至少一张）并于此回合不受【巡查】影响。",
    ["zhizui"] = "纸醉",
    [":zhizui"] = "若你的手牌数超过你的体力上限，其他的角色每回合限一次，出牌阶段可以弃掉全部手牌，令你展示手牌，其选择并获得其中的至多X张【杀】或武器牌，X为其弃牌数量，然后你与其将武将牌翻面。",
    ["jinmi"] = "金迷",
    [":jinmi"] = "<font color=\"blue\"><b>锁定技</b></font>，你的武器牌视为【借刀杀人】。",
    ["shenzhangjiao"] = "神张角",
    ["#shenzhangjiao"] = "黄天",
    ["fushui"] = "符水",
    [":fushui"] = "弃牌阶段开始时，你可以将X张手牌正面朝上置于武将牌上，称为【符】（X为你已损失的体力值），回合开始阶段，你将【符】收为手牌。你的回合外，当你需要使用或打出【符】中的牌时，你可以使用或打出之，若如此做，你可令一名其他角色回复一点体力。",
    ["leicai"] = "雷裁",
    [":leicai"] = "当一名角色于其出牌阶段摸牌时，需展示，若点数不为A，则记录其点数。若其点数与之前已记录点数，或【符】牌的点数有重复，你可令该角色受到2点无来源雷属性伤害。回合结束时清除记录。",
    ["tiangong"] = "天公",
    [":tiangong"] = "<font color=\"blue\"><b>锁定技</b></font>，你受到的雷属性伤害最多为1。",
    ["huai"] = "坏包",
    ["dabusi"] = "打不死",
    ["#dabusi"] = "不朽之躯",
    ["jiexusheng"] = "界徐盛",
    ["$jiexusheng"] = "徐盛",
    ["#jiexusheng"] = "江东的铁壁",
    ["#jiexushengPojunDamage"] = "%to 犯大吴疆土，%from 对其伤害+1",
    ["~jiexusheng"] = "盛只恨，不能再为主公，破敌致胜了……",
    ["jiexushengPojun"] = "破军",
    ["#jiexushengPojunHit"] = "破军",
    ["$jiexushengPojun1"] = "犯大吴疆土者，盛必击而破之。",
    ["$jiexushengPojun2"] = "若敢来犯，必叫你大败而归。",
    [":jiexushengPojun"] = "当你使用【杀】指定一个目标后，你可以将其至多X张牌扣置于该角色的武将牌旁（X为其体力值），若如此做，当前回合结束后，该角色获得这些牌。当你使用【杀】对手牌数与装备数均不大于你的角色造成伤害时，此伤害+1。",
    ["#LianliConnection"] = "%fromlianli！！%to",
    ["caojinyu"] = "曹金玉",
    ["#caojinyu"] = "金乡公主",
    ["~caojinyu"] = "平叔之情，吾岂不明。",
    ["Yuqi"] = "隅泣",
    [":Yuqi"] = "每回合限两次，当你距离0以内的一名角色受到伤害后，你可以观看牌堆顶的三张牌，将其中至多一张牌交给受伤角色，获得至多一张牌，剩余的牌放回牌堆顶。",
    ["$Yuqi1"] = "孤影独泣，困于隅角。",
    ["$Yuqi2"] = "向隅而泣，黯然伤感。",
    ["@Yuqi1"] = "隅泣（距离）",
    ["@Yuqi2"] = "隅泣（亮牌）",
    ["@Yuqi3"] = "隅泣（交出）",
    ["@Yuqi4"] = "隅泣（获得）",
    ["yuqirange"] = "增加隅泣范围",
    ["yuqiget"] = "增加隅泣亮牌",
    ["yuqigive"] = "增加隅泣交牌",
    ["yuqitake"] = "增加隅泣得牌",
    ["@Yuqi5"] = "隅泣（伤害）",
    ["@Yuqi6"] = "隅泣",
    ["Shanshen"] = "善身",
    [":Shanshen"] = "当有角色死亡时，你可令“隅泣”中的一个数字+2。然后若你未对其造成过伤害，你回复1点体力。",
    ["$Shanshen1"] = "好善为德，坚守本心。",
    ["$Shanshen2"] = "洁身自爱，独善其身。",
    ["Xianjing"] = "娴静",
    [":Xianjing"] = "准备阶段，你可令“隅泣”中的一个数字+1。若你未受伤，你可再令“隅泣”中的一个数字+1。",
    ["$Xianjing1"] = "文静闲丽，举止柔美。",
    ["$Xianjing2"] = "娴静淡雅，温婉穆穆。",
    ["shendiaochan"] = "神貂蝉",
    ["#shendiaochan"] = "欲界非天",
    ["~shendiaochan"] = "父亲大人，对不起！",
    ["huoxinpindian"] = "惑心拼点",
    ["@Mei"] = "魅惑",
    ["#Huoxin"] = "惑心",
    ["luanosrende"] = "惑心",
    [":luanosrende"] = "出牌阶段限一次，你可以展示两张花色相同的手牌并分别交给两名其他角色，然后令这两名角色拼点，没赢的角色获得1个“魅惑”标记。拥有2个或更多“魅惑”的角色回合即将开始时，该角色移去其所有“魅惑”，此回合改为由你操控。",
    ["LuaKanpo"] = "无懈可击",
    [":LuaKanpo"] = "操控其他武将期间，你仍可使用牌。",
    ["meihun"] = "魅魂",
    ["meihunCard"] = "魅魂",
    ["~meihun"] = "魅魂",
    ["#meihunsuit"] = "%from 声明了 %arg 作为魅魂花色",
    [":meihun"] = "结束阶段或当你成为【杀】的目标后，你可以令一名其他角色交给你一张你声明的花色的牌，若其没有，则你观看其手牌，然后弃置其中一张牌。",
    ["$luanosrende1"] = "嗯哼。",
    ["$luanosrende2"] = "夫君，你要替妾身做主啊！",
    ["$meihun1"] = "失礼啦",
    ["$meihun2"] = "羡慕吧。",
    ["zhangxiu"] = "张绣",
    ["~zhangxiu"] = "张绣",
    ["#zhangxiu"] = "北地枪王",
    ["xiongluan"] = "雄乱",
    ["@luan"] = "贝蒂小熊",
    ["$xiongluan2"] = "北地枭雄，乱世不败。",
    ["$xiongluan1"] = "雄踞宛城，虽乱世可安。",
    ["congjian"] = "从谏",
    ["$congjian1"] = "从谏良计，可得自保。",
    ["$congjian2"] = "听君谏言，去危亡，保宗祀。",
    [":xiongluan"] = "<font color=\"red\"><b>限定技</b></font>，出牌阶段，你可以废除你的判定区和装备区，然后指定一名其他角色，直到回合结束，你对其使用牌无距离和次数限制，其不能使用和打出手牌。",
    [":congjian"] = "当你成为锦囊牌的目标时，若此牌的目标数大于1，则你可以交给其中一名目标角色一张牌，然后摸一张牌。若你给出的牌是装备牌，改为摸两张牌。",
    ["mengda"] = "孟达",
    ["~mengda"] = "孟达",
    ["#mengda"] = "蜀魏无常",
    ["wuchang"] = "无常",
    ["zhuni"] = "助逆",
    ["shijiu"] = "嗜酒",
    [":wuchang"] = "<font color=\"blue\"><b>锁定技</b></font>，主公玩家不可选择孟达，且其体力值为0时，身份为魏势力内奸，1或3时为主公同势力忠臣，其他情况为魏势力反贼。",
    [":zhuni"] = "<font color=\"blue\"><b>锁定技</b></font>，若孟达出场，“杀死反贼的角色摸3张牌”的规则无效，且杀死反贼的角色需选择弃置0~3张手牌，若其弃牌不足3张，则主公须弃置剩余张数的手牌。",
    [":shijiu"] = "<font color=\"blue\"><b>锁定技</b></font>，你的红桃手牌视为【酒】。",
    ["dummy"] = "训练假人",
    ["idle"] = "标靶",
    ["ol_wangrong"] = "OL王荣",
    ["&ol_wangrong"] = "王荣",
    ["illustrator:ol_wangrong"] = "",
    ["fengzi"] = "丰姿",
    [":fengzi"] = "出牌阶段限一次，你使用基本牌或非延时类锦囊牌时，可以弃置一张同类型的手牌，令此牌的效果结算两次。",
    ["@fengzi-discard"] = "你可以弃置一张 %src 令 %arg 结算两次",
    ["jizhanw"] = "吉占",
    [":jizhanw"] = "摸牌阶段开始时，你可以放弃摸牌，展示牌堆顶的一张牌，猜测牌堆顶的下一张牌点数大于或小于此牌，然后展示之，若猜对你可重复此流程，最后你获得以此法展示的牌。",
    ["jizhanw:more"] = "点数大于%src",
    ["jizhanw:less"] = "点数小于%src",
    ["fusong"] = "赋颂",
    [":fusong"] = "当你死亡时，你可令一名体力上限大于你的角色选择获得“丰姿”或“吉占”。",
    ["@fusong-invoke"] = "你可以发动“赋颂”",
    ["$fengzi1"] = "丰姿秀丽，礼法不失",
    ["$fengzi2"] = "倩影姿态，悄然入心",
    ["$jizhanw1"] = "得吉占之兆，言福运之气",
    ["$jizhanw2"] = "吉占逢时，化险为夷",
    ["$fusong1"] = "陛下垂爱，妾身方有此位",
    ["$fusong2"] = "长情颂，君王恩",
    ["~ol_wangrong"] = "只求吾儿一生平安",
    ["chongxue"] = "御蟲少女",
    ["#chongxue"] = "御蟲�?",
    ["duoyin"] = "堕淫",
    [":duoyin"] = "<font color=\"blue\"><b>锁定技</b></font>，回合开始阶段，你进行一次判定，若不为红桃，�?回合手牌上限�?0。你脱�?�濒死时，失去�?�技能。若所有存活�?�色都拥有【堕�?】，或你死亡/失去此技能且场上无人拥有【堕�?】时，存活�?�色获得胜利�?",
    ["chongyun"] = "蟲孕",
    [":chongyun"] = "<font color=\"blue\"><b>锁定技</b></font>，摸牌阶段结束时，若你拥有“蟲”牌，你须将两张手牌（若有）�?于“蟲”中。若你的“蟲”数�?10或更多且武将牌�?�面朝上，你将�?�将牌翻�?。你将�?�将牌翻回�?�面时若“蟲”数�?10或更多，你�?�自己造成体力�?-1点火属性伤害，获得技能【堕�?】，弃置所有�?��?�，�?出所有暗�?的“蟲”牌，将所有“蟲”按以下规则从近到远明置分配：若角色A与你的距离比角色B更远，其�?分配点数之和不可大于B，剩余“蟲”牌弃置，然后若一名女性�?�色的“蟲”牌大于其体力值，其获得技能【蟲孕】�?",
    ["huanyu"] = "幻缘",
    [":huanyu"] = "你于弃牌阶�?�弃牌后，你�?以将武将牌横�?，然后场上男性�?�色�?以各�?扣置一张手牌或装�?�牌，扣�?牌的角色�?出所扣牌，点数唯一最大者横�?武将牌并获得你弃�?的牌，然后你获得所有扣�?的牌�?",
    ["yuchong"] = "御蟲",
    [":yuchong"] = "游戏开始时，你�?以�?��?�摸2张牌暗置于�?�将牌上称为“蟲”。你�?以翻开一张黑色“蟲”�?�为使用，或将一张红色“蟲”当【�?�】�?�任意�?�色使用，若如�?�做，你获得技能【蟲孕】�?",
}


chongxue = sgs.General(extension1, "chongxue", "qun", "3", false)
duoyinp = sgs.CreateProhibitSkill{
	name = "#duoyinp",
	is_prohibited = function(self, from, to, card)
        local ming = {}
        for _,c in from:getPile("chongming") do
            if sgs.Sanguosha:getCard(c):getNumber() == card:getNumber() then
                return true
            end
        end
		return false
	end
}
duoyin = sgs.CreateTriggerSkill{
    name = "duoyin",
    events = {sgs.CardsMoveOneTime, sgs.HpChanged, sgs.AskForPeachesDone, sgs.EventAcquireSkill, sgs.EventLoseSkill},
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.CardsMoveOneTime or event == sgs.HpChanged then
            if player:getPile("chongming"):length() + player:getPile("chongan"):length() > player:getHp() and not player:hasSkill("chongyun") then
                room:acquireSkill(player, "chongyun")
            end
        elseif event == sgs.AskForPeachesDone then
            if player:isAlive() then
                room:detachSkillFromPlayer(player, self:objectName())
            end
        elseif event == sgs.EventAcquireSkill then
            for _,p in sgs.qlist(room:getAllPlayers()) do
                if not p:hasSkill(self:objectName()) then return false end
            end
            return true
        elseif event == sgs.EventLoseSkill then
            for _,p in sgs.qlist(room:getAllPlayers()) do
                if p:hasSkill(self:objectName()) then return false end
            end
            return true
        end
    end
}
chongyunCard = sgs.CreateSkillCard{
	name = "chongyunCard" ,
	will_throw = false ,
	handling_method = sgs.Card_MethodNone ,
    target_fixed = true,
	on_use = function(self, room, source, targets)
		local cards = self:getSubcards()
        source:addToPile("chongan", cards, false)
	end
}
chongyunVS = sgs.CreateViewAsSkill{
	name = "chongyun" ,
    response_pattern = "@chongyun",
	n = 2,
	view_filter = function(self, selected, to_select)
		if #selected < 2 then return true end
	end,
	view_as = function(self, cards)
		if #cards < 2 then return nil end
		local rende_card = chongyunCard:clone()
		for _, c in ipairs(cards) do
			rende_card:addSubcard(c)
		end
		return rende_card
	end ,
	enabled_at_play = function(self, player)
		return false
	end
}
chanCard = sgs.CreateSkillCard{
	name = "chanCard" ,
	will_throw = false ,
	handling_method = sgs.Card_MethodNone ,
    target_fixed = true,
	on_use = function(self, room, source, targets)
		local cards = self:getSubcards()
        source:addToPile("chongan", cards, false)
	end
}
chanVS = sgs.CreateViewAsSkill{
	name = "chan" ,
    response_pattern = "@chan",
	n = 999,
	view_filter = function(self, selected, to_select)
		if #selected < 2 then return true end
	end,
	view_as = function(self, cards)
		if #cards < 2 then return nil end
		local rende_card = chongyunCard:clone()
		for _, c in ipairs(cards) do
			rende_card:addSubcard(c)
		end
		return rende_card
	end ,
	enabled_at_play = function(self, player)
		return false
	end
}
Fire = function(player,target,damagePoint)
	local damage = sgs.DamageStruct()
	damage.from = player
	damage.to = target
	damage.damage = damagePoint
	damage.nature = sgs.DamageStruct_Fire
	player:getRoom():damage(damage)
end
chongyun = sgs.CreateTriggerSkill{
    name = "chongyun",
    events = {sgs.AfterDrawNCards, sgs.CardsMoveOneTime, sgs.TurnedOver},
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if event == sgs.AfterDrawNCards then
            local to = room:askForPlayerChosen(player, room:getAllPlayers(), self:objectName(), "cyt", false)
            if to:isKongcheng() then return false end
            local id = room:askForCardChosen(player, to, "h", self:objectName())
            room:obtainCard(player, sgs.Sanguosha:getCard(id))
            room:askForUseCard(player, "@chongyunCard", self:objectName())
        elseif event == sgs.CardsMoveOneTime then
            if player:getPile("chongming"):length() + player:getPile("chongan"):length() >= 10 then
                player:turnOver()
            end
        elseif event == sgs.TurnedOver then
            if player:faceUp() and player:getPile("chongming"):length() + player:getPile("chongan"):length() >= 10 then
                player:addToPile("chongming", player:getPile("chongan"))
                Fire(player, player, player:getHp()-1)
                if not player:hasSkill("duoyin") then room:acquireSkill(player, "duoyin") end
                local move = sgs.CardsMoveStruct()
                move.to_place = sgs.Player_DiscardPile
                for _, c in sgs.qlist(player:getEquips()) do
                    move.card_ids:append(c:getEffectiveId())
                end
                room:moveCardsAtomic(move, true)
                room:askForUseCard(player, "@chanCard", self:objectName())
            end
        end
    end
}
function strcontain(a, b)
	if a == "" then return false end
	local c = a:split("+")
	local k = false
	for i=1, #c, 1 do
		if a[i] == b then
			k = true
			break
		end
	end
	return k
end
LuaGuzheng = sgs.CreateTriggerSkill{
	name = "LuaGuzheng",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardsMoveOneTime},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local player = room:getCurrent()
		local move = data:toMoveOneTime()
		local source = move.from
		if source then
			if player:objectName() == source:objectName() and player:getPhase() == sgs.Player_Discard then
                local tag = room:getTag("GuzhengToGet")
                local guzhengToGet= tag:toString()
                if guzhengToGet == nil then guzhengToGet = "" end
                for _,card_id in sgs.qlist(move.card_ids) do
                    local flag = bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON)
                    if flag == sgs.CardMoveReason_S_REASON_DISCARD then
                        if guzhengToGet == "" then guzhengToGet = tostring(card_id)
                        else guzhengToGet = guzhengToGet.."+"..tostring(card_id) end
                    end
                end
                if guzhengToGet then room:setTag("GuzhengToGet", sgs.QVariant(guzhengToGet)) end
			end
		end
		return false
	end,
}
LuaGuzhengGet = sgs.CreateTriggerSkill{
	name = "#LuaGuzhengGet",
	frequency = sgs.Skill_Frequent,
	events = {sgs.EventPhaseEnd},
	on_trigger = function(self, event, player, data)
		if not player:isDead() then
			local room = player:getRoom()
            local tag = room:getTag("GuzhengToGet")
            local guzheng_cardsToGet
            if tag then guzheng_cardsToGet = tag:toString():split("+")
            else return false end
            room:removeTag("GuzhengToGet")
            local cardsToGet = sgs.IntList()
            local cards = sgs.IntList()
            for i=1,#guzheng_cardsToGet, 1 do
                local card_data = guzheng_cardsToGet[i]
                if card_data == nil then return false end
                if card_data ~= "" then --弃牌阶�?�没弃牌则字符串�?""
                    local card_id = tonumber(card_data)
                    if room:getCardPlace(card_id) == sgs.Player_DiscardPile then
                        cardsToGet:append(card_id)
                        cards:append(card_id)
                    end
                end
            end
            if cardsToGet:length() > 0 then
                if not room:askForSkillInvoke(player, self:objectName()) then return false end
                room:setPlayerProperty(player, "chained", sgs.QVariant(true))
                while cardsToGet:length() > 0 do
                    for _,p in sgs.qlist(room:getAllPlayers()) do
                        if cardsToGet:length() < 1 then break end
                        if p:isMale() then
                            room:fillAG(cardsToGet)
                            local to_back = room:askForAG(p, cardsToGet, false, self:objectName())
                            local backcard = sgs.Sanguosha:getCard(to_back)
                            p:obtainCard(backcard)
                            room:setPlayerProperty(p, "chained", sgs.QVariant(true))
                            p:setTag("huanyu", sgs.QVariant(true))
                            cardsToGet:removeOne(to_back)
                            room:clearAG()
                        end
                    end
                end
            end
		end
		return false
	end,
}
huanyu = sgs.CreateTriggerSkill{
    name = "huanyu",
    events = {sgs.DamageCaused},
    on_trigger = function(self, event, player, data)
        if player:isChained() then
        end
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
yuchong = sgs.CreateTriggerSkill{
    name = "yuchong",
    events = {sgs.DamageInflicted},
    on_trigger = function()
    end
}
chongxue:addSkill(yuchong)
chongxue:addSkill(huanyu)
chongxue:addSkill(duoyin)
chongxue:addSkill(chongyun)


local skillList = sgs.SkillList()
local newgenerals_skills = {edou,EdouNumber,EdouDefense,EdouLimit,GetPeach,LuaKanpo}
for _,sk in ipairs(newgenerals_skills) do
	if not sgs.Sanguosha:getSkill(sk:objectName()) then
		skillList:append(sk)
	end
end
sgs.Sanguosha:addSkills(skillList)