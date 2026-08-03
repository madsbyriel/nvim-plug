pcall(function()
    require('nvim-treesitter').install({ 'c_sharp' })
end)

-- neotest-dotnet's framework-discovery.lua calls iter_matches(..., { all = false })
-- and indexes the first capture as a single TSNode. Neovim 0.12 removed the `all`
-- option, so captures are always TSNode[] lists now, and captures[1] is a list,
-- not a node -- crashing get_node_text(). Unwrap single-element lists here so the
-- plugin's assumption still holds.
do
    local get_node_text = vim.treesitter.get_node_text
    vim.treesitter.get_node_text = function(node, source, opts)
        if type(node) == "table" then
            node = node[1]
        end
        return get_node_text(node, source, opts)
    end
end

-- neotest normally offloads treesitter parsing to a background `nvim --headless -u NONE`
-- subprocess for performance. That subprocess never loads this config, so the patch above
-- wouldn't apply there and the crash would still happen. Disable the subprocess so parsing
-- always runs in-process (where the patch applies); slightly slower discovery, but correct.
require("neotest.lib.subprocess").init = function() end

require("neotest").setup({
    adapters = {
        require("neotest-dotnet")({
            dap = {
                adapter_name = "netcoredbg",
            },
            discovery_root = "project",
        }),
    },
})
