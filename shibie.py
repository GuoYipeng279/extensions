# importing libraries 
import speech_recognition as sr
import os
import pandas as pd

# create a speech recognition object
r = sr.Recognizer()

if __name__ == "__main__":
    filename = "D:\\ffo\\siwang"
    lis = os.listdir(filename)
    texts = []
    for i,l in enumerate(lis):
        print(i,"/",len(lis),end='')
        try:
            with sr.AudioFile(filename+"\\"+l) as source:
                # listen for the data (load audio to memory)
                audio_data = r.record(source)
                # recognize (convert from speech to text)
                text = r.recognize_google(audio_data,language="cmn-Hans-CN",show_all=True)
                texts.append(text)
            print(" success")
            print(text)
        except:
            texts.append("")
            print(" fail")
    li = []
    for n, t in zip(lis,texts):
        li.append([n,t])
    df = pd.DataFrame(li)
    df.to_csv("yuyin.csv")
    