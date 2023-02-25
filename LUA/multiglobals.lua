BandwithLevels = {}
	
-- savszelesseghatarok a livesessionbrowser listajahoz. meg a servercreation-hoz is. ha kulonbozo ertekek kellenek, az kodmunka. - CsZ
BandwithLevels[1] = 128000
BandwithLevels[2] = 200000
BandwithLevels[3] = 256000
BandwithLevels[4] = 512000
BandwithLevels[5] = 768000

PingLevelsForLobby = {}
	
-- pinghatarok a multilobby listajahoz
PingLevelsForLobby[1] = 0.2
PingLevelsForLobby[2] = 0.4
PingLevelsForLobby[3] = 0.6
PingLevelsForLobby[4] = 0.8
PingLevelsForLobby[5] = 1.0



LatencyLevel = {}

------------ latency levels, packet drops -----------
--- ezek a network kapcsolat kulonbozo szintjei, az aktualis latency (ping) alapjan allitja be, hogy most epp melyikben van.
--- minden szinthez tartozik egy Packet_Drop ertek, ami azt mutatja, hogy az eldobhato, nem garantalt csomagok hany szazalekat dobjuk el, azert, hogy ezzel csokkentsuk az adatforgalmat, es ezaltal helyreallhasson a normalis adatforgalom, a normalis ping
LatencyLevel[1]=
{
	["Latency_Min"] = 0.0,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 0.4, -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.0, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 1.0, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[2]=
{
	["Latency_Min"] = 0.35,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 0.55,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.0, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.8, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[3]=
{
	["Latency_Min"] = 0.45,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 0.75,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.1, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.7, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[4]=
{
	["Latency_Min"] = 0.65,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 1.0,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.3, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.6, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[5]=
{
	["Latency_Min"] = 0.9,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 1.4,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.4,  -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.5, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[6]=
{
	["Latency_Min"] = 1.2,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 1.8,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.5, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.4, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[7]=
{
	["Latency_Min"] = 1.5,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 2.2,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.66,   -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.4, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}
LatencyLevel[8]=
{
	["Latency_Min"] = 2.0,	 -- masodpercben. ha ennel kisebb a ping, akkor eggyel alacsonyabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN KISEBB, MINT AZ EGGYEL KISEBB LATENCY LEVEL Latency_Max ERTEKE!!!!
	["Latency_Max"] = 999.0,   -- masodpercben. ha ennel nagyobb a ping, akkor eggyel magasabb LatencyLevel-re ugrunk. EZ MINDIG LEGYEN NAGYOBB, MINT AZ EGGYEL NAGYOBB LATENCY LEVEL Latency_Min ERTEKE!!!!
	["Packet_Drop"] = 0.8, -- a nem garantalt uzenetek hany szazalekat dobjuk el. 0.0: semmit nem dobunk el, 1.0: mindet eldobjuk
	["Sync_Send_Weight"] = 0.4, -- szinkronuzenetek kuldesi gyakorisaga. 1.0 a default, ha nagyobb, surubben mennek, ha kisebb, ritkabban
}

-------- VehicleInfos
VehicleInfo = {}

------------ allied ships -------------------

-- Lexington
VehicleInfo[1]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Yorktown
VehicleInfo[2]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Hermes
VehicleInfo[3]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- KGV
VehicleInfo[9]=
{
	["FE.unit_stat_armor"] = 9,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 9,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Renown
VehicleInfo[10]=
{
	["FE.unit_stat_armor"] = 7,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Texas
VehicleInfo[13]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Atlanta
VehicleInfo[17]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 4,
	["FE.unit_stat_aapower"] = 9,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Cleveland
VehicleInfo[18]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Northampton
VehicleInfo[19]=
{
	["FE.unit_stat_armor"] = 7,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- DeRuyter
VehicleInfo[20]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 7,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- York
VehicleInfo[21]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Fletcher
VehicleInfo[23]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Clemson
VehicleInfo[25]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 3,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 5,
}

-- Elco PT
VehicleInfo[27]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 9,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 5,
}

-- Dutch PT
VehicleInfo[28]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 9,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Gato
VehicleInfo[30]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Narwhal
VehicleInfo[31]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 7,
}

-- US Oiler
VehicleInfo[35]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- US Transport
VehicleInfo[36]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- US Cargo
VehicleInfo[37]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Higgins
VehicleInfo[40]=
{
	["FE.unit_stat_armor"] = 0,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- LST mark5
VehicleInfo[41]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

------------ japanese ships -------------------


-- Akagi
VehicleInfo[50]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Kaga
VehicleInfo[51]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Hiryu
VehicleInfo[52]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Soryu
VehicleInfo[53]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Zuiho
VehicleInfo[57]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Yamato
VehicleInfo[59]=
{
	["FE.unit_stat_armor"] = 9,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 9,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Kongo
VehicleInfo[60]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Fuso
VehicleInfo[61]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Mogami
VehicleInfo[67]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 6,
}

-- Tone
VehicleInfo[68]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 4,
}

-- Takao
VehicleInfo[69]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 6,
}

-- Kuma
VehicleInfo[70]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 7,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 7,
}

-- Fubuki
VehicleInfo[73]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 9,
}

-- Minekaze
VehicleInfo[75]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 3,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 5,
}

-- Jap PT
VehicleInfo[77]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 9,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Type-B
VehicleInfo[81]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 7,
}

-- Jap Minisub
VehicleInfo[83]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 0,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Jap Oiler
VehicleInfo[85]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Jap Transport
VehicleInfo[86]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Jap Cargo
VehicleInfo[87]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Daihatsu
VehicleInfo[90]=
{
	["FE.unit_stat_armor"] = 0,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- LST type1
VehicleInfo[91]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

------------ allied planes -------------------

-- Wildcat
VehicleInfo[101]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Dauntless
VehicleInfo[108]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Swordfish
VehicleInfo[109]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Devastator
VehicleInfo[112]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Avenger
VehicleInfo[113]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- B17
VehicleInfo[116]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 5,
}

-- B25
VehicleInfo[118]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Kingfisher
VehicleInfo[121]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Catalina
VehicleInfo[125]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Buffalo
VehicleInfo[133]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Hurricane
VehicleInfo[134]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Warhawk
VehicleInfo[135]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 1,
}

