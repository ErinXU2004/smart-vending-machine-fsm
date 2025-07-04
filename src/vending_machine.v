module vending_machine (
    input clk,
    input rst,
    input coin_5,
    input coin_10,
    input select_mixue,
    input select_starbucks,
    input cancel,
    input confirm,
    input continue_buying,
    output reg dispense_mixue, //你爱我我爱你
    output reg dispense_starbucks, //高贵的顾客
    output reg [5:0] change
);

    typedef enum reg [2:0] {
        IDLE, //快来买
        INSERTING, //投钱了
        CONFIRMING, 
        DISPENSING,
        RETURN_CHANGE
    } state_t;

    state_t state, next_state;

    reg [5:0] money;
    reg [5:0] selected_price;
    reg [1:0] selected_item; // 0: none, 1: mixue, 2: starbucks

    // 状态转移逻辑
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // 组合逻辑决定 next_state
    always @(*) begin
        dispense_mixue = 0;
        dispense_starbucks = 0;
        change = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (coin_5 || coin_10)
                    next_state = INSERTING;
            end

            INSERTING: begin
                if (select_mixue && money >= 5) begin
                    selected_price = 5;
                    selected_item = 1;
                    next_state = CONFIRMING;
                end 
                else if (select_starbucks && money >= 30) begin
                    selected_price = 30;
                    selected_item = 2;
                    next_state = CONFIRMING;
                end 
                else if (cancel)
                    next_state = RETURN_CHANGE;
                else
                    next_state = INSERTING;  // 默认停留等待投币或选择
            end

            CONFIRMING: begin
                if (confirm)
                    next_state = DISPENSING;
                else if (cancel)
                    next_state = INSERTING;
            end

            DISPENSING: begin
                next_state = (continue_buying) ? INSERTING : RETURN_CHANGE;
            end

            RETURN_CHANGE: begin
                next_state = IDLE;
            end
        endcase
    end

    // 状态行为逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            money <= 0;
            selected_price <= 0;
            selected_item <= 0;
            dispense_mixue <= 0;
            dispense_starbucks <= 0;
            change <= 0;
        end else begin
            case (state)
                INSERTING: begin
                    if (coin_5)
                        money <= money + 5;
                    else if (coin_10)
                        money <= money + 10;
                end

                DISPENSING: begin
                    money <= money - selected_price;
                    if (selected_item == 1)
                        dispense_mixue <= 1;
                    else if (selected_item == 2)
                        dispense_starbucks <= 1;
                end

                RETURN_CHANGE: begin
                    change <= money;
                    money <= 0;
                    selected_price <= 0;
                    selected_item <= 0;
                end
            endcase
        end
    end
endmodule
