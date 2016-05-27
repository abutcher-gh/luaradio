local ffi = require('ffi')

local block = require('radio.core.block')
local types = require('radio.types')
local filter_utils = require('radio.blocks.signal.filter_utils')

local FIRFilterBlock = require('radio.blocks.signal.firfilter')

local HighpassFilterBlock = block.factory("HighpassFilterBlock", FIRFilterBlock)

function HighpassFilterBlock:instantiate(num_taps, cutoff, nyquist, window_type)
    assert(num_taps, "Missing argument #1 (num_taps)")
    self.cutoff = assert(cutoff, "Missing argument #2 (cutoff)")
    self.window_type = window_type or "hamming"
    self.nyquist = nyquist

    FIRFilterBlock.instantiate(self, types.Float32.vector(num_taps))
end

function HighpassFilterBlock:initialize()
    -- Compute Nyquist frequency
    local nyquist = self.nyquist or (self:get_rate()/2)

    -- Generate taps
    local taps = filter_utils.firwin_highpass(self.taps.length, self.cutoff/nyquist, self.window_type)
    self.taps = types.Float32.vector_from_array(taps)

    FIRFilterBlock.initialize(self)
end

return HighpassFilterBlock
