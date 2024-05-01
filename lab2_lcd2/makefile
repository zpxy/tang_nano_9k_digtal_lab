#**********************************************************
# FileNanme : makefile
# Author    : ZhaoPeng
# Time      : 2024-04-28 14:40:04
# Discribe  : 
#----------------------copyright 2023----------------------
#**********************************************************

DOWN_TOOL = /home/zhaopeng/programs/gowin/openFPGA/openFPGALoader
DOWN_FS   = $(shell find $(abspath ./impl/pnr) -name "*.fs") 
DOWN_TARGET = tangnano9k

ide:
	gw_ide &

down_fs:
	sudo $(DOWN_TOOL) -b $(DOWN_TARGET) $(DOWN_FS)


.PHONY: down_fs

