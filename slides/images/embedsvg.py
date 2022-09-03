#!/bin/python3

# embedsvg.py by Aaron Bloomfield, released under the GPL.

# When including a .svg file in a graphviz graph, it links to the .svg file
# rather than embedding it.  reveal.js will not load the linked image, so
# this program will take a graphviz output and embed the .svg file in it so
# that it loads correctly in reveal.js.  This is not expected to work
# with .svg files from any other source, only graphviz.

# Pass the top-level .svg as the command-line parameter.

import re, sys
from xml.etree import ElementTree

assert len(sys.argv) == 2

tree = ElementTree.parse(sys.argv[1])
root = tree.getroot()



def replace_images(node):
	if str(node.tag)[-5:] == 'image':
		#print(re.sub("{[^}]*}", "",node.tag))
		data = {}
		for x in node.attrib:
			#print("\t",re.sub("{[^}]*}", "",x),"\t",node.attrib[x])
			data[re.sub("{[^}]*}","",x)] = node.attrib[x]
		#print(data)
		imgtree = ElementTree.parse(data['href'])
		imgroot = imgtree.getroot()
		# this allows for any necessary scaling
		if 'viewBox' not in imgroot.attrib:
			width, height = imgroot.attrib["width"], imgroot.attrib["height"]
			imgroot.attrib['viewBox'] = "0 0 " + str(width) + " " + str(height)
		# copy other attributes over
		for x in imgroot.attrib:
			if x in ['width','height']:
				imgroot.attrib[x] = data[x]
			#print("\t",x,re.sub("{[^}]*}", "",x),"\t",imgroot.attrib[x])
		imgroot.attrib['x'] = data['x']
		imgroot.attrib['y'] = data['y']

		node.clear()
		node.tag = imgroot.tag
		node.attrib = imgroot.attrib
		for x in imgroot:
			node.append(x)
	for x in node:
		replace_images(x)


replace_images(root)
print(ElementTree.tostring(root).decode('ascii'))

"""
print ('<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<!-- Created with Inkscape (http://www.inkscape.org/) -->')

def print_node(node):
	tag = re.sub("{[^}]*}", "", node.tag)
	tag = node.tag
	print ("<" + tag,end='')
	for k,v in node.attrib.items():
		#print(" "+re.sub("{[^}]*}", "",k)+"='"+v+"'",end='')
		print(" "+k+"='"+v+"'",end='')
	if len(node) == 0:
		print (" />",end='')
		return
	else:
		print (" >")
		for x in node:
			print_node(x)
		print ("</"+tag+">")

print()
print_node(root)
"""
