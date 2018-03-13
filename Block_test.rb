require 'minitest/autorun'
require 'minitest/mock'

require_relative 'Block'


class BlockTest < Minitest::Test
    def test_hash
        blockInit = Block.new 8, "e01d","Sam>John(3):Joe>Sam(4):SYSTEM>Rana(100)",1518839370,605237540,"c87b"
        assert_equal blockInit.expectedBlockHash,blockInit.hash
    end

    def test_hash_2
        blockInit = Block.new 0,0,"SYSTEM>Henry(100)",1518892051,737141000,"1c12"
        assert_equal blockInit.expectedBlockHash,blockInit.hash
    end

    def test_correct_block_time_seconds
        firstBlock = Block.new 0, 0, "SYSTEM>Henry(100)", 1, 0, "c87b" 
        secondBlock = Block.new 1, 0, "SYSTEM>Henry(100)", 2, 0, "c87b" 

        refute firstBlock.moreRecentThan? secondBlock
    end

    def test_older_block_time_seconds
        firstBlock = Block.new 0, 0, "SYSTEM>Henry(100)", 1, 0, "c87b" 
        secondBlock = Block.new 1, 0, "SYSTEM>Henry(100)", 2, 0, "c87b" 

        assert secondBlock.moreRecentThan? firstBlock
    end

    def test_correct_block_time_nanoseconds
        firstBlock = Block.new 0, 0, "SYSTEM>Henry(100)", 1, 0, "c87b" 
        secondBlock = Block.new 1, 0, "SYSTEM>Henry(100)", 1, 1, "c87b" 

        refute firstBlock.moreRecentThan? secondBlock
    end

    def test_older_block_time_seconds
        firstBlock = Block.new 0, 0, "SYSTEM>Henry(100)", 1, 0, "c87b" 
        secondBlock = Block.new 1, 0, "SYSTEM>Henry(100)", 1, 1, "c87b" 

        assert secondBlock.moreRecentThan? firstBlock
    end


end

