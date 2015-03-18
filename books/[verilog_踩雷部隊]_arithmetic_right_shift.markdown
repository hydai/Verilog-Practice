#Arithmetic right shift

一個不小心踩到的雷ＱＡＱ

足足欺負我一個多小時



`>>>` 是 arithmetic right shift 在 Verilog 裡的運算符號，功能如下：

```verilog
4-bit: 0111 >>> 1 = 0011
4-bit: 1100 >>> 1 = 1110
```

所以很直覺的就拿來用的後果卻是變成這樣：

```verilog
4-bit: 0111 >>> 1 = 0011
4-bit: 1100 >>> 1 = 0110
```

因為要被算的數沒有指定為 `signed`，所以被當成 `unsigned` 處理

對於 `unsigned` 的數就直接用單純的 logic shift（`>>`）來算
因此答案就不會是我們原本想的那樣了。

如果想要讓他以原本的想法動的話，要改成

```verilog
$signed(1100) >>> 1 = 1110;
```