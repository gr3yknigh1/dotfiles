
-- # Available LSP servers 
-- (2022-11-15)
-- | ----------------------------------- | -------------------------- |
-- | Language                            | Server name                |
-- | ----------------------------------- | -------------------------- |
-- | AWK                                 | `awk_ls`                   |
-- | Ada                                 | `als`                      |
-- | Angular                             | `angularls`                |
-- | Ansible                             | `ansiblels`                |
-- | Apex                                | `apex_ls`                  |
-- | Arduino                             | `arduino_language_server`  |
-- | Assembly (GAS/NASM, GO)             | `asm_lsp`                  |
-- | Astro                               | `astro`                    |
-- | Bash                                | `bashls`                   |
-- | Beancount                           | `beancount`                |
-- | Bicep                               | `bicep`                    |
-- | Buf                                 | `bufls`                    |
-- | C                                   | `clangd`                   |
-- | C#                                  | `csharp_ls`                |
-- | C# [(docs)][omnisharp]              | `omnisharp_mono`           |
-- | C# [(docs)][omnisharp]              | `omnisharp`                |
-- | C++                                 | `clangd`                   |
-- | CMake                               | `cmake`                    |
-- | CSS                                 | `cssls`                    |
-- | CSS                                 | `cssmodules_ls`            |
-- | Clarity                             | `clarity_lsp`              |
-- | Clojure                             | `clojure_lsp`              |
-- | CodeQL                              | `codeqlls`                 |
-- | Crystal                             | `crystalline`              |
-- | Cucumber                            | `cucumber_language_server` |
-- | Cue                                 | `dagger`                   |
-- | Deno                                | `denols`                   |
-- | Dhall                               | `dhall_lsp_server`         |
-- | Diagnostic (general purpose server) | `diagnosticls`             |
-- | Dlang                               | `serve_d`                  |
-- | Docker                              | `dockerls`                 |
-- | Dot                                 | `dotls`                    |
-- | EFM (general purpose server)        | `efm`                      |
-- | ESLint                              | `eslint`                   |
-- | Elixir                              | `elixirls`                 |
-- | Elm                                 | `elmls`                    |
-- | Ember                               | `ember`                    |
-- | Emmet                               | `emmet_ls`                 |
-- | Erg                                 | `erg_language_server`      |
-- | Erlang                              | `erlangls`                 |
-- | F#                                  | `fsautocomplete`           |
-- | Flux                                | `flux_lsp`                 |
-- | Foam (OpenFOAM)                     | `foam_ls`                  |
-- | Fortran                             | `fortls`                   |
-- | Glint                               | `glint`                    |
-- | Go                                  | `golangci_lint_ls`         |
-- | Go                                  | `gopls`                    |
-- | Gradle                              | `gradle_ls`                |
-- | Grammarly                           | `grammarly`                |
-- | GraphQL                             | `graphql`                  |
-- | Groovy                              | `groovyls`                 |
-- | HTML                                | `html`                     |
-- | Haskell                             | `hls`                      |
-- | Haxe                                | `haxe_language_server`     |
-- | Hoon                                | `hoon_ls`                  |
-- | JSON                                | `jsonls`                   |
-- | Java                                | `jdtls`                    |
-- | JavaScript                          | `quick_lint_js`            |
-- | JavaScript                          | `tsserver`                 |
-- | Jsonnet                             | `jsonnet_ls`               |
-- | Julia [(docs)][julials]             | `julials`                  |
-- | Kotlin                              | `kotlin_language_server`   |
-- | LaTeX                               | `ltex`                     |
-- | LaTeX                               | `texlab`                   |
-- | Lelwel                              | `lelwel_ls`                |
-- | Lua                                 | `sumneko_lua`              |
-- | Luau                                | `luau_lsp`                 |
-- | Markdown                            | `marksman`                 |
-- | Markdown                            | `prosemd_lsp`              |
-- | Markdown                            | `remark_ls`                |
-- | Markdown                            | `zk`                       |
-- | Metamath Zero                       | `mm0_ls`                   |
-- | Nickel                              | `nickel_ls`                |
-- | Nim                                 | `nimls`                    |
-- | Nix                                 | `rnix`                     |
-- | OCaml                               | `ocamllsp`                 |
-- | OneScript, 1C:Enterprise            | `bsl_ls`                   |
-- | OpenAPI                             | `spectral`                 |
-- | OpenCL                              | `opencl_ls`                |
-- | PHP                                 | `intelephense`             |
-- | PHP                                 | `phpactor`                 |
-- | PHP                                 | `psalm`                    |
-- | Perl                                | `perlnavigator`            |
-- | Powershell                          | `powershell_es`            |
-- | Prisma                              | `prismals`                 |
-- | Puppet                              | `puppet`                   |
-- | PureScript                          | `purescriptls`             |
-- | Python                              | `jedi_language_server`     |
-- | Python                              | `pyright`                  |
-- | Python                              | `sourcery`                 |
-- | Python [(docs)][pylsp]              | `pylsp`                    |
-- | R                                   | `r_language_server`        |
-- | ReScript                            | `rescriptls`               |
-- | Reason                              | `reason_ls`                |
-- | Robot Framework                     | `robotframework_ls`        |
-- | Rome                                | `rome`                     |
-- | Ruby                                | `ruby_ls`                  |
-- | Ruby                                | `solargraph`               |
-- | Rust                                | `rust_analyzer`            |
-- | SQL                                 | `sqlls`                    |
-- | SQL                                 | `sqls`                     |
-- | Salt                                | `salt_ls`                  |
-- | Shopify Theme Check                 | `theme_check`              |
-- | Slint                               | `slint_lsp`                |
-- | Solidity                            | `solang`                   |
-- | Solidity                            | `solc`                     |
-- | Solidity                            | `solidity`                 |
-- | Sorbet                              | `sorbet`                   |
-- | Sphinx                              | `esbonio`                  |
-- | Stylelint                           | `stylelint_lsp`            |
-- | Svelte                              | `svelte`                   |
-- | SystemVerilog                       | `svlangserver`             |
-- | SystemVerilog                       | `svls`                     |
-- | SystemVerilog                       | `verible`                  |
-- | TOML                                | `taplo`                    |
-- | Tailwind CSS                        | `tailwindcss`              |
-- | Teal                                | `teal_ls`                  |
-- | Terraform                           | `terraformls`              |
-- | Terraform [(docs)][tflint]          | `tflint`                   |
-- | TypeScript                          | `tsserver`                 |
-- | V                                   | `vls`                      |
-- | Vala                                | `vala_ls`                  |
-- | VimL                                | `vimls`                    |
-- | Visualforce                         | `visualforce`              |
-- | Vue                                 | `volar`                    |
-- | Vue                                 | `vuels`                    |
-- | WGSL                                | `wgsl_analyzer`            |
-- | XML                                 | `lemminx`                  |
-- | YAML                                | `yamlls`                   |
-- | Zig                                 | `zls`                      |

local language_servers = require('lsps')

require("mason-lspconfig").setup({
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = language_servers,

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
})

