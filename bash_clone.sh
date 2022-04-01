sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install python3.10 -y
sudo add-apt-repository ppa:swi-prolog/stable -y
sudo apt-get install swi-prolog -y
sudo apt-get install python3.10-distutils -y
wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py
python3.10 get-pip.py

git clone https://github.com/peppocola/Cdl_Assistant.git

cd Cdl_Assistant
python3.10 -m pip install -r requirements.txt
cd src

python3.10 intent_detection.py