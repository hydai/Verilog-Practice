# f2v
Use some short word to write verilog code.
For example, I use '{' to replace 'begin'.
```verilog
module example (a, b) {
    input a;
    output b;
    b = a;
}
```
After f2v translating:
```verilog
module example (a, b) begin
    input a;
    output b;
    b = a;
end
```
