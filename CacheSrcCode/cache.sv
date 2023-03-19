

module cache #(
    parameter  LINE_ADDR_LEN = 3, // line�ڵ�??���ȣ�������ÿ��line����2^3��word
    parameter  SET_ADDR_LEN  = 3, // ���??���ȣ�������??����2^3=8??
    parameter  TAG_ADDR_LEN  = 6, // tag����
    parameter  WAY_CNT       = 3  // �������ȣ�������ÿ�����ж���·line
)(
    input  clk, rst,
    output miss,               // ��CPU������miss�ź�
    input  [31:0] addr,        // ��д�����ַ
    input  rd_req,             // ��������??
    output reg [31:0] rd_data, // ���������ݣ�??�ζ�??��word
    input  wr_req,             // д������??
    input  [31:0] wr_data      // Ҫд������ݣ�һ��д??��word
);

localparam MEM_ADDR_LEN    = TAG_ADDR_LEN + SET_ADDR_LEN ; // ���������ַ���� MEM_ADDR_LEN�������??=2^MEM_ADDR_LEN��line
localparam UNUSED_ADDR_LEN = 32 - TAG_ADDR_LEN - SET_ADDR_LEN - LINE_ADDR_LEN - 2 ;       // ����δʹ�õĵ�ַ�ĳ�??

localparam LINE_SIZE       = 1 << LINE_ADDR_LEN  ;         // ���� line ?? word ��������?? 2^LINE_ADDR_LEN ��word ?? line
localparam SET_SIZE        = 1 << SET_ADDR_LEN   ;         // ����??���ж����飬?? 2^SET_ADDR_LEN ����

reg [            31:0] cache_mem    [SET_SIZE][WAY_CNT][LINE_SIZE]; // SET_SIZE��line��ÿ��line��LINE_SIZE��word
reg [TAG_ADDR_LEN-1:0] cache_tags  [SET_SIZE] [WAY_CNT];            // SET_SIZE��TAG
reg                    valid        [SET_SIZE][WAY_CNT];            // SET_SIZE��valid(��Ч??)
reg                    dirty       [SET_SIZE] [WAY_CNT];            // SET_SIZE��dirty(��λ)
//        line_per_set [WAY_CNT];               // �������ȣ�������ÿ�����ж���·line

wire [              2-1 :0]   word_addr;                   // �������??addr��ֳ���5����??
wire [  LINE_ADDR_LEN-1 :0]   line_addr;
wire [   SET_ADDR_LEN-1 :0]    set_addr;
wire [   TAG_ADDR_LEN-1 :0]    tag_addr;
wire [UNUSED_ADDR_LEN-1 :0] unused_addr;

enum  {IDLE, SWAP_OUT, SWAP_IN, SWAP_IN_OK} cache_stat;    // cache ״???����״̬��??
                                                           // IDLE���������SWAP_OUT�������ڻ�����SWAP_IN�������ڻ��룬SWAP_IN_OK����������һ���ڵ�д��cache����??

reg [   SET_ADDR_LEN-1 :0] mem_rd_set_addr = 0;
reg [   TAG_ADDR_LEN-1 :0] mem_rd_tag_addr = 0;
wire[   MEM_ADDR_LEN-1 :0] mem_rd_addr = {mem_rd_tag_addr, mem_rd_set_addr};
reg [   MEM_ADDR_LEN-1 :0] mem_wr_addr = 0;

reg  [31:0] mem_wr_line [LINE_SIZE];
wire [31:0] mem_rd_line [LINE_SIZE];

wire mem_gnt;      // ������Ӧ��д��������??

assign {unused_addr, tag_addr, set_addr, line_addr, word_addr} = addr;  // ��� 32bit ADDR



reg cache_hit = 1'b0;

localparam LRU = 1'b0;
localparam FIFO = 1'b1;
reg tactic = LRU;

reg [31:0] lru_cache[SET_SIZE][WAY_CNT];
integer index_hit;
integer index_miss;
integer fifo_cache[SET_SIZE][WAY_CNT];

always @ (*) begin              // �ж� �����address �Ƿ�?? cache ����??
    cache_hit = 1'b0;
    if ( tactic ) begin
          for(integer i=0;i<WAY_CNT;i  = i+1 ) begin 
            if(valid[set_addr][i] && cache_tags[set_addr][i] == tag_addr) begin
                cache_hit <= 1'b1;
                index_hit <= i;
                break;
            end  
        end 
    end else begin      // LRU
        for(integer i=0;i<WAY_CNT;i  = i+1 ) begin 
            if(valid[set_addr][i] && cache_tags[set_addr][i] == tag_addr) begin
                cache_hit <= 1'b1;
                index_hit <= i;
                break;
            end 
        end 
    end
  
