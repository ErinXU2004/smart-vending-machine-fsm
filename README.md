# 🍊 蜜雪冰城 vs ☕️ 星巴克：我用 Verilog 写了一个贫富差距饮料机 FSM

一杯 5 块的快乐，还是一杯 30 的社交货币？  
我选择：**用状态机控制饮料自由** 😎

这不是普通的状态机项目，这是程序员对饮料价格的一次沉思。
本项目模拟了一台饮料贩卖机，支持两种饮品：

- 🍊 **Mixue 蜜雪冰城** —— 只需 5 元，即刻畅饮快乐水
- 🥤 **Starbucks 星巴克** —— 高端白领精神续命水，仅需 30 元（和一点社会代价）


> Designed and implemented by [Erin Xu](https://github.com/ErinXU2004)

---

## 🎯 Features

用户可以：
- 投币（支持5元, 10元）
- 选择饮料
- 如果余额不足，机器沉默以对
- 如果余额充足，机器冷静出水，并找零微笑面对

背后由 Verilog 写成的状态机操控一切 —— 毕竟喝水这件事，也得精确到每一个时钟沿。


---

## 🧱 Project Structure

```bash
smart-vending-machine-fsm/
├── src/
│   └── vending_machine.v         # Verilog source code
├── sim/
│   └── vending_machine_tb.v      # Testbench for simulation
├── doc/
│   └── fsm_diagram.png           # FSM diagram
└── README.md                    
```

## 🧠 FSM Design

### States:

本项目使用 Verilog 实现：
- 一个具有四个状态的有限状态机（FSM）：IDLE、WAIT、DISPENSE、CHANGE
- 钱包逻辑（累加金额、饮料定价）
- 输出控制（出饮料 + 找零）

> FSM diagram will be added in doc/fsm_diagram.png

## 🧪 Simulation
Testbench 包含对蜜雪党和星巴克党的友好支持。
