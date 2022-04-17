default:
	@echo webp is probably the target you want

webp:
	ls *.png | sed s/.png//g | awk '{print "cwebp -quiet -q 50 -o "$$1 ".webp "$$1".png"}' | bash
