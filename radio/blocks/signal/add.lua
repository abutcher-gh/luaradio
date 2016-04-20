local block = require('radio.core.block')
local types = require('radio.types')

local AddBlock = block.factory("AddBlock")

function AddBlock:instantiate()
    self:add_type_signature({block.Input("in1", types.ComplexFloat32), block.Input("in2", types.ComplexFloat32)}, {block.Output("out", types.ComplexFloat32)})
    self:add_type_signature({block.Input("in1", types.Float32), block.Input("in2", types.Float32)}, {block.Output("out", types.Float32)})
end

function AddBlock:initialize()
    self.out = self:get_output_type().vector()
end

function AddBlock:process(x, y)
    local out = self.out:resize(x.length)

    for i = 0, x.length-1 do
        out.data[i] = x.data[i] + y.data[i]
    end

    return out
end

return AddBlock