------------ japanese planes -------------------

-- Zero
VehicleInfo[150]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Oscar
VehicleInfo[154]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Val
VehicleInfo[158]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Judy
VehicleInfo[159]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Kate
VehicleInfo[162]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Nell
VehicleInfo[166]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 4,
}

-- Betty
VehicleInfo[167]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 5,
}

-- Pete
VehicleInfo[171]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 2,
}

-- Jake
VehicleInfo[172]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Mavis
VehicleInfo[174]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Emily
VehicleInfo[175]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 2,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 4,
}

---- NEW UNITS ----

-- Bismarck
VehicleInfo[492]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Admiral Hipper
VehicleInfo[464]=
{
	["FE.unit_stat_armor"] = 7,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Aoba
VehicleInfo[465]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 7,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 7,
}

-- Colorado
VehicleInfo[466]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- New Mexico
VehicleInfo[467]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Pennsylvania
VehicleInfo[468]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Scharnhorst 
VehicleInfo[469]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Belfast
VehicleInfo[470]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Fiji
VehicleInfo[471]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 3,
}

-- Maass
VehicleInfo[472]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Icarus
VehicleInfo[473]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Cimarron
VehicleInfo[474]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Liberty
VehicleInfo[475]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Me 262
VehicleInfo[477]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 1,
}

-- Illustrious
VehicleInfo[478]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 3,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Warspite
VehicleInfo[476]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Richelieu
VehicleInfo[479]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Furutaka
VehicleInfo[480]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 7,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 7,
}

-- Zao
VehicleInfo[481]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 6,
}

-- Perth
VehicleInfo[482]=
{
	["FE.unit_stat_armor"] = 5,
	["FE.unit_stat_manoeuvre"] = 7,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Luppis
VehicleInfo[483]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Porter
VehicleInfo[484]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 8,
	["FE.unit_stat_artillerypower"] = 5,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 8,
}

-- Early Mogami
VehicleInfo[485]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 6,
}

