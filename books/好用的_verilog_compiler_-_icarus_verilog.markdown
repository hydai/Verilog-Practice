#好用的 Verilog compiler - Icarus Verilog

##前言
這學期修的硬體實驗用到 `FPGA板` ，使用的是 `Xilinx ISE`。
同時也修了一門課是數位系統設計，專門寫 `Verilog`，用的卻是 `ncverilog`。
再用了兩個工具以後，總會有些比較：

| 比較點 | Xilinx ISE | ncverilog |
| :-------------: | :-------------: | :-------------: |
| 編輯器 | 普通的編輯器<br>沒有自動補完 | 沒有內建編輯器，<br>用自己習慣的編輯器即可 |
| 速度 | 略慢 | 較快 |
| 錯誤/<br>警告訊息 | 基本上看不懂 | 能大略指出哪裡錯誤 |
| 個人意見 | 我討厭醜醜的 UI | 打指令大好 |

好啦，總結來講，GUI 和終端機的界面我都喜歡，唯一沒辦法接受的就是醜到爆的 GUI ，與其用那麼難看的，還不如不用ＯＴＺ


##正文
不過呢...... ncverilog 要錢錢（感覺還很貴，肯定買不起裝在自己電腦上）
所以東找西找，想找要麻就是 GUI 很好的，不然就是堪用的文字界面就好
終於讓我發現這個還算不錯的工具 - **[Icarus Verilog](http://iverilog.icarus.com/)**

先來看看他有什麼優點

| 比較點 | iverilog |
| :--------------: | :---------------: |
| 編輯器 |  沒有內建編輯器，<br>用自己習慣的編輯器即可  |
| 速度 |  還可  |
| 錯誤/<br>警告訊息 |  只有檔名行號<br>（還有一句經典的 I give up.）  |
| 個人意見 |  打指令大好  |

至於覺得好不好用，這點就見仁見智了ＯＡＯ～

---
##安裝
###Mac
```bash
brew install icarus-verilog
```
###Linux
```bash
apt-get install verilog
```
###Windows
//TODO

##如何使用
####編譯
```bash
#iverilog -o outputName srcs
#for example,
iverilog -o datapath datapath.v datapath_t.v
```
上面的語法，代表輸出的檔名叫做 datapath，輸入檔為後面接著的檔案

####執行
```bash
#run simulation
#vvp outputName
vvp datapath
```

---

分享的部分就到這邊啦～
以後如果發現更多好玩的部分會再補上的！


hydai@6/7, 2014