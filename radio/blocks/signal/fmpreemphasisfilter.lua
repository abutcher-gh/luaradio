local block = require('radio.core.block')

local SinglepoleHighpassFilterBlock = require('radio.blocks.signal.singlepolehighpassfilter')

local FMPreemphasisFilterBlock = block.factory("FMPreemphasisFilterBlock", SinglepoleHighpassFilterBlock)

function FMPreemphasisFilterBlock:instantiate(tau)
    assert(tau, "Missing argument #1 (tau)")
    SinglepoleHighpassFilterBlock.instantiate(self, 1/(2*math.pi*tau))
end

return FMPreemphasisFilterBlock
