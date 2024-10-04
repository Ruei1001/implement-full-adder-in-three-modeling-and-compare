`timescale 1ns/10ps
`define CYCLE 50.0
`define DATA_NUM 100
module tb_adder_structure;

    reg CLK = 0;
    reg RST = 0;
    reg [31:0] A_adder_structure, B_adder_structure, A_adder_structure_reg, B_adder_structure_reg;
    reg [31:0] A_adder_dataflow, B_adder_dataflow, A_adder_dataflow_reg, B_adder_dataflow_reg;
    reg [31:0] A_adder_behavior, B_adder_behavior, A_adder_behavior_reg, B_adder_behavior_reg;
    reg cin_adder_structure, cin_adder_structure_reg , cin_adder_dataflow , cin_adder_dataflow_reg , cin_adder_behavior, cin_adder_behavior_reg;
    wire [31:0] sum_adder_structure, sum_adder_structure_reg , sum_adder_dataflow , sum_adder_dataflow_reg , sum_adder_behavior, sum_adder_behavior_reg;
    wire cout_adder_structure, cout_adder_structure_reg , cout_adder_dataflow , cout_adder_dataflow_reg , cout_adder_behavior, cout_adder_behavior_reg;
    integer i;

    // Expected results
    reg [31:0] expected_sum;
    reg expected_cout;

    // Instantiate the 32-bit adder
    adder_structure uut_adder_structure (
        .s(sum_adder_structure),
        .co(cout_adder_structure),
        .a(A_adder_structure),
        .b(B_adder_structure),
        .ci(cin_adder_structure)

    );
    adder_dataflow uut_adder_dataflow (
        .s(sum_adder_dataflow),
        .co(cout_adder_dataflow),
        .a(A_adder_dataflow),
        .b(B_adder_dataflow),
        .ci(cin_adder_dataflow)

    );
    adder_behavior uut_adder_behavior (
        .s(sum_adder_behavior),
        .co(cout_adder_behavior),
        .a(A_adder_behavior),
        .b(B_adder_behavior),
        .ci(cin_adder_behavior)

    );
    adder_structure_reg uut_adder_structure_reg (
        .s(sum_adder_structure_reg),
        .co(cout_adder_structure_reg),
        .a(A_adder_structure_reg),
        .b(B_adder_structure_reg),
        .ci(cin_adder_structure_reg),
        .clk(CLK)

    );
    adder_dataflow_reg uut_adder_dataflow_reg (
        .s(sum_adder_dataflow_reg),
        .co(cout_adder_dataflow_reg),
        .a(A_adder_dataflow_reg),
        .b(B_adder_dataflow_reg),
        .ci(cin_adder_dataflow_reg),
        .clk(CLK)

    );
    adder_behavior_reg uut_adder_behavior_reg (
        .s(sum_adder_behavior_reg),
        .co(cout_adder_behavior_reg),
        .a(A_adder_behavior_reg),
        .b(B_adder_behavior_reg),
        .ci(cin_adder_behavior_reg),
        .clk(CLK)

    );
    /*
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_structure/delay/adder_structure_delay.sdf",uut_adder_structure);
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_dataflow/delay/adder_dataflow_delay.sdf",uut_adder_dataflow);
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_behavior/adder_behavior.sdf",uut_adder_behavior);
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_structure_reg/delay/adder_structure_reg_delay.sdf",uut_adder_structure_reg);
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_behavior_reg/delay/adder_behavior_reg_delay.sdf",uut_adder_behavior_reg);
    initial $sdf_annotate("/home/B103040041_HDL/HW1/gate_level/adder_dataflow_reg/delay/adder_dataflow_reg_delay.sdf",uut_adder_dataflow_reg);
    */
    integer error_adder_structure=0, flag_adder_structure = 0;
    integer error_adder_dataflow=0, flag_adder_dataflow = 0;
    integer error_adder_behavior=0, flag_adder_behavior = 0;
    integer error_adder_structure_reg=0, flag_adder_structure_reg = 0;
    integer error_adder_dataflow_reg=0, flag_adder_dataflow_reg = 0;
    integer error_adder_behavior_reg=0, flag_adder_behavior_reg = 0;
    
    always #5 CLK = ~CLK;
    initial begin
        // Initialize carry-in to 0 for this test
        cin_adder_structure = 0;
        cin_adder_structure_reg= 0; cin_adder_dataflow= 0 ; cin_adder_dataflow_reg= 0 ; cin_adder_behavior= 0; cin_adder_behavior_reg = 0;
        error_adder_structure = 0;
        CLK = 0;
        RST = 1;
        RST = 0;
        //random approach
        $display("----------------------------------------\n");
        $display("-         adder_USE_RANDOM         -\n");
        $display("----------------------------------------\n");

        // Run 10 test cases
        for (i = 0; i < 10; i = i + 1) begin
            // Generate random inputs for A and B
            A_adder_structure = $random;
            B_adder_structure = $random;
            A_adder_dataflow = A_adder_structure;
            B_adder_dataflow = B_adder_structure;
            A_adder_behavior = A_adder_structure;
            B_adder_behavior = B_adder_structure;
            A_adder_structure_reg = A_adder_structure;
            B_adder_structure_reg = B_adder_structure;
            A_adder_dataflow_reg = A_adder_structure;
            B_adder_dataflow_reg = B_adder_structure;
            A_adder_behavior_reg = A_adder_structure;
            B_adder_behavior_reg = B_adder_structure;
            // Compute expected results using Verilog arithmetic
            {expected_cout, expected_sum} = A_adder_structure + B_adder_structure;

            // Wait for the adder to produce the results
            #10;

            // Check if the module's output matches the expected results
            if (sum_adder_structure !== expected_sum || cout_adder_structure !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_structure #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_structure);
                $display("The input B is    : %X\n", B_adder_structure);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_structure);
                $display("----------------------------------------\n");
                flag_adder_structure = 1;
                error_adder_structure= error_adder_structure + 1;
            end 

            if (sum_adder_behavior !== expected_sum || cout_adder_behavior !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_behavior #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_behavior);
                $display("The input B is    : %X\n", B_adder_behavior);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_behavior);
                $display("----------------------------------------\n");
                flag_adder_behavior = 1;
                error_adder_behavior = error_adder_behavior + 1;
            end 

            if (sum_adder_dataflow !== expected_sum || cout_adder_dataflow !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_dataflow #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_dataflow);
                $display("The input B is    : %X\n", B_adder_dataflow);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_dataflow);
                $display("----------------------------------------\n");
                flag_adder_dataflow = 1;
                error_adder_dataflow = error_adder_dataflow + 1;
            end 

            if (sum_adder_structure_reg !== expected_sum || cout_adder_structure_reg !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_structure_reg #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_structure_reg);
                $display("The input B is    : %X\n", B_adder_structure_reg);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_structure_reg);
                $display("----------------------------------------\n");
                flag_adder_structure_reg = 1;
                error_adder_structure_reg = error_adder_structure_reg + 1;
            end 

            if (sum_adder_behavior_reg !== expected_sum || cout_adder_behavior_reg !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_behavior_reg #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_behavior_reg);
                $display("The input B is    : %X\n", B_adder_behavior_reg);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_behavior_reg);
                $display("----------------------------------------\n");
                flag_adder_behavior_reg = 1;
                error_adder_behavior_reg = error_adder_behavior_reg + 1;
            end 

            if (sum_adder_dataflow_reg !== expected_sum || cout_adder_dataflow_reg !== expected_cout) begin
                // If there's an error, display the result in the specified format
                $display("----------------------------------------\n");
                $display("Output error at adder_dataflow_reg #%d\n", i+1);
                $display("The input A is    : %X\n", A_adder_dataflow_reg);
                $display("The input B is    : %X\n", B_adder_dataflow_reg);
                $display("The answer is     : %X\n", expected_sum);
                $display("Your module output: %X\n", sum_adder_dataflow_reg);
                $display("----------------------------------------\n");
                flag_adder_dataflow_reg = 1;
                error_adder_dataflow_reg = error_adder_dataflow_reg + 1;
            end 

            // Delay between tests
            #10;
        end

        if(flag_adder_structure==1)//if wrong
        begin
            $display("adder structure Total %4d error in %4d testdata.\n", error_adder_structure, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder_structure All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else
        if(flag_adder_dataflow==1)//if wrong
        begin
            $display("adder dataflow Total %4d error in %4d testdata.\n", error_adder_dataflow, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder dataflow All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else
        if(flag_adder_behavior==1)//if wrong
        begin
            $display("adder_behavior Total %4d error in %4d testdata.\n", error_adder_behavior, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder_behavior All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else

        if(flag_adder_structure_reg==1)//if wrong
        begin
            $display("adder_structure_reg Total %4d error in %4d testdata.\n", error_adder_structure_reg, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder_structure_reg All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else
        if(flag_adder_dataflow_reg==1)//if wrong
        begin
            $display("adder_dataflow_reg Total %4d error in %4d testdata.\n", error_adder_dataflow_reg, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder_dataflow_reg All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else
        if(flag_adder_behavior_reg==1)//if wrong
        begin
            $display("adder_behavior_reg Total %4d error in %4d testdata.\n", error_adder_behavior_reg, i);
            $display("----------------------------------------\n");
        end//if
        else
        begin//if right
            $display("----------------------------------------\n");
            $display("adder_behavior_reg All testdata correct!\n");
            $display("----------------------------------------\n");
        end//else


        // End the simulation
        $finish;
    end

endmodule
