local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        toml = { "taplo" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        lsp_fallback = true,
    },

    formatters = {
        taplo = {
            args = {
                "format",
                "--option=indent_string=    ",
                "--option=array_auto_collapse=false",
                "--stdin-filepath",
                "$FILENAME",
                "-",
            },
        },
    },
}

return options
