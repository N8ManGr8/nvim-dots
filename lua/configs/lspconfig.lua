require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "stylua" }
vim.lsp.enable(servers)

-- nvim-lspconfig's rust_analyzer root_dir runs `cargo metadata --manifest-path ...`
-- without a cwd, so it inherits nvim's cwd. Cargo discovers .cargo/config.toml by
-- walking up from the cwd, *not* from the manifest path, so any project relying on
-- config there (e.g. `[unstable] bindeps = true`) fails with exit 101 and the server
-- never attaches. Run cargo from the crate dir instead, and fall back to the crate
-- dir rather than bailing when it still fails.
vim.lsp.config("rust_analyzer", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Files outside any workspace (registry deps, toolchain sources) reuse the
    -- most recent client's root so we don't spawn a server per dependency.
    local home = vim.fs.normalize(vim.env.HOME)
    local cargo_home = vim.env.CARGO_HOME or home .. "/.cargo"
    local rustup_home = vim.env.RUSTUP_HOME or home .. "/.rustup"
    for _, dir in ipairs {
      cargo_home .. "/registry/src",
      cargo_home .. "/git/checkouts",
      rustup_home .. "/toolchains",
    } do
      if vim.fs.relpath(dir, fname) then
        local clients = vim.lsp.get_clients { name = "rust_analyzer" }
        if #clients > 0 then
          return on_dir(clients[#clients].config.root_dir)
        end
      end
    end

    local crate_dir = vim.fs.root(fname, { "Cargo.toml" })
    if not crate_dir then
      return on_dir(
        vim.fs.root(fname, { "rust-project.json" })
          or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
      )
    end

    vim.system(
      { "cargo", "metadata", "--no-deps", "--format-version", "1" },
      { cwd = crate_dir, text = true },
      function(out)
        if out.code ~= 0 then
          vim.schedule(function()
            vim.notify(
              ("[rust_analyzer] cargo metadata failed (%d), using %s as root\n%s"):format(
                out.code,
                crate_dir,
                out.stderr
              ),
              vim.log.levels.WARN
            )
          end)
          return on_dir(crate_dir)
        end

        local ok, meta = pcall(vim.json.decode, out.stdout)
        on_dir(ok and meta and meta.workspace_root and vim.fs.normalize(meta.workspace_root) or crate_dir)
      end
    )
  end,
})

vim.lsp.inlay_hint.enable(true)
