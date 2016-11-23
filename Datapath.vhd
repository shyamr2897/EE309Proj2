library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Datapath is
    port(
        clk,rst: in std_logic);
end entity;

architecture Mixed of Datapath is
    --register P1
    signal p1_instr_out, p1_instr_in, p1_pc_out, p1_pc_in: std_logic_vector(15 downto 0);
    signal p1_enable, p1_stall_out: std_logic;

    --register P1
    signal p2_instr_out, p2_instr_in, p2_pc_out, p2_pc_in: std_logic_vector(15 downto 0);
    signal p2_enable, p2_stall_out, p2_stall_in, p2_branch_in, p2_branch_out,
            p2_rr_br_loc_in, p2_rr_br_loc_out, p2_mr_in, p2_mr_out,
            p2_mw_in, p2_mw_out, p2_rfw_in, p2_rfw_out: std_logic;
    signal p2_rs1_in, p2_rs1_out, p2_rs2_in, p2_rs2_out, p2_rd_in, p2_rd_out
            : std_logic_vector(2 downto 0);
    signal p2_br_st_in, p2_br_st_out: std_logic_vector (1 downto 0);


    signal id_ins: std_logic_vector(15 downto 0);
    signal id_mdr, id_rs1, id_rs2, id_rd: std_logic_vector (2 downto 0);
    signal id_branch, id_dec_brloc, id_rr_brloc, id_mr, id_mw, id_rfw: std_logic;
    signal id_br_st: std_logic_vector (1 downto 0);

    signal md_ins, md_new_ins: std_logic_vector(15 downto 0);
    signal md_reg: std_logic_vector (2 downto 0);
    signal md_flg: std_logic;

    --decode branch location
    signal dbl_b, dbl_d, dbl_e, dbl_f, dbl_h: std_logic_vector(15 downto 0);
    signal dbl_a, dbl_c: std_logic_vector (8 downto 0);
    signal dbl_g: std_logic;

    --decode branch now
    signal dbn_a: std_logic_vector(1 downto 0);
    signal dbn_b, dbn_c, dbn_d, dbn_e, dbn_f, dbl_cout: std_logic;

    --register read branch now
    signal rbn_a, rbn_b: std_logic_vector(15 downto 0);
    signal rbn_c, rbn_d, rbn_f, rbn_g, rbn_h, rbn_i, rbn_j, rbn_k, rbn_l: std_logic;
    signal rbn_e: std_logic_vector (1 downto 0);

    --register read branch location
    signal rbl_a, rbl_c, rbl_d, rbl_e, rbl_g: std_logic_vector(15 downto 0);
    signal rbl_b: std_logic_vector(5 downto 0);
    signal rbl_f, rbl_cout: std_logic;

    --register read M memory location
    signal rm_a, rm_b, rm_c, rm_g: std_logic_vector(15 downto 0);
    signal rm_d, rm_e: std_logic_vector(2 downto 0);
    signal rm_f, rm_cout: std_logic;

    --register read W memory location
    signal rw_a: std_logic_vector (5 downto 0);
    signal rw_b, rw_c, rw_d: std_logic_vector(15 downto 0);
    signal rw_cout : std_logic;

    --register read mem location, data
    signal rmemloc, rmemdata : std_logic_vector(15 downto 0);

    --data hazard detector
    signal dhd_ex_rfw, dhd_ex_stall, dhd_mem_rfw, dhd_mem_stall,
            dhd_wb_rfw, dhd_wb_stall: std_logic;
	signal dhd_rr_rs1, dhd_rr_rs2, dhd_ex_rd,
            dhd_mem_rd, dhd_wb_rd: std_logic_vector(2 downto 0);
	signal dhd_rr_data1, dhd_rr_data2, dhd_ex_data, dhd_mem_data,
            dhd_wb_data:std_logic_vector(15 downto 0);
	signal dhd_data1_out, dhd_data2_out: std_logic_vector(15 downto 0);

    --control hazard detector
    signal brl_out, brl_d, brl_r, brl_e, brl_m: std_logic_vector(15 downto 0);
    signal brn_out, brn_d, brn_r, brn_e, brn_m, st_d_out, st_r_out, st_e_out: std_logic;

    --load hazard detector
    signal lh_ins_d, lh_ins_r: std_logic_vector(15 downto 0);
    signal lh_rs1d, lh_rs2d, lh_rdr: std_logic_vector (2 downto 0);
    signal lh_d_st, lh_r_st, lh_flag: std_logic;

    --register file
    signal rfw, pcw: std_logic;
    signal a1, a2, a3: std_logic_vector( 2 downto 0);
    signal d3, pc_in, d1, d2, pc_out: std_logic_vector(15 downto 0);

