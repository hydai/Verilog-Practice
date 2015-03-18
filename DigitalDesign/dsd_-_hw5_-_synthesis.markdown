#DSD - HW5 - synthesis
##101062124 戴宏穎

##Part1
合成 hw3 datapath 的部分：

這個部分遇到的問題不少：

第一個遇到的就是出現無法合成的 verilog code，因為我有些部分當初寫的時候沒有特別注意到（像是 for loop 的語法），然後就沒辦法合成，於是把 for-loop 直接展開成很多行一樣的東西就可以合成了。

第二個遇到的問題如下：

```
		Modules w/wo timescales:
		timescale of worklib.hw3_t:v = 1ns/1ps
		timescale of worklib.datapath_DW_rightsh_1:v = NOTSET
		timescale of worklib.datapath_DW_leftsh_0:v = NOTSET
		timescale of worklib.datapath_DW01_inc_0:v = NOTSET
		timescale of worklib.datapath_DW01_add_8:v = NOTSET
		timescale of worklib.datapath_DW01_add_7:v = NOTSET
		timescale of worklib.datapath_DW01_add_6:v = NOTSET
		timescale of worklib.datapath_DW01_add_5:v = NOTSET
		timescale of worklib.datapath:v = NOTSET
		timescale of tsmc13.XOR2X1:v = 1ns/1ps
	ncelab: *F,CUMSTS: Timescale directive missing on one or more modules.
	ncverilog: *E,ELBERR: Error during elaboration (status 2), exiting.
```

因為嘗試各種方式無法解決，在洽詢助教以後被指導說加上 `+nospecify +notimingchecks` 就能順利合成了。不過還是不太了解為什麼會發生這個錯誤。

##Part2

合成 hw4 fifo 的部分：

基本上都沒有改東西就成功合成了。