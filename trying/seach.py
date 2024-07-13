import regex as re

path="C:\\Users\\Mani\\Downloads\\Terraform\\trying\\new.txt"

pattern = r'.{3}-0f58b397bc5c1f2e8'

with open(path,"r") as statefile:
  forread=statefile.read()
  find=re.findall(pattern,forread)
  for each in find:
    print(each)
  