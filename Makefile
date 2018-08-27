ALL:
	rm -rf ./tmp/*
	mkdir -p ./tmp

	cd src && ../aosasm -I../../../project/src/userspace/bin/lib rpg.s ../rpg
	cp ./rpg ./tmp
	cp ./levels/* ./tmp

	./minifsbuilder -fcheader "./tmp" "rpg" "./"
