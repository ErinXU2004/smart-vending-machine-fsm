`timescale 1ns/1ps
module tb_vending_machine;

    reg clk, rst;
    reg coin_5, coin_10;
    reg select_mixue, select_starbucks;
    reg cancel, confirm, continue_buying;
    wire dispense_mixue, dispense_starbucks;
    wire [5:0] change;

    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .select_mixue(select_mixue),
        .select_starbucks(select_starbucks),
        .cancel(cancel),
        .confirm(confirm),
        .continue_buying(continue_buying),
        .dispense_mixue(dispense_mixue),
        .dispense_starbucks(dispense_starbucks),
        .change(change)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, tb_vending_machine);

        // 初始化
        clk = 0; rst = 1;
        coin_5 = 0; coin_10 = 0;
        select_mixue = 0; select_starbucks = 0;
        cancel = 0; confirm = 0; continue_buying = 0;

        #10 rst = 0;

        // === 第一次购买：Mixue ===
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 select_mixue = 1; #10 select_mixue = 0;
        #10 confirm = 1; #10 confirm = 0;
        #10 continue_buying = 1; #10 continue_buying = 0;

        // === 第二次购买：Starbucks ===
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;
        #10 coin_10 = 1; #10 coin_10 = 0;

        #10 select_starbucks = 1; #10 select_starbucks = 0;
        #10 confirm = 1; #10 confirm = 0;

        #10 continue_buying = 0;

        // === 等待找零 ===
        #20;

        $finish;
    end
endmodule
