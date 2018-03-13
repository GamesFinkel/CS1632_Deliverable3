require 'minitest/autorun'
require 'minitest/mock'

require_relative 'Blockchain'
require_relative 'Block'


class BlockchainTest < Minitest::Test

    def test_good_block
        blockA = Block.new 0, '0', '', 1, 1, '1d4e'
        blockB = Block.new 1, '1d4e', '', 1, 2, 'c189'

        blockchain = Blockchain.new
        blockchain.applyBlock blockA, 0
        blockchain.applyBlock blockB, 1
    end

    def test_bad_start_block
        blockInit = Block.new 42, 0,"", 1, 0, ''

        blockchain = Blockchain.new
        assert_raises RuntimeError do
            blockchain.applyBlock blockInit,0
        end
    end

    def test_out_of_order_id
        blockInit = Block.new 0, '0', "", 1, 0, '5e36'
        blockA = Block.new 1, blockInit.hash, "", 2, 0, 'd459'
        blockB = Block.new 1, blockA.hash, "", 3, 0, ''

        blockchain = Blockchain.new
        blockchain.applyBlock blockInit,0
        blockchain.applyBlock blockA,1
        assert_raises RuntimeError do
            blockchain.applyBlock blockB,2
        end
    end

    def test_bad_timestamp
        blockA = Block.new 0, '0', "", 2, 0, '5ac4'
        blockB = Block.new 1, blockA.hash, "", 1, 0, ''

        blockchain = Blockchain.new
        blockchain.applyBlock blockA,0
        assert_raises RuntimeError do
            blockchain.applyBlock blockB,1
        end
    end
end