end


always @ (posedge clk or posedge rst) begin     // ?? cache ???
    if(rst) begin
        cache_stat <= IDLE;
        for(integer i=0; i<SET_SIZE; i = i+1) begin
            for (integer j = 0; j< WAY_CNT; j = j+1) begin
                dirty[i][j] <= 1'b0;
                valid[i][j] <= 1'b0;
            end
        end
        for(integer k=0; k<LINE_SIZE; k = k+1)
            mem_wr_line[k] <= 0;
        mem_wr_addr <= 0;
        {mem_rd_tag_addr, mem_rd_set_addr} <= 0;
        rd_data <= 0;
        if ( tactic ==1'b1) begin
            for(integer i =0 ;i<SET_SIZE;i = i+1) begin
                for(integer j =0;j<WAY_CNT;j = j+1) 
                fifo_cache[i][j] <= 0;
            end 
        end else begin
            for(integer i =0;i<SET_SIZE;i = i+1) begin
                for (integer j  = 0; j<WAY_CNT; j = j+1) begin
                    lru_cache[i][j] <= 32'b0;
                end
            end 
        end
    end else begin
    if ( tactic == 1'b1) begin     // FIFO
          case(cache_stat)
        IDLE:       begin
                        if( cache_hit ) begin
                            if(rd_req) begin    // ���cache���У������Ƕ�����
                                rd_data <= cache_mem[set_addr][index_hit][line_addr];   //��ֱ�Ӵ�cache��ȡ��Ҫ��������
                            end else if(wr_req) begin // ���cache���У�������д����
                                cache_mem[set_addr][index_hit][line_addr] <= wr_data;   // ��ֱ����cache��д����??
                                dirty[set_addr][index_hit] <= 1'b1;                     // д���ݵ�ͬʱ����??
                            end 
                        end else begin
                            if(wr_req | rd_req) begin   // ��� cache δ���У������ж�д��������Ҫ���л�??
                                index_miss = 0;
                                for (integer  i = 0; i<WAY_CNT; i= i+1) begin
                                    fifo_cache [set_addr][i] <= fifo_cache[set_addr][i] +1;
                                end
                                for(integer j = 0; j<WAY_CNT;j = j+1)   begin
                                    index_miss = (fifo_cache[set_addr][j]>fifo_cache[set_addr][index_miss] )?j:index_miss;
                                end 
                                fifo_cache[set_addr][index_miss] = 0;
                                if( valid[set_addr][index_miss] & dirty[set_addr][index_miss] ) begin    // ��� Ҫ�����cache line ������Ч�����࣬����Ҫ�Ƚ�������
                                    cache_stat  <= SWAP_OUT;
                                    mem_wr_addr <= { cache_tags[set_addr][index_miss], set_addr };
                                    mem_wr_line <= cache_mem[set_addr][index_miss];
                                end else begin                                   // ��֮����??Ҫ������ֱ�ӻ���
                                    cache_stat  <= SWAP_IN;
                                end
                                {mem_rd_tag_addr, mem_rd_set_addr} <= {tag_addr, set_addr};
                            end
                        end
                    end
        SWAP_OUT:   begin
                        if(mem_gnt) begin           // ������������ź���Ч��˵�������ɹ���������һ״???
                            cache_stat <= SWAP_IN;
                        end
                    end
        SWAP_IN:    begin
                        if(mem_gnt) begin           // ������������ź���Ч��˵������ɹ���������һ״???
                            cache_stat <= SWAP_IN_OK;
                        end
                    end
        SWAP_IN_OK:begin           // ��һ�����ڻ���ɹ��������ڽ����������lineд��cache��������tag���ø�valid���õ�dirty
                        for(integer i=0; i<LINE_SIZE; i = i+1)  cache_mem[mem_rd_set_addr][index_miss][i] <= mem_rd_line[i];
                        cache_tags[mem_rd_set_addr][index_miss] <= mem_rd_tag_addr;
                        valid     [mem_rd_set_addr][index_miss] <= 1'b1;
                        dirty     [mem_rd_set_addr][index_miss] <= 1'b0;
                        cache_stat <= IDLE;        // �ص�����״???
                   end
        endcase
    end else begin       // LRU
          case(cache_stat)
        IDLE:       begin
                        if( cache_hit ) begin
                            if(rd_req) begin    // ���cache���У������Ƕ�����
                                rd_data = cache_mem[set_addr][index_hit][line_addr];   //��ֱ�Ӵ�cache��ȡ��Ҫ��������
                            end else if(wr_req) begin // ���cache���У�������д����
                                cache_mem[set_addr][index_hit][line_addr] = wr_data;   // ��ֱ����cache��д����??
                                dirty[set_addr][index_hit] = 1'b1;                     // д���ݵ�ͬʱ����??
                            end 
                            for (integer i  = 0; i<WAY_CNT; i =i+1) begin
                                    lru_cache[set_addr][i] <= lru_cache[set_addr][i] + 1;
                            end
                            lru_cache[set_addr][index_hit] = 0;
                        end else begin
                            if(wr_req | rd_req) begin   // ��� cache δ���У������ж�д��������Ҫ���л�??
                                index_miss = 0;
                                for(integer j =0; j<WAY_CNT;j = j+1) begin
                                    index_miss = (lru_cache[set_addr][j] > lru_cache[set_addr][index_miss])?j:index_miss;
                                end 
                                for(integer i = 0; i<WAY_CNT;i = i+1) begin
                                    lru_cache[set_addr][i] <= lru_cache[set_addr][i] + 1;
                                end 
                                lru_cache[set_addr][index_miss]  = 0;
                                if( valid[set_addr][index_miss] & dirty[set_addr][index_miss] ) begin    // ��� Ҫ�����cache line ������Ч�����࣬����Ҫ�Ƚ�������
                                    cache_stat  <= SWAP_OUT;
                                    mem_wr_addr <= { cache_tags[set_addr][index_miss], set_addr };
                                    mem_wr_line <= cache_mem[set_addr][index_miss];
                                end else begin                                   // ��֮����??Ҫ������ֱ�ӻ���
                                    cache_stat  <= SWAP_IN;
                                end
                                {mem_rd_tag_addr, mem_rd_set_addr} <= {tag_addr, set_addr};
                            end
                        end
                    end
        SWAP_OUT:   begin
                        if(mem_gnt) begin           // ������������ź���Ч��˵�������ɹ���������һ״???
                            cache_stat <= SWAP_IN;
                        end
                    end
        SWAP_IN:    begin
                        if(mem_gnt) begin           // ������������ź���Ч��˵������ɹ���������һ״???
                            cache_stat <= SWAP_IN_OK;
                        end
                    end
        SWAP_IN_OK:begin           // ��һ�����ڻ���ɹ��������ڽ����������lineд��cache��������tag���ø�valid���õ�dirty
                        for(integer i=0; i<LINE_SIZE; i++)  cache_mem[mem_rd_set_addr][index_miss][i] <= mem_rd_line[i];
                        cache_tags[mem_rd_set_addr][index_miss] <= mem_rd_tag_addr;
                        valid     [mem_rd_set_addr][index_miss] <= 1'b1;
                        dirty     [mem_rd_set_addr][index_miss] <= 1'b0;
                        cache_stat <= IDLE;        // �ص�����״???
                   end
        endcase
    end
      
    end
end

wire mem_rd_req = (cache_stat == SWAP_IN );
wire mem_wr_req = (cache_stat == SWAP_OUT);
wire [   MEM_ADDR_LEN-1 :0] mem_addr = mem_rd_req ? mem_rd_addr : ( mem_wr_req ? mem_wr_addr : 0);

assign miss = (rd_req | wr_req) & ~(cache_hit && cache_stat==IDLE) ;     // ?? �ж�д����ʱ�����cache�����ھ�??(IDLE)״???����???δ���У���miss=1

main_mem #(     // ���棬ÿ�ζ�д��line Ϊ��??
    .LINE_ADDR_LEN  ( LINE_ADDR_LEN          ),
    .ADDR_LEN       ( MEM_ADDR_LEN           )
) main_mem_instance (
    .clk            ( clk                    ),
    .rst            ( rst                    ),
    .gnt            ( mem_gnt                ),
    .addr           ( mem_addr               ),
    .rd_req         ( mem_rd_req             ),
    .rd_line        ( mem_rd_line            ),
    .wr_req         ( mem_wr_req             ),
    .wr_line        ( mem_wr_line            )
);

endmodule





