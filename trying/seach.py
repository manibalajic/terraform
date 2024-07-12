with open("new.txt","r") as ubuntu:
    texts=ubuntu.read()
    for each in texts:
     if "ami-0f58b397bc5c1f2e8" in each:
            print("found")

    