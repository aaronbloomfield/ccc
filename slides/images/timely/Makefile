.SUFFIXES: .png .webp
WEBP	= btc-difficulty-all-time.webp btc-difficulty-last-3-years.webp btc-hashes-per-sec.webp btc-price.webp

webp: $(WEBP)
	cd ../../.. && make -s
	echo all converted

.png.webp:
	cwebp -lossless -quiet -o $@ $<
