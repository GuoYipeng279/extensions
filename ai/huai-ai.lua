-- 界徐盛暂时采用烈弓，旋风ai
sgs.ai_skill_invoke.jiexushengPojun = sgs.ai_skill_invoke.liegong
sgs.ai_skill_invoke.jiexushengPojunHit = sgs.ai_skill_invoke.liegong
sgs.ai_card_intention.jiexushengPojun = sgs.ai_card_intention.XuanfengCard



sgs.ai_skill_invoke.Yuqi = true
sgs.ai_skill_askforag.Yuqi = function(self, card_ids)
    local room = self.player:getRoom()
	local cards = {}
	for _, card_id in ipairs(card_ids) do
		table.insert(cards, sgs.Sanguosha:getCard(card_id))
	end
    self:sortByCardNeed(cards)
    if self.player:getTag("yuqigive"):toString()=="give" and 
        not self.player:isFriend(self.player:getTag("yuqigiveto"):toDamage().to) then
        local msg = sgs.LogMessage()
        msg.type = sgs.QVariant("gghere"):toString()
        room:sendLog(msg)
        if self.player:getTag("refusable"):toInt()==1 then return -1 end
        return cards[1]:getEffectiveId()
    else return cards[#cards]:getEffectiveId() end
end
sgs.ai_skill_invoke.Shanshen = true
sgs.ai_skill_invoke.Xianjing = true
sgs.ai_skill_choice.Shanshen = function(self, choices)
    if self.player:getMark("@Yuqi4")+2 <= self.player:getMark("@Yuqi2") and self.player:getMark("@Yuqi4") < 4 then return "yuqitake" end
    if self.player:getMark("@Yuqi1") <= self.player:getMark("@Yuqi2") and self.player:getMark("@Yuqi1") < 4 then return "yuqirange" end
    if self.player:getMark("@Yuqi2") < 4 then return "yuqiget" end
    return sgs.ai_skill_choice.Xianjing(self, choices)
end
sgs.ai_skill_choice.Xianjing = function(self, choices)
    -- self.player:drawCards(1)
    -- self.player:drawCards(self.player:getMark("@Yuqi4")+1)
    if self.player:getMark("@Yuqi4")+1 <= self.player:getMark("@Yuqi2") and self.player:getMark("@Yuqi4") < 5 then return "yuqitake" end
    -- self.player:drawCards(1)
    if self.player:getMark("@Yuqi1") <= self.player:getMark("@Yuqi2") and self.player:getMark("@Yuqi1") < 5 then return "yuqirange" end
    -- self.player:drawCards(1)
    if self.player:getMark("@Yuqi2") < 5 then return "yuqiget" end
    -- self.player:drawCards(1)
    return "yuqigive"
end




sgs.ai_skill_invoke.meihun = function(self, data)
    return #self.enemies > 0
end
sgs.ai_skill_use["@meihun"] =function(self)
    -- local room = self.player:getRoom()
    for _, p in ipairs(self:getEnemies(self.player)) do
        if not p:isKongcheng() then 
            return "#meihunCard:.:->"..p:objectName()
        end
    end
    return nil
end
sgs.ai_skill_suit.meihunCard = function(self)
    if self.player:getHp() <= 1 and self.player:getPhase() ~= sgs.Player_Finish and not #self.friends_noself == 0 then return sgs.Card_Diamond end
    if self.player:getHp() <= 2 then return sgs.Card_Heart end
    if self.player:getPhase() ~= sgs.Player_Finish then return sgs.Card_Diamond end
	local all_cards = self.player:getCards("h")
    suits = sgs.IntList()
	for _, card in sgs.qlist(all_cards) do suits:append(card:getSuit()) end
    if suits:contains(sgs.Card_Heart) then return sgs.Card_Heart end
    if suits:contains(sgs.Card_Diamond) then return sgs.Card_Diamond end
    if suits:contains(sgs.Card_Spade) then return sgs.Card_Spade end
    if suits:contains(sgs.Card_Club) then return sgs.Card_Club end
end
sgs.ai_playerchosen_intention.meihun = function(self)
    if self.player:getHp() <= 1 and self.player:getPhase() ~= sgs.Player_Finish then return -80 end
    return 80
end
sgs.ai_skill_use_func["#meihunCard"] = function(card, use, self)
    local lis
    if self.player:getHp() <= 1 and self.player:getPhase() ~= sgs.Player_Finish and self.friends_noself > 0 then
        self:sort(self.friends_noself,"handcard", true)
        lis = self.friends_noself
    else
        self:sort(self.enemies,"handcard", true)
        lis = self.enemies
    end
	if lis then
		if use.to then use.to:append(lis[1]) end
	end
	use.card = card
	return
end

local rende_skill = {}
rende_skill.name = "luanosrende"
table.insert(sgs.ai_skills, rende_skill)
rende_skill.getTurnUseCard = function(self)
    if self.player:hasUsed("#luanosrendeCard") then return end
    if #(self.enemies) < 1 then return end
    local room = self.player:getRoom()
    if room:getAllPlayers():length() <= 2 then return end
	-- local archery = sgs.Sanguosha:cloneCard("archery_attack")
	local first_found, second_found = false, false
	local first_card, second_card
	if self.player:getHandcardNum() >= 2 then
		local cards = self.player:getHandcards()
		local same_suit = false
		cards = sgs.QList2Table(cards)
		self:sortByKeepValue(cards)
		local useAll = true
        local archeryattack = nil
		for _, fcard in ipairs(cards) do
            for _, scard in ipairs(cards) do
                if fcard ~= scard and scard:getSuit() == fcard:getSuit() then
                    local card_str = ("#luanosrendeCard:%d+%d:"):format(fcard:getId(), scard:getId())
                    archeryattack = sgs.Card_Parse(card_str)
                    return archeryattack
                end
            end
		end
	end
end

sgs.ai_playerchosen_intention.luanosrende = 10
sgs.ai_use_priority.luanosrendeCard = 100
sgs.ai_skill_use_func["#luanosrendeCard"] = function(card, use, self)
	self:sort(self.enemies, "huoxin") -- 按手牌数从小到大排序
	if self.enemies[1] and use.to then
        use.to:append(self.enemies[1])
        if self.enemies[2] and use.to then
            use.to:append(self.enemies[2])
        else
            local players = self.player:getRoom():getAllPlayers()
            for _,p in sgs.qlist(players) do
                if p ~= self.player and p ~= self.enemies[1] then
                    use.to:append(p)
                end
            end
        end
	end
    use.card = card
	return
end




sgs.ai_playerchosen_intention.congjian = -80
sgs.ai_skill_cardask["@congjian"] = function(self, data)
	local all_cards = self.player:getCards("h")
	for _, card in sgs.qlist(all_cards) do
        if card:getTypeId() == sgs.Card_TypeEquip then return card:getEffectiveId() end
    end
end

local xiongluan_skill = {}
xiongluan_skill.name = "xiongluan"
table.insert(sgs.ai_skills, xiongluan_skill)
xiongluan_skill.getTurnUseCard = function(self, inclusive)
	if self.player:getMark("@xiongluan") >= 1 then
		return sgs.Card_Parse("#XiongluanCard:.:")
	end
end

sgs.ai_skill_use_func["#XiongluanCard"] = function(card, use, self)
	local target = nil
	local cards = sgs.QList2Table(self.player:getCards("h"))
	self:sort(self.enemies, "hp")
	local slashes = self:getCards("Slash")
	if #slashes < 1 then return end
	for _, enemy in ipairs(self.enemies) do
		local n = 0
		for _, slash in ipairs(slashes) do
			if self.player:canSlash(enemy, slash, false) and sgs.isGoodTarget(enemy, self.enemies, self, true) 
				and self:slashIsEffective(slash, enemy, self.player) and not (self:hasEightDiagramEffect(enemy) and not IgnoreArmor(self.player, enemy)) then
					n = n + 1
					if n >= enemy:getHp() then target = enemy break end
			end
		end
		if target then break end
	end
	if target == nil then return end
	use.card = card
	if use.to then use.to:append(target) end
end

sgs.ai_use_priority.XiongluanCard = sgs.ai_use_priority.Slash + 0.1
sgs.ai_use_value.XiongluanCard = 3


sgs.ai_skill_invoke.huilu = function(self, data)
    local room = self.player:getRoom()
    if self.player:hasSkill("huilu") then return false end
    local duyou
    for _,p in sgs.qlist(room:getOtherPlayers(self.player)) do
        if p:hasSkill("huilu") then duyou = p end
    end
    if self:isFriend(duyou) then
        return self.player:getHandcardNum() > self.player:getMaxHp()
    else return false end
end

sgs.ai_skill_use["@@huilu"] = function(self, prompt)
    local room = self.player:getRoom()
    local cards = self.player:getHandcards()
    cards = sgs.QList2Table(cards)
    self:sortByUseValue(cards,true)
    local card_ids = {}
    for i=1, math.floor(#cards/2) do
        table.insert(card_ids, cards[i]:getEffectiveId())
    end

    return "#huiluCard:" .. table.concat(card_ids, "+") .. ":"
end


local zhizui_skill = {}
zhizui_skill.name = "zhizui"
table.insert(sgs.ai_skills, zhizui_skill)
zhizui_skill.getTurnUseCard = function(self, inclusive)
	return not self.player:hasUsed('#zhizuiCard') and not self.player:hasSkill("huilu") and sgs.Card_Parse("#zhizuiCard:.:")
end
sgs.ai_skill_use_func["#zhizuiCard"] = function(card, use, self)
    local duyou = self.room:findPlayerBySkillName("huilu")
	local target = nil
	self:sort(self.enemies, "distance")
	if self.player:getHandcardNum() < 3 or duyou:getHandcardNum() < 7 or self.player:getMark("@huilu") > 0 then return end
	for _, enemy in ipairs(self.enemies) do
		if math.min(duyou:getHandcardNum()/3,self.player:getHandcardNum()) >= enemy:getHp()+enemy:getHandcardNum()/3 and
        not (self:hasEightDiagramEffect(enemy) and not IgnoreArmor(self.player, enemy))
         then target = enemy break end
	end
	if target == nil then return end
	use.card = card
	-- if use.to then use.to:append(target) end
end

sgs.ai_skill_askforag.zhizui = function(self, card_ids)
    return card_ids:at(0)
end
    



sgs.ai_skill_invoke.yuyi = function(self, data)
    local use = data:toCardUse()
    if not self:isFriend(use.to:at(0)) or not use.to:at(0):isAlive() then return false end
    local proxi_draw = math.min(use.to:at(0):getHp(), self.player:getHp())
    local proxi_discard = math.min(math.max(use.to:at(0):getHp(), self.player:getHp()),
        math.min(use.to:at(0):getHandcardNum(), self.player:getHandcardNum()))
    -- self.player:drawCards(2)
    return proxi_draw > proxi_discard
end

sgs.ai_skill_choice.yuyi = function(self, choices)
    local choices = choices:split("+")
    -- pt(self.player:getRoom(), type(choices))
    -- pt(self.player:getRoom(), "choicing"..self.player:getTag("yuyiDecide"):toString())
    if self.player:getTag("yuyiDecide"):toString() == "true" then
        return choices[#choices]
    else
        -- pt(self.player:getRoom(), "choicemin")
        return choices[1]
    end
    -- return sgs.QVariant(math.max(1,#choices:split("+")-2)):toString()
end

sgs.ai_skill_choice.edouCard = function(self, choices)
    local lis = choices:split("+")
    if table.contains(lis, "nichang") and self.player:getPile("hufu") < 3 then
        table.remove(lis, "nichang")
        choices = table.concat(lis, "+")
    end
    return sgs.ai_skill_choice.huashen(self, choices)
end
sgs.ai_skill_choice.edou = sgs.ai_skill_choice.huashen
sgs.ai_use_value.Edou = 7
sgs.ai_keep_value.Edou = 6
local edou_skill = {}
edou_skill.name = "edou"
table.insert(sgs.ai_skills, edou_skill)
edou_skill.getTurnUseCard = function(self)
    if self.player:getPhase() == sgs.Player_Play and self.player:hasUsed("#edouCard") or self.player:hasUsed("#edouGiveCard") or self.player:hasUsed("#edouChangeCard") then return end
    if not self.player:isAlive() then return edouGive:clone() end
    local room = self.player:getRoom()
	-- local archery = sgs.Sanguosha:cloneCard("archery_attack")
    local like = {}
    if self.player:hasSkill("nichang") then
        -- 按照先选取场上武器，再从常见武器点数中选取
        liko = {1,13,2,3,5,12,6}
        local numbers = {}
        for i=1, 13 do table.insert(numbers,false) end
        for _,p in sgs.qlist(room:getAllPlayers()) do
            for _,e in sgs.qlist(p:getEquips()) do
                numbers[e:getNumber()] = true
            end
        end
        for i,n in ipairs(numbers) do
            if n then table.insert(like, i) end
        end
        for _,lik in ipairs(liko) do
            if not table.contains(like, lik) then table.insert(like, lik) end
        end
    end
	if not self.player:isKongcheng() and self.player:getHp() > self.player:getPile("hufu"):length() then
		local cards = self.player:getHandcards()
		cards = sgs.QList2Table(cards)
		self:sortByKeepValue(cards)
		local useAll = true
        local archeryattack = nil
        local subcards = {}
        local pile = sgs.IntList()
        for _, c in sgs.qlist(self.player:getPile("hufu")) do
            pile:append(sgs.Sanguosha:getCard(c):getNumber())
        end
        local msg = sgs.LogMessage()
        for i, n in ipairs(like) do
            if pile:contains(n) then continue end
            for j, fcard in ipairs(cards) do
                if fcard:getNumber() ~= n then continue end
                if #subcards + pile:length() > self.player:getHp()*1.3 then break end
                if not pile:contains(fcard:getNumber()) then
                    table.insert(subcards, fcard:getId())
                    break
                end
            end
        end
        if #subcards == 0 then table.insert(subcards, cards[1]:getId()) end
        local card_str = "#edouCard:"..table.concat(subcards,"+")..":"
        archeryattack = sgs.Card_Parse(card_str)
        return archeryattack
	end
end

sgs.ai_use_priority.edouGiveCard = 0
sgs.ai_use_priority.edouCard = 100
sgs.ai_skill_use_func["#edouGiveCard"] = function(card, use, self)
    local possible_list = self.friends_noself
    local to
    local min_wound, max_hp = 999, 0
    for _,p in ipairs(possible_list) do
        local wound, hp = p:getLostHp(), p:getHp()
        if wound < min_wound then
            to = p 
            min_wound = wound
        end
        if wound == min_wound then
            if hp > max_hp then
                to = p
                max_hp = hp
            end
        end
    end
	if to and use.to then
        use.to:append(to)
    else return end
    use.card = card
end
sgs.ai_skill_use_func["#edouCard"] = function(card, use, self)
    use.card = card
end
sgs.ai_skill_use["@edou"] = function(self)
    -- 检查霓裳负面效果
    local possible_list = self.friends_noself
    if not self.player:isAlive() then
        local to = nil
        local max_hp = 999, 0
        for _,p in ipairs(possible_list) do
            if not p:isWounded() and hp > max_hp then
                to = p
                max_hp = hp
            end
        end
        if to ~= nil then return "#edouGiveCard:.:->"..to:objectName() end
    end
    return nil
end
pt = function(room, x)
    local msg = sgs.LogMessage()
    msg.type = x
    room:sendLog(msg)
end
sgs.ai_skill_askforag.nichang = function(self, card_ids)
	local kind
    local room = self.player:getRoom()
    if self.player:getTag("nichang"):toString() == "slash" then kind = "Slash" end
    if self.player:getTag("nichang"):toString() == "jink" then kind = "Jink" end
    local have = false
    for _,c in sgs.qlist(self.player:getHandcards()) do
        if c:isKindOf(kind) then have = true break end
    end
    local id = -1
    for _,c in sgs.list(card_ids) do
        -- pt(room, "ncag2"..sgs.Sanguosha:getCard(c):objectName())
        if sgs.Sanguosha:getCard(c):isKindOf(kind) then id = c break end
    end
    if have or id == -1 then
        self:sortByCardNeed(card_ids)
        return card_ids[#card_ids]:getEffectiveId()
    else
        return id
    end
end