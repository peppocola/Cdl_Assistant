# Cdl_Assistant
Project for Fundamentals of Artificial Intelligence exam (UniBa)

If you want to use just the prolog part, than consult every file with SWI-Prolog

If you want to use the python part, you need Python3.10 installed on your machine.
Install requirements with:

`pip install -r requirements.txt`

Move to the `src` folder.

After doing this, you can run `intent_detection.py`

If you are in linux environment, use the following:
```
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install python3.10 -y
sudo add-apt-repository ppa:swi-prolog/stable -y
sudo apt-get install swi-prolog -y
sudo apt-get install python3.10-distutils -y
wget https://bootstrap.pypa.io/get-pip.py -O /content/get-pip.py
python3.10 get-pip.py

git clone https://github.com/peppocola/Cdl_Assistant.git

cd Cdl_Assistant
python3.10 -m pip install -r requirements.txt
cd src

!python3.10 intent_detection.py
```

Some queries you can do:

- "suggest me an exam ordering for informatica"
- "suggest an exam ordering to gain 50 cfu for informatica"
- "can you suggest me an exam ordering to learn information filtering, testing for informatica"
- "show me suggested books for ingegneria della conoscenza"
- "show me teachings for informatica"
- "will you please show me teachers for programmazione"
- "can you show me covered topics for reti di calcolatori?"
- "goodbye"

The code can also be run on a preset [Colab Notebook](https://colab.research.google.com/drive/1y8BD3Z1WfdHFSeUPsvZVoBiL-hcVX_BR?usp=sharing)
