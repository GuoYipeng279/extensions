import re

alls = None
with open("jm07.lua", "r") as f:
    alls = f.readlines()
print(len(alls))
newall = []
for a in alls:
    # if a == "end\n":
    #     newall.append("\tluaDoCustomLog(\"debug.txt\", \"{0}\"..\" END\", \"a\")--\n".format(name))
    newall.append(a)
    if re.match("function ", a):
        name = ""
        for n in a[9:]:
            if n == '(': break
            name = name + n
        newall.append("\tluaDoCustomLog(\"debug.txt\", \"{0}\", \"a\")--\n".format(name))
with open("jm07.lua", "w") as f:
    f.writelines(newall)