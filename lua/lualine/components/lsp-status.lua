local M = require('lualine.component'):extend()
local utils = require('lualine.utils.utils')

local default_options = {

    -- Control how/when client count should be displayed
    --
    -- The following values are accepted:
    --
    --  * true : Count is displayed if its greater than zero
    --  * false : No count is displayed.
    --  * "always" : Count is displayed regardless of value.
    show_count = true,

    -- true if icon should also be color coded.
    colored = true,

    -- List of filetypes to disable this component for.
    disabled_filetypes = {},

    -- Colors used.
    colors = {
        -- Color used if there are one or more clients connected
        active = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'DiagnosticOk', 'DiagnosticSignOk' },
                '#89dceb'
            )
        },
        -- Color used if there is zero clients connected
        inactive = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'DiagnosticError', 'DiagnosticSignError', 'Error' },
                '#f38ba8'
            )
        },
        -- Color used for the count.
        count = {
            fg = utils.extract_color_from_hllist(
                'fg',
                { 'StatusLineNormal' },
                '#ffffff'
            )
        },
    },

    -- Icon used.
    icons = {
        -- Icon used when there is one or more clients connected
        active = "",

        -- Icon used when there is zero clients connected.
        inactive = ""
    }
}


function M:init(options)
    options = vim.tbl_deep_extend('keep', options or {}, default_options)
    M.super.init(self, options)

    if self.options.colored then
        self.highlights = {
            active = self:create_hl(self.options.colors.active, 'active'),
            inactive = self:create_hl(self.options.colors.inactive, 'inactive'),
            count = self:create_hl(self.options.colors.count, 'count'),
        }
        self.hl = {}
        for name, highlight_name in pairs(self.highlights) do
            self.hl[name] = self:format_hl(highlight_name)
        end
    end
end

function M:format(icon, count)
    if self.config.show_count then
        return string.format("%s %s", icon, count)
    end
    return string.format("%s", icon)
end

function M:update_status()

    if vim.tbl_contains(self.options.disabled_filetypes or {}, vim.bo.filetype) then
        return ""
    end

    local num_clients = #vim.tbl_keys(vim.lsp.get_clients({bufnr = 0}))
    local status = "inactive"
    if num_clients > 0 then
        status = "active"
    end

    local segments = {}

    local icon = self.options.icons[status]
    if self.options.colored then
        table.insert(segments, self.hl[status] .. icon)
    else
        table.insert(segments, icon)
    end

    if self.options.show_count and (num_clients > 0 or self.options.show_count == "always") then
        if self.options.colored then
            table.insert(segments, self.hl["count"] .. num_clients)
        else
            table.insert(segments, num_clients)
        end
    end

    return table.concat(segments, ' ')
end

return M
