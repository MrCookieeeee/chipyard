    input  logic                       axi4_mem_0_clock,
    input  logic                       axi4_mem_0_reset,

    output logic                       axi4_mem_0_bits_aw_ready,
    input  logic                       axi4_mem_0_bits_aw_valid,
    
    input  logic [AXI_ID_WIDTH-1:0]    axi4_mem_0_bits_aw_bits_id,
    input  logic [AXI_ADDR_WIDTH-1:0]  axi4_mem_0_bits_aw_bits_addr,
    input  logic [7:0]                 axi4_mem_0_bits_aw_bits_len,
    input  logic [2:0]                 axi4_mem_0_bits_aw_bits_size,
    input  logic [1:0]                 axi4_mem_0_bits_aw_bits_burst,
    input  logic                       axi4_mem_0_bits_aw_bits_lock,
    input  logic [3:0]                 axi4_mem_0_bits_aw_bits_cache,
    input  logic [2:0]                 axi4_mem_0_bits_aw_bits_prot,
    input  logic [3:0]                 axi4_mem_0_bits_aw_bits_qos,




typedef struct packed {
    logic [AXI_ID_WIDTH-1:0]   id;
    logic [AXI_ADDR_WIDTH-1:0] addr;
    logic [7:0]                len;
    logic [2:0]                size;
    axi_burst_t                burst;
} ax_req_t;

// Registers
enum logic [2:0] { IDLE, READ, WRITE, SEND_B, WAIT_WVALID }  state_d, state_q;
ax_req_t                   ax_req_d, ax_req_q;
logic [AXI_ADDR_WIDTH-1:0] req_addr_d, req_addr_q;
logic [7:0]                cnt_d, cnt_q;




module ChipTop(
  output        axi4_mmio_0_clock,
  output        axi4_mmio_0_reset,
  input         axi4_mmio_0_bits_aw_ready,
  output        axi4_mmio_0_bits_aw_valid,
  output [3:0]  axi4_mmio_0_bits_aw_bits_id,
  output [30:0] axi4_mmio_0_bits_aw_bits_addr,
  output [7:0]  axi4_mmio_0_bits_aw_bits_len,
  output [2:0]  axi4_mmio_0_bits_aw_bits_size,
  output [1:0]  axi4_mmio_0_bits_aw_bits_burst,
  output        axi4_mmio_0_bits_aw_bits_lock,
  output [3:0]  axi4_mmio_0_bits_aw_bits_cache,
  output [2:0]  axi4_mmio_0_bits_aw_bits_prot,
  output [3:0]  axi4_mmio_0_bits_aw_bits_qos,
  input         axi4_mmio_0_bits_w_ready,
  output        axi4_mmio_0_bits_w_valid,
  output [63:0] axi4_mmio_0_bits_w_bits_data,
  output [7:0]  axi4_mmio_0_bits_w_bits_strb,
  output        axi4_mmio_0_bits_w_bits_last,
  output        axi4_mmio_0_bits_b_ready,
  input         axi4_mmio_0_bits_b_valid,
  input  [3:0]  axi4_mmio_0_bits_b_bits_id,
  input  [1:0]  axi4_mmio_0_bits_b_bits_resp,
  input         axi4_mmio_0_bits_ar_ready,
  output        axi4_mmio_0_bits_ar_valid,
  output [3:0]  axi4_mmio_0_bits_ar_bits_id,
  output [30:0] axi4_mmio_0_bits_ar_bits_addr,
  output [7:0]  axi4_mmio_0_bits_ar_bits_len,
  output [2:0]  axi4_mmio_0_bits_ar_bits_size,
  output [1:0]  axi4_mmio_0_bits_ar_bits_burst,
  output        axi4_mmio_0_bits_ar_bits_lock,
  output [3:0]  axi4_mmio_0_bits_ar_bits_cache,
  output [2:0]  axi4_mmio_0_bits_ar_bits_prot,
  output [3:0]  axi4_mmio_0_bits_ar_bits_qos,
  output        axi4_mmio_0_bits_r_ready,
  input         axi4_mmio_0_bits_r_valid,
  input  [3:0]  axi4_mmio_0_bits_r_bits_id,
  input  [63:0] axi4_mmio_0_bits_r_bits_data,
  input  [1:0]  axi4_mmio_0_bits_r_bits_resp,
  input         axi4_mmio_0_bits_r_bits_last,
  input         custom_boot,
  input         clock_clock,
  input         reset,
  output        axi4_mem_0_clock,
  output        axi4_mem_0_reset,
  input         axi4_mem_0_bits_aw_ready,
  output        axi4_mem_0_bits_aw_valid,
  output [3:0]  axi4_mem_0_bits_aw_bits_id,
  output [31:0] axi4_mem_0_bits_aw_bits_addr,
  output [7:0]  axi4_mem_0_bits_aw_bits_len,
  output [2:0]  axi4_mem_0_bits_aw_bits_size,
  output [1:0]  axi4_mem_0_bits_aw_bits_burst,
  output        axi4_mem_0_bits_aw_bits_lock,
  output [3:0]  axi4_mem_0_bits_aw_bits_cache,
  output [2:0]  axi4_mem_0_bits_aw_bits_prot,
  output [3:0]  axi4_mem_0_bits_aw_bits_qos,
  input         axi4_mem_0_bits_w_ready,
  output        axi4_mem_0_bits_w_valid,
  output [63:0] axi4_mem_0_bits_w_bits_data,
  output [7:0]  axi4_mem_0_bits_w_bits_strb,
  output        axi4_mem_0_bits_w_bits_last,
  output        axi4_mem_0_bits_b_ready,
  input         axi4_mem_0_bits_b_valid,
  input  [3:0]  axi4_mem_0_bits_b_bits_id,
  input  [1:0]  axi4_mem_0_bits_b_bits_resp,
  input         axi4_mem_0_bits_ar_ready,
  output        axi4_mem_0_bits_ar_valid,
  output [3:0]  axi4_mem_0_bits_ar_bits_id,
  output [31:0] axi4_mem_0_bits_ar_bits_addr,
  output [7:0]  axi4_mem_0_bits_ar_bits_len,
  output [2:0]  axi4_mem_0_bits_ar_bits_size,
  output [1:0]  axi4_mem_0_bits_ar_bits_burst,
  output        axi4_mem_0_bits_ar_bits_lock,
  output [3:0]  axi4_mem_0_bits_ar_bits_cache,
  output [2:0]  axi4_mem_0_bits_ar_bits_prot,
  output [3:0]  axi4_mem_0_bits_ar_bits_qos,
  output        axi4_mem_0_bits_r_ready,
  input         axi4_mem_0_bits_r_valid,
  input  [3:0]  axi4_mem_0_bits_r_bits_id,
  input  [63:0] axi4_mem_0_bits_r_bits_data,
  input  [1:0]  axi4_mem_0_bits_r_bits_resp,
  input         axi4_mem_0_bits_r_bits_last
);