-- Brooklyn
VehicleInfo[486]=
{
	["FE.unit_stat_armor"] = 6,
	["FE.unit_stat_manoeuvre"] = 6,
	["FE.unit_stat_artillerypower"] = 7,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- North Carolina
VehicleInfo[487]=
{
	["FE.unit_stat_armor"] = 9,
	["FE.unit_stat_manoeuvre"] = 3,
	["FE.unit_stat_artillerypower"] = 9,
	["FE.unit_stat_aapower"] = 7,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Nagato
VehicleInfo[488]=
{
	["FE.unit_stat_armor"] = 8,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 8,
	["FE.unit_stat_aapower"] = 5,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Yamato 1945
VehicleInfo[489]=
{
	["FE.unit_stat_armor"] = 9,
	["FE.unit_stat_manoeuvre"] = 4,
	["FE.unit_stat_artillerypower"] = 9,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Essex
VehicleInfo[490]=
{
	["FE.unit_stat_armor"] = 4,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 1,
	["FE.unit_stat_aapower"] = 6,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Zuikaku
VehicleInfo[491]=
{
	["FE.unit_stat_armor"] = 3,
	["FE.unit_stat_manoeuvre"] = 5,
	["FE.unit_stat_artillerypower"] = 0,
	["FE.unit_stat_aapower"] = 4,
	["FE.unit_stat_bombtorppower"] = 0,
}

------------ etc -------------------

-- Airfield
VehicleInfo[200]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Airfield2
VehicleInfo[201]=
{
	["FE.unit_stat_armor"] = 2,
	["FE.unit_stat_manoeuvre"] = 0,
	["FE.unit_stat_aapower"] = 2,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Shipyard
VehicleInfo[205]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

-- Airfield
VehicleInfo[206]=
{
	["FE.unit_stat_armor"] = 1,
	["FE.unit_stat_manoeuvre"] = 0,
	["FE.unit_stat_aapower"] = 1,
	["FE.unit_stat_bombtorppower"] = 0,
}

MultiLobbySettings = {} --Egy MenuElem letiltasa ird moge a kovetkezot ["MenuDIS"] = true

MultiLobbySettings[0] = {}--"MLS_PLAYERCOUNT"
MultiLobbySettings[1] = {}--"MLS_MAP"
MultiLobbySettings[2] = {--"MLS_GAMEMODE"
		[0] = { ["globals.gamemode_islandcapture"] = "FE.multi_islandcapture_desc", --["MenuDIS"] = true,
			}, 
		[1] = { ["globals.gamemode_islandcapture"] = "FE.multi_islandcapture_desc", --["MenuDIS"] = true,
			}, 
		[2] = { ["globals.gamemode_islandcapture"] = "FE.multi_islandcapture_desc", --["MenuDIS"] = true,
			}, 
		[3] = { ["globals.gamemode_islandcapture"] = "FE.multi_islandcapture_desc", --["MenuDIS"] = true,
			}, 
		[4] = {	["globals.gamemode_duel"] = "FE.multi_duel_desc", --["MenuDIS"] = true,
			},
		[5] = {	["globals.gamemode_escort"] = "FE.multi_escort_desc", --["MenuDIS"] = true,
			}, 
		[6] = { ["globals.gamemode_siege"]  = "FE.multi_siege_desc", --["MenuDIS"] = true,
			}, 
		[7] = { ["globals.gamemode_competitive"]  = "FE.multi_competitive_desc", --["MenuDIS"] = true,
			}, 
}
MultiLobbySettings[3] = {--"MLS_MAPSIZE"
	[0] = { ["FE.multi_small"]   = "FE.multi_small_desc", --["MenuDIS"] = true,
		}, 
	[1] = { ["FE.multi_medium"]   =  "FE.multi_medium_desc", ["Default"] = true, --["MenuDIS"] = true,
		}, 
	[2] = { ["FE.multi_large"]   = "FE.multi_large_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["FE.multi_huge"]   =  "FE.multi_huge_desc", --["MenuDIS"] = true,
		},
 }
MultiLobbySettings[4] = {--"MLS_UNITTYPE"
	[0] = { ["globals.unitcat_destroyer"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		},
	[1] = { ["globals.unitcat_lightcruiser"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		}, 
	[2] = { ["globals.unitcat_cruiser"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["globals.unitcat_battleship"]  = "FE.multi_unitclass_desc",  ["Default"] = true,--["MenuDIS"] = true,
		}, 
	[4] = { ["globals.unitcat_torpedoboat"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		}, 
	[5] = { ["globals.unitcat_submarine"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		}, 
	[6] = { ["globals.unitcat_fighter"]  = "FE.multi_unitclass_desc", --["MenuDIS"] = true,
		},
 }
MultiLobbySettings[5] = {--"MLS_RESOURCE"
	[0] = { [9600] = "WARNING: UNSTABLE! PLAY AT OWN RISK! - Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.",  ["Default"] = true,--["MenuDIS"] = true,
		},
	[1] = { [4800] = "WARNING: UNSTABLE! PLAY AT OWN RISK! - Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", --["MenuDIS"] = true,
		},
	[2] = { [3600] = "WARNING: UNSTABLE! PLAY AT OWN RISK! - Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", --["MenuDIS"] = true,
		},
	[3] = { [2400] = "WARNING: UNSTABLE! PLAY AT OWN RISK! - Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", --["MenuDIS"] = true,
		},
	[4] = { [1200] = "Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.",  ["Default"] = true,--["MenuDIS"] = true,
		},
	[5] = { [900] = "Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", --["MenuDIS"] = true,
		},
	[6] = { [600] = "Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", --["MenuDIS"] = true,
		},
	[7] = { [300] = "Every unit has a different Command Point cost. With this option you can set the available Command Points for every player, altering the number of units they can command and control.", ---["MenuDIS"] = true,
		},
 }
MultiLobbySettings[6] = {--"MLS_TIME"
	[0] = { ["globals.none"]  = "FE.multi_timelimit_desc", ["MenuDIS"] = true,
		}, 
	[1] = { ["globals.5m"]  = "FE.multi_timelimit_desc", ["MenuDIS"] = true,
		}, 
	[2] = { ["globals.10m"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["globals.15m"]  = "FE.multi_timelimit_desc",  ["Default"] = true, --["MenuDIS"] = true,
		}, 
	[4] = { ["globals.20m"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[5] = { ["globals.25m"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[6] = { ["globals.30m"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	}
MultiLobbySettings[7] = {--"MLS_TIME"
	[0] = { ["globals.none"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		},
	[1] = { ["globals.30m"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[2] = { ["globals.1h"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["globals.2h"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		}, 
	[4] = { ["globals.4h"]  = "FE.multi_timelimit_desc", --["MenuDIS"] = true,
		},
}
MultiLobbySettings[8] = {--"MLS_POINT"
	[0] = { ["globals.none"]  =  "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
	[1] = { ["500"]  =  "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
	[2] = { ["1000"]  =  "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["2000"]  = "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
	[4] = { ["3000"]  = "FE.multi_scorelimit_desc",  ["Default"] = true, --["MenuDIS"] = true,
		}, 
	[5] = { ["4000"]  = "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
	[6] = { ["5000"]  = "FE.multi_scorelimit_desc", --["MenuDIS"] = true,
		}, 
}
MultiLobbySettings[9] = {--"MLS_ROUND"
	[0] = { ["globals.none"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		},
	[1] = { ["1"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		}, 
	[2] = { ["3"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		}, 
	[3] = { ["5"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		}, 
	[4] = { ["7"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		}, 
	[5] = { ["9"]  = "FE.multi_roundlimit_desc", --["MenuDIS"] = true,
		},
}
MultiLobbySettings[10] = {--"MLS_ENABLEPOWERUPS"
	[0] = { ["globals.enable"]  = "FE.multi_navalsupplies_desc", --["MenuDIS"] = true,
		}, 
	[1] = { ["globals.disable"]  =  "FE.multi_navalsupplies_desc", --["MenuDIS"] = true,
		},
 }
MultiLobbySettings[11] = {--"MLS_ENABLEMAP"
	[0] = { ["globals.enable"]  = "FE.multi_tacticalmap_desc",
		},
	[1] = { ["globals.disable"]  = "FE.multi_tacticalmap_desc",
		},
}
MultiLobbySettings[12] = {--"MLS_RELOADPAYLOAD"
	[0] = { ["globals.on"]  = "FE.multi_reloadpayload_desc", --["MenuDIS"] = true,
		},
	[1] = { ["globals.off"]  =  "FE.multi_reloadpayload_desc", --["MenuDIS"] = true,
		}, 
}


DropRateSettings = {}
	
DropRateSettings["DropRatePlayedMinimum"] = 10 -- ahhoz hogy ertelmes valaszt tudjunk adni a DropRate-rol, a megadott szamnal tobbet kell jatszani (ertekkent barmely termeszetes szamot felveheti)
DropRateSettings["HighDropRatePercent"] = 0.25 -- [X = Disconnected / Total] ha X erteke nagyobb a megadottnal, az mar HighDropRate-nek szamit (ertekkent 0 es 1 kozotti valos szam, akar 0 es 1 is lehet csak az durva lesz)


CaptureSettings = {
	["FallbackCapturePower"] = 20, -- ha senki sincs foglalo range-ben, akkor ekkora erovel fog 0-hoz tartani a CB capture countere
}