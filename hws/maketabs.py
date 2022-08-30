#!/bin/python3

# based on the example at:
# https://www.w3schools.com/howto/howto_js_tabs.asp

from html.parser import HTMLParser

fin = open("index.html","r")
data = fin.read()

header = ""
body = ""
tabs = []

class MyHTMLParser(HTMLParser):
	firsttime = True
	in_code = False
	
	def handle_starttag(self, tag, attrs):
		global body, header, tabs
		if tag == 'h3':
			assert len(attrs) == 1
			assert attrs[0][0] == 'id'
			assert len(attrs[0]) == 2
			tabs.append(attrs[0][1])
			if self.firsttime:
				header = body
				body = ""
			else:
				body += "</div>"
			self.firsttime = False
			body += "<div id='t" + attrs[0][1] + "' class='tabcontent'>"
		if tag == 'code':
			self.in_code = True
		body += "<"+tag
		for attr in attrs:
			body +=  " "+attr[0]+"="+"'"+attr[1]+"'"
		body += ">"

	def handle_endtag(self, tag):
		global body
		#print("Encountered an end tag :", tag)
		if tag == "body":
			body += "</div><script>document.getElementById('defaultOpen').click();</script>"
		if tag == 'code':
			in_code = False
		body += "</"+tag+">"

	def handle_data(self, data):
		global body
		if data != '':
			#print("Encountered some data  :", data.strip())
			if self.in_code:
				body += data.replace("<","&lt;").replace(">","&gt;")
			else:
				body += data


replacements = [ ("Ec","EC"),("Io","I/O"),("Tbtc","tBTC"),("P2Pkh","P2PKH"),("Tokendex","TokenDEX"),
				 ("Web3.Py","Web3.py"),("Nft","NFT"),("Nfts","NFTs"),("Dao","DAO"),("Eth","ETH"),
				 ("Fake","(fake)"),("Erc","ERC"),("Html","HTML")]

parser = MyHTMLParser()
parser.feed(data)
with open("index-tabs.html","w") as fout:
	print(header,file=fout,end='')
	print("<div class='tab'>",file=fout)
	firsttime = True
	for tab in tabs:
		if tab[0:5] in ["step-","part-","task-"]:
			name = " " + tab[7:].replace("-"," ").title() + " "
		else:
			name = " " + tab.replace("-"," ").title() + " "
		for x,y in replacements:
			name = name.replace(" "+x+" "," "+y+" ")
		name = name.strip()
		id = ""
		if firsttime:
			id=" id='defaultOpen'"
			firsttime = False
		print("<button class='tablinks' onclick=\"openTab(event,'t" + tab + "')\"" + id + ">" + name + "</button>",file=fout)
	print("</div>",file=fout)
	print(body,file=fout)
