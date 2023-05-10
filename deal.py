import re

alls = None
with open("bsp_debug1.log", "r") as f:
    alls = f.readlines()
print(len(alls))
newall = []
for a in alls:
    # if a == "end\n":
    #     newall.append("\tluaDoCustomLog(\"debug.txt\", \"{0}\"..\" END\", \"a\")--\n".format(name))
    # newall.append(a)
    # if re.match("function ", a):
    #     name = ""
    #     for n in a[9:]:
    #         if n == '(': break
    #         name = name + n
    #     newall.append("\tluaDoCustomLog(\"debug.txt\", \"{0}\", \"a\")--\n".format(name))
    newall.append(a.split("INFO")[1])
with open("bsp_debug1ccc.log", "w") as f:
    f.writelines(newall)