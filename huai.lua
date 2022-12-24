module("extensions.huai", package.seeall)

extension = sgs.Package("huai")
dabusi = sgs.General(extension, "dabusi", "god")
--界徐盛
jiexusheng = sgs.General(extension, "jiexusheng", "wu")
LuaYingzi = sgs.CreateTriggerSkill{
	name = "LuaYingzi",
	frequency = sgs.Skill_Frequent,
	events = {sgs.DrawNCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:askForSkillInvoke(player, "LuaYingzi", data) then
            sgs.Sanguosha:playSkillAudioEffect(self:objectName(),0)
			local count = data:toInt() -2
			data:setValue(count)
		end
	end
}
jiexushengPojun = sgs.CreateTriggerSkill{
    name = "jiexushengPojun",
    events = {sgs.TargetConfirmed},
    -- if frequent, then dont ask for fadong
    frequency = sgs.Skill_NotFrequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local use = data:toCardUse()
        local player = use.from
        if use.card:isKindOf("Slash") and player:hasSkill(self:objectName()) then
            sgs.Sanguosha:playSkillAudioEffect("jiexushengPojun",2)
            for i = 0, use.to:length()-1 do
                local to = use.to:at(i)
                for j = 0, to:getHp()-1 do
                    -- use.to:at(i):drawCards(use.to:at(i):getHandcardNum())
                    if to:isNude() then break end
                    if player:getPhase() == sgs.Player_Play or room:askForSkillInvoke(player, self:objectName(), data) then
                        local id = room:askForCardChosen(player, to, "he", self:objectName())
                        to:addToPile("pojun", id, false)
                    else break end
                end
            end
        end
    end
}
jiexushengPojunHit = sgs.CreateTriggerSkill{
    name = "#jiexushengPojunHit",
    events = {sgs.DamageCaused},
    -- if frequent, then dont ask for fadong
    frequency = sgs.Skill_NotFrequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local damage = data:toDamage()
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
    end,
}
jiexushengPojunBack = sgs.CreatePhaseChangeSkill{
    name = "#jiexushengPojunBack",
    frequency = sgs.Skill_Compulsory, 
	on_phasechange = function(self, player)
		if player:getPhase() == sgs.Player_Finish then
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
	end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
jiexusheng:addSkill(jiexushengPojun)
jiexusheng:addSkill(jiexushengPojunHit)
jiexusheng:addSkill(jiexushengPojunBack)
-- jiexusheng:addSkill("yingzi")
-- jiexusheng:addSkill(LuaYingzi)

caojinyu = sgs.General(extension, "caojinyu", "wei", "3", false)
YuqiInit = sgs.CreateTriggerSkill{
    name = "#YuqiInit",
    events = {sgs.GameStart},
    frequency = sgs.Skill_Compulsory,
    on_trigger = function(self, event, player, data)
        player:gainMark("@Yuqi2",3)
        player:gainMark("@Yuqi3",1)
        player:gainMark("@Yuqi4",1)
        player:loseSkill(self:objectName())
    end
}
YuqiDamage = sgs.CreateTriggerSkill{
    name = "#YuqiDamage",
    events = {sgs.Damage},
    frequency = sgs.Skill_Compulsory,
    on_trigger = function(self, event, player, data)
        local damage = data:toDamage()
        if not damage.to:isAlive() or not damage.from:hasSkill(self:objectName()) then return end
        if damage.to:getMark("@Yuqi5")==0 then damage.to:gainMark("@Yuqi5",1) end
    end
}
Yuqi = sgs.CreateTriggerSkill{
    name = "Yuqi",
    events = {sgs.Damaged},
    frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local damage = data:toDamage()
        for _, caojinyu in sgs.qlist(room:getAllPlayers()) do
            if not caojinyu or caojinyu:isDead() or not caojinyu:hasSkill(self:objectName()) or caojinyu:getMark("@Yuqi6")>=2 then continue end
            -- damage.to:drawCards(1)
            if caojinyu:distanceTo(damage.to) <= caojinyu:getMark("@Yuqi1") and room:askForSkillInvoke(caojinyu, self:objectName(), data) then
                -- damage.to:drawCards(2)
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
                -- self.y1 = 5 一定不要这样写，无法赋值
                for i=1, caojinyu:getMark("@Yuqi3") do
                    local card_id = room:askForAG(caojinyu, card_ids, caojinyu:getTag("yuqirefusable"):toInt()==1, self:objectName())
                    caojinyu:setTag("yuqirefusable", sgs.QVariant(1))
                    -- local msg = sgs.LogMessage()
                    -- msg.type = sgs.QVariant(card_id):toString()
                    -- room:sendLog(msg)
                    -- caojinyu:drawCards(card_id+5)
                    if card_id == -1 then break end
                    room:clearAG()
                    card_ids:removeOne(card_id)
                    room:obtainCard(damage.to, card_id)
                    room:fillAG(card_ids)
                    if card_ids:isEmpty() then break end
                end
                caojinyu:setTag("yuqigive", sgs.QVariant("notgive"))
                if card_ids:isEmpty() then 
                    room:clearAG()
                    return false 
                end
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
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
YuqiClear = sgs.CreatePhaseChangeSkill{
    name = "#YuqiClear",
    frequency = sgs.Skill_Compulsory,
	on_phasechange = function(self, player)
        if player:getPhase() == sgs.Player_Finish then
            local room = player:getRoom()
			local all_players = room:getAllPlayers()
			for _, p in sgs.qlist(all_players) do
                p:loseAllMarks("@Yuqi6")
            end
        end
    end,
    can_trigger = function(self, target)
		return target ~= nil
	end
}
Shanshen = sgs.CreateTriggerSkill{
    name = "Shanshen",
	events = {sgs.Death},
    frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local all_players = room:getAllPlayers()
		local death = data:toDeath()
        for _, caojinyu in sgs.qlist(all_players) do
            if not caojinyu or caojinyu:isDead() or not caojinyu:hasSkill(self:objectName()) then continue end
            local choice = room:askForChoice(caojinyu, self:objectName(), "yuqirange+yuqiget+yuqigive+yuqitake")
            self.player = caojinyu
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
    end,
}
Xianjing = sgs.CreatePhaseChangeSkill{
    name = "Xianjing",
    frequency = sgs.Skill_Frequent,
	on_phasechange = function(self, caojinyu)
        if caojinyu:getPhase() == sgs.Player_Start then
            local room = caojinyu:getRoom()
            sgs.Sanguosha:playSkillAudioEffect(self:objectName(),math.random(2))
            -- caojinyu:drawCards(1)
            -- caojinyu:drawCards(caojinyu:getMark("@Yuqi4")+1)
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
caojinyu:addSkill(YuqiInit)
caojinyu:addSkill(YuqiDamage)
caojinyu:addSkill(YuqiClear)
caojinyu:addSkill(Shanshen)
caojinyu:addSkill(Xianjing)

shendiaochan = sgs.General(extension, "shendiaochan", "god", "3", false)
DimengCard = function(room, a,b)
    a:setFlags("DimengTarget")
    b:setFlags("DimengTarget")
    a:drawCards(1)
    b:drawCards(1)
    local n1 = a:getHandcardNum()
    local n2 = b:getHandcardNum()
    a:drawCards(1)
    b:drawCards(1)
    local exchangeMove = sgs.CardsMoveList()
    local move1 = sgs.CardsMoveStruct(a:handCards(), b, sgs.Player_PlaceHand, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, a:objectName(), b:objectName(), "dimeng", ""))
    local move2 = sgs.CardsMoveStruct(b:handCards(), a, sgs.Player_PlaceHand, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, b:objectName(), a:objectName(), "dimeng", ""))
    exchangeMove:append(move1)
    exchangeMove:append(move2)
        room:moveCardsAtomic(exchangeMove, false);
       a:setFlags("-DimengTarget")
       b:setFlags("-DimengTarget")
end
GanluCard = function(first, second)
	local room = first:getRoom()
	local equips1, equips2 = sgs.IntList(), sgs.IntList()
	for _, equip in sgs.qlist(first:getEquips()) do
		equips1:append(equip:getId())
	end
	for _, equip in sgs.qlist(second:getEquips()) do
		equips2:append(equip:getId())
	end
	local exchangeMove = sgs.CardsMoveList()
	local move1 = sgs.CardsMoveStruct(equips1, second, sgs.Player_PlaceEquip, 
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, first:objectName(), second:objectName(), "LuaGanlu", ""))
	local move2 = sgs.CardsMoveStruct(equips2, first, sgs.Player_PlaceEquip,
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SWAP, first:objectName(), second:objectName(), "LuaGanlu", ""))
	exchangeMove:append(move2)
	exchangeMove:append(move1)
	room:moveCards(exchangeMove, false)
