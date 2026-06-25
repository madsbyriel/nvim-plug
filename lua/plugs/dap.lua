local dap = require("dap")

-- Adapter
dap.adapters.coreclr = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
    args = { "--interpreter=vscode" }
}

dap.adapters.netcoredbg = dap.adapters.coreclr

-- Reads .nvim-dap.json from project root, returns table or nil
local function load_dap_config()
    local config_path = vim.fn.getcwd() .. "/.nvim-dap.json"
    if vim.fn.filereadable(config_path) == 0 then
        return nil
    end
    local lines = vim.fn.readfile(config_path)
    local ok, parsed = pcall(vim.fn.json_decode, table.concat(lines, "\n"))
    if not ok or type(parsed) ~= "table" then
        vim.notify(".nvim-dap.json is invalid JSON", vim.log.levels.WARN)
        return nil
    end
    return parsed
end

-- Add a resolver for cwd
local function resolve_cwd()
    local cfg = load_dap_config()
    local cwd = vim.fn.getcwd()

    if cfg and cfg.cwd then
        -- Expand relative paths against project root
        return cfg.cwd:sub(1, 1) == "/" and cfg.cwd or (cwd .. "/" .. cfg.cwd)
    end

    return cwd  -- default to project root
end

-- Resolves the program path: config file → auto-detect → manual prompt
local function resolve_program()
    local cfg = load_dap_config()
    local cwd = vim.fn.getcwd()

    if cfg and cfg.program then
        -- Expand relative paths against project root
        local path = cfg.program:sub(1, 1) == "/" and cfg.program or (cwd .. "/" .. cfg.program)
        if vim.fn.filereadable(path) == 1 then
            return path
        end
        vim.notify(".nvim-dap.json: program not found at " .. path, vim.log.levels.WARN)
    end

    -- Auto-detect from bin/Debug/net*/
    local project = vim.fn.fnamemodify(cwd, ":t")
    local tf_folders = vim.fn.glob(cwd .. "/bin/Debug/net*", false, true)
    local tf = tf_folders[1] and vim.fn.fnamemodify(tf_folders[1], ":t") or "net8.0"
    local dll = cwd .. "/bin/Debug/" .. tf .. "/" .. project .. ".dll"

    if vim.fn.filereadable(dll) == 1 then
        return dll
    end

    return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
end

-- Merges .nvim-dap.json env on top of the defaults
local function resolve_env()
    local defaults = { ASPNETCORE_ENVIRONMENT = "Development" }
    local cfg = load_dap_config()
    if cfg and type(cfg.env) == "table" then
        return vim.tbl_extend("force", defaults, cfg.env)
    end
    return defaults
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch",
        request = "launch",
        program = resolve_program,
        args = function()
            local cfg = load_dap_config()
            return (cfg and cfg.args) or {}
        end,
        cwd = resolve_cwd,
        stopAtEntry = function()
            local cfg = load_dap_config()
            return (cfg and cfg.stopAtEntry) or false
        end,
        env = resolve_env,
    },
    {
        type = "coreclr",
        name = "Attach",
        request = "attach",
        processId = require("dap.utils").pick_process,
    }
}
