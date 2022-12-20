module("extensions.huai", package.seeall)

extension = sgs.Package("huai")
dabusi = sgs.General(extension, "dabusi", "god")

sgs.LoadTranslationTable{
    ["huai"] = "坏包",
    ["dabusi"] = "打不死"
}