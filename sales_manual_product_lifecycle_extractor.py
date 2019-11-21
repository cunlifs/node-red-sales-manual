from urllib.request import urlopen
from bs4 import BeautifulSoup
import sys

url = sys.argv[1]
if url == "Missing":
    print("Missing")
else:
    html = urlopen(url)
    soup = BeautifulSoup(html, 'html')
# soup.contents
    Product_Life_Cycle_Title = soup.find("a", string="Product life cycle dates")
    Product_Life_Cycle_Table = Product_Life_Cycle_Title.find_next("table")
    MTM = Product_Life_Cycle_Table.find_next('td')
    Announce = MTM.find_next('td')
    Available = Announce.find_next('td')
    WDFM = Available.find_next('td')
    EOS = WDFM.find_next('td')
    print(MTM.get_text(),"\n",Announce.get_text(),"\n",Available.get_text(),"\n",WDFM.get_text(),"\n",EOS.get_text())
exit()