end
MarkCard = function(first, second)
    first:drawCards(2)
    local aName = first:getMarkNames()
    local bName = second:getMarkNames()
    first:drawCards(2)
    local aNum = {}
    for name in aName do 
        aNum:append(first:getMark(name))
        first:loseAllMarks(name)
    end
    first:drawCards(2)
    local bNum = {}
    for name in bName do
        bNum:append(second:getMark(name))
        second:loseAllMarks(name)
    end
    for name in aName do 
        second:gainMark(aName, aNum)
    end
    for name in bName do 
        first:gainMark(bName, bNum)
    end
end
HuoxinEffect = function(self, effect)
    local diaochan = effect.from
    local target = effect.to
    local room = diaochan:getRoom()
    local all_players = room:getAllPlayers()
    for _, player in sgs.qlist(all_players) do
        local LuaChanyuan_skills = player:getTag("LuaChanyuanSkills"):toString():split("+")
        local skills = player:getVisibleSkillList()
        for _, skill in sgs.qlist(skills) do
            -- if skill:objectName() ~= self:objectName() and skill:getLocation() == sgs.Skill_Right and not skill:inherits("SPConvertSkill") and not skill:isAttachedLordSkill() and not (Set(LuaChanyuan_skills))[skill:objectName()] then
            room:addPlayerMark(player, "Qingcheng"..skill:objectName())
            table.insert(LuaChanyuan_skills, skill:objectName())
            -- end
        end
        player:setTag("LuaChanyuanSkills", sgs.QVariant(table.concat(LuaChanyuan_skills, "+")))
    end
    diaochan:drawCards(2)
    MarkCard(diaochan,target)
    DimengCard(room,diaochan,target)
    GanluCard(diaochan,target)
    room:swapSeat(diaochan,target)
    for _, player in sgs.qlist(all_players) do
        local LuaChanyuan_skills = player:getTag("LuaChanyuanSkills"):toString():split("+")
        for _, skill_name in ipairs(LuaChanyuan_skills) do
            room:removePlayerMark(player, "Qingcheng"..skill_name)
        end
        player:setTag("LuaChanyuanSkills", sgs.QVariant())
    end
end
HuoxinCard = sgs.CreateSkillCard{
    name = "HuoxinCard",
	on_effect = HuoxinEffect,
}
Huoxin = sgs.CreateViewAsSkill{
    name = "Huoxin",
    n = 0,
    view_as = function()
		return HuoxinCard:clone()
	end ,
	enabled_at_play = function(self, player)
		return not player:hasUsed("#HuoxinCard")
	end
}
shendiaochan:addSkill(Huoxin)


sgs.LoadTranslationTable{
    ["huai"] = "坏包",
    ["dabusi"] = "打不死",
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
}