begin
    -----------------------------------------------------------------
    --Data Hazard Detector
    -----------------------------------------------------------------
    --dhd_ex_rfw <=
    --dhd_ex_stall <=
    --dhd_mem_rfw <=
    --dhd_mem_stall <=
    --dhd_wb_rfw <=
    --dhd_wb_stall <=
    --dhd_rr_rs1 <=
    --dhd_rr_rs2 <=
    --dhd_ex_rd <=
    --dhd_mem_rd <=
    --dhd_wb_rd <=
    --dhd_rr_data1 <=
    --dhd_rr_data2
    --dhd_ex_data <=
    --dhd_mem_data <=
    --dhd_wb_data <=

    --
    dhdetector: DHD port map(dhd_ex_rfw, dhd_ex_stall, dhd_mem_rfw, dhd_mem_stall,
            dhd_wb_rfw, dhd_wb_stall,dhd_rr_rs1, dhd_rr_rs2, dhd_ex_rd,
            dhd_mem_rd, dhd_wb_rd, dhd_rr_data1, dhd_rr_data2, dhd_ex_data, dhd_mem_data,
            dhd_wb_data, dhd_data1_out, dhd_data2_out);
    -----------------------------------------------------------------
    --Control Hazard Detector
    -----------------------------------------------------------------
    --brn_d <=
    --brn_r <=
    --brn_e <=
    --brn_m <=
    --brl_d <=
    --brl_r <=
    --brl_e <=
    --brl_m

    --
    chdetector:ControlHazardDetector port map(brl_out, brn_out, st_d_out, st_e_out, st_r_out,
                    brn_d, brn_r, brn_e, brn_m, brl_d, brl_r, brl_e, brl_m);
    -----------------------------------------------------------------
    --Load Hazard Detector
    -----------------------------------------------------------------
    --lh_ins_d <=
    --lh_ins_r <=
    --lh_rs1d <=
    --lh_rs2d <=
    --lh_rdr <=
    --lh_d_st <=
    --lh_r_st <=

    --
    lhdetector:LoadHazard port map (lh_ins_d, lh_ins_r, lh_rs1d,
                            lh_rs2d, lh_rdr, lh_d_st, lh_r_st,lh_flag);

    -----------------------------------------------------------------
    --Register File
    -----------------------------------------------------------------
    --rfw <=
    --pcw <=
    --a1 <=
    --a2 <=
    --a3 <=
    --d3<=

    --
    regfile: RF port map(rfw, pcw, a1, a2, a3, d3, pc_in, d1, d2, pc_out, rst, clk);

    -----------------------------------------------------------------
    --Pipeline Register P1
    -----------------------------------------------------------------
    process(clk)
    begin
        if(clk'event and (clk  = '1')) then
            if(p1_enable = '1') then
                p1_instr_out <= p1_instr_in;
                p1_pc_out <= p1_pc_in;
                p1_stall_out <= '0';
            end if;
            if(rst = '1') then
                p1_instr_out <= (others => '0');
                p1_pc_out <= (others => '0');
                p1_stall_out <= '1';
            end if;
        end if;
    end process;
    -----------------------------------------------------------------
    --Decode Stage
    -----------------------------------------------------------------
    --instruction decoder--
    id_ins <= p1_instr_out;
    id_mdr <= md_reg;
    --
    id: InstructionDecoder
        port map(id_ins, id_mdr, id_rs1, id_rs2, id_rd, id_branch, id_dec_brloc, id_rr_brloc,
                id_br_st, id_mr, id_mw, id_rfw);

    --M decoder--
    md_ins <= p1_instr_out;
    --
    md: M_Decoder
        port map (md_ins, md_new_ins, md_reg, md_flg);

    --branch location--
    dbl_a <= p1_instr_out(8 downto 0);
    dbl_b <= p1_pc_out;
    dbl_c <= p1_instr_out(8 downto 0);
    dbl_g <= id_dec_brloc;
    --
    dp9: PadNine port map (dbl_a, dbl_e);
    dse9: NineBitSignExtender port map (dbl_c, dbl_d);
    dadd: SixteenBitAdder port map(dbl_b, dbl_d, dbl_f, dbl_cout);
    dm21: MuxTwo port map (dbl_e, dbl_f, dbl_g, dbl_h);

    --branch now--
    dbn_a <= id_br_st;
    dbn_c <= id_branch;
    dbn_e <= not p1_stall_out;
    --
    dbn_b <= '1' when dbn_a = "00" else '0';
    dbn_d <= dbn_b and dbn_c;
    dbn_f <= dbn_d and dbn_e;

    -----------------------------------------------------------------
    --Pipeline Register P2
    -----------------------------------------------------------------
    p2_instr_in <= p1_instr_out;
    p2_pc_in <= p1_pc_out;
    --p2_stall_in <=
    p2_branch_in <= id_branch;
    p2_rr_br_loc_in <= id_rr_brloc;
    p2_mr_in <= id_mr;
    p2_mw_in <= id_mw;
    p2_rfw_in <= id_rfw;
    p2_rs1_in <= id_rs1;
    p2_rs2_in <= id_rs2;
    p2_rd_in <= id_rd;
    p2_br_st_in <= id_br_st;
    process(clk)
    begin
        if(clk'event and (clk  = '1')) then
            if(p2_enable = '1') then
                p2_instr_out <= p2_instr_in;
                p2_pc_out <= p2_pc_in;
                p2_stall_out <= p2_stall_in;
                p2_branch_out <= p2_branch_in;
                p2_rr_br_loc_out <= p2_rr_br_loc_in;
                p2_mr_out <= p2_mr_in;
                p2_mw_out <= p2_mw_in;
                p2_rfw_out <= p2_rfw_in;
                p2_rs1_out <= p2_rs1_in;
                p2_rs2_out <= p2_rs2_in;
                p2_rd_out <= p2_rd_in;
                p2_br_st_out <= p2_br_st_in;
            end if;
            if(rst = '1') then
                p2_instr_out <= (others => '0');
                p2_pc_out <= (others => '0');
                p2_stall_out <= '1';
                p2_branch_out <= '0';
                p2_rr_br_loc_out <= '0';
                p2_mr_out <= '0';
                p2_mw_out <= '0';
                p2_rfw_out <= '0';
                p2_rs1_out <= (others => '0');
                p2_rs2_out <= (others => '0');
                p2_rd_out <= (others => '0');
                p2_br_st_out <= (others => '0');
            end if;
        end if;
    end process;

    -----------------------------------------------------------------
    --Register Read Stage
    -----------------------------------------------------------------
    --branch now--
    --rbn_a <=
    --rbn_b <=
    rbn_e <= p2_br_st_out;
    rbn_h <= p2_branch_out;
    rbn_j <= not p2_stall_out;
    rbn_l <= p2_rr_br_loc_out;
    --
    rbn_c <= '1' when rbn_a = rbn_b else '0';
    rbn_d <= '1' when rbn_l = '1' else rbn_c;
    rbn_f <= '1' when rbn_e = "01" else '0';
    rbn_g <= rbn_d and rbn_f;
    rbn_i <= rbn_g and rbn_h;
    rbn_k <= rbn_j and rbn_i;

    --branch location--
    rbl_a <= p2_pc_out;
    rbl_b <= p2_instr_out(5 downto 0);
    --rbl_e <=
    rbl_f <= p2_rr_br_loc_out;
    --
    rse: SixBitSignExtender port map (rbl_b, rbl_c);
    radd: SixteenBitAdder port map(rbl_a, rbl_c, rbl_d, rbl_cout);
    rm21: MuxTwo port map(rbl_d, rbl_e, rbl_f, rbl_g);

    --M memory location--
    --rm_a <=
    --rm_b <=
    rm_d <= p2_instr_out (15 downto 13);
    rm_e <= "111";
    --
    rnmnadd: SixteenBitAdder port map (rm_a, (0 => '1', others => '0'), rm_c, rm_cout);
    rnmuxtwo: MuxTwo port map (rm_b, rm_c, rm_f, rm_g);
    rm_f <= '1' when rm_d = rm_e else '0';

    --W memory location--
    rw_a <= p2_instr_out (5 downto 0);
    --rw_c <=
    --
    rwlocse: SixBitSignExtender port map (rw_a, rw_b);
    rwadder: SixteenBitAdder port map (rw_b, rw_c, rw_d, rw_cout);

    --actual memory location--
    rwactual: MuxTwo port map(rw_d, rm_g, p2_instr_out(13), rmemloc);
end Mixed;
