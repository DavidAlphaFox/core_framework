.PHONY : build clean

default :
	@echo "======================================="
	@echo "Please use 'make build' command to build it.."
	@echo "Please use 'make clean' command to clean all."
	@echo "======================================="

build :
	cd src && make build && mv main ../ && mv *.so ../
	cd luaclib &&  make build

rebuild :
	rm -rf main *.so
	cd src && make rebuild && mv main ../ && mv *.so ../
	cd luaclib && make rebuild

clean :
	rm -rf main *.so
	cd src && make clean
	cd luaclib && make clean