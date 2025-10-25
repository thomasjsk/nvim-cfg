return {
    "ellisonleao/glow.nvim",
    config = function()
        require('glow').setup({
            width_ratio = 0.9,
            width = 200,
            height_ratio = 0.9,
        })
    end,
    cmd = "Glow"
}



