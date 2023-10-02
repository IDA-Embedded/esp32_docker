

# 1. Build the project
.PHONY: target
target: 
	  idf.py build;

# 2. Flash the project
.PHONY: flash
flash: 
	  idf.py -p /dev/ttyUSB0 flash ;
# 2.1 Flash slow (115200)
.PHONY: flash-slow
flash-slow: 
	  idf.py -p /dev/ttyUSB0 flash -b 115200;
# 2.2 Flash fast (921600)
.PHONY: flash-fast
flash-fast: 
	  idf.py -p /dev/ttyUSB0 flash -b 921600;
# 3. Monitor the project
.PHONY: monitor
monitor: 
	  screen /dev/ttyUSB0 115200;

# 3. Clean the project
.PHONY: clean
clean: 
	  idf.py fullclean;
