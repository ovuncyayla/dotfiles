-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
--
--     -- 💀
--     -- 'java', -- or '/path/to/java17_or_newer/bin/java'
--             -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--     '/home/synclab/.jdks/openjdk-19.0.2/bin/java',
--
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--
--     -- 💀
--     '-jar', '/home/synclab/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--          -- Must point to the                                                     Change this to
--          -- eclipse.jdt.ls installation                                           the actual version
--
--
--     -- 💀
--     '-configuration', '/home/synclab/.local/share/nvim/mason/packages/jdtls/config_linux',
--                     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--                     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--                     -- eclipse.jdt.ls installation            Depending on your system.
--
--
--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data', '/home/synclab/reply/unipol/src/pp/source', --'/home/synclab/.cache/jdtls/workspace'
--   },
--
--   -- 💀
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml'}),
--
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--     }
--   },
--
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = {}
--   },
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)


local M = {
    name = "jdtls",
    config = function()
        local config = {
            cmd = {
                -- NOTE(d.paro): At the time of writing, Wed 23 2022, eclipse.jdt.ls requires Java 17 or higher
                --         See https://github.com/mfussenegger/nvim-jdtls#configuration-quickstart
                --         If this ever changes in the future
                "/usr/lib/jvm/java-17-openjdk/bin/java",
                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                -- https://projectlombok.org/
                -- "-javaagent:" .. path.concat { nvim_data_path, "mason", "packages", "jdtls", "lombok.jar" },
                "-Xms1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",
                -- "-jar", vim.fn.glob(path.concat { jdtls_root_path, "plugins", "org.eclipse.equinox.launcher_*.jar" }),
                '-jar', '/home/synclab/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
                -- "-configuration", path.concat { jdtls_root_path, "config_linux" },
                '-configuration', '/home/synclab/.local/share/nvim/mason/packages/jdtls/config_linux',
                -- "-data", path.concat { nvim_cache_path, "jdtls", string.gsub(project_path, path.separator, "%%") },
                '-data', '/home/synclab/reply/unipol/jdtlsworkspace/pp/source', --'/home/synclab/.cache/jdtls/workspace'
            },

            root_dir = require("jdtls.setup").find_root {
                ".git",
                "mvnw",
                "gradlew",
                "build.xml",
                "pom.xml",
                "settings.gradle",
                "settings.gradle.kts",
                "build.gradle",
                "build.gradle.kts",
            },
            -- Here you can configure eclipse.jdt.ls specific settings
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- for a list of options
            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                        },
                        hashCodeEquals = {
                            useJava7Objects = true,
                        },
                        useBlocks = true,
                    },
                    configuration = {
                        -- Configure the JAVA runtimes available to eclipse.
                        --    Can switch Java Runtime from neovim after starting with :JdtSetRuntime
                        runtimes = {
                            -- {
                            --     name = "JavaSE-1.8",
                            --     path = "/usr/lib/jvm/java-1.8.0-openjdk/",
                            -- },
                            -- {
                            --     name = "JavaSE-11",
                            --     path = "/usr/lib/jvm/java-11-openjdk/",
                            -- },
                            -- {
                            --     name = "JavaSE-17",
                            --     path = "/usr/lib/jvm/java-17-openjdk/",
                            -- },
                            {
                                name = "JavaSE-19",
                                path = "/home/synclab/.jdks/openjdk-19.0.2/",
                            },
                        },
                    },
                    format = {
                        enabled = true,
                        tabSize = 4,
                        insertSpaces = true,
                        onType = false,
                        settings = {
                            profile = "GoogleStyle",
                            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                        },
                    },
                },
            },
            init_options = {
                extendedClientCapabilities = {
                    progressReportProvider = true,
                    classFileContentsSupport = true,
                    generateToStringPromptSupport = true,
                    hashCodeEqualsPromptSupport = true,
                    advancedExtractRefactoringSupport = true,
                    advancedOrganizeImportsSupport = true,
                    generateConstructorsPromptSupport = true,
                    generateDelegateMethodsPromptSupport = true,
                    moveRefactoringSupport = true,
                    overrideMethodsPromptSupport = true,
                    inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
                    resolveAdditionalTextEditsSupport = true,
                },
            },
        }

        local bundles = {}

        -- See : https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        -- vim.list_extend(
        --     bundles,
        --     vim.split(
        --         vim.fn.glob(
        --             path.concat {
        --                 nvim_data_path,
        --                 "mason",
        --                 "packages",
        --                 "java-debug-adapter",
        --                 "extension",
        --                 "server",
        --                 "com.microsoft.java.debug.plugin-*.jar",
        --             },
        --             1
        --         ),
        --         "\n"
        --     )
        -- )
        --
        -- -- See: https://github.com/mfussenegger/nvim-jdtls#vscode-java-test-installation
        -- vim.list_extend(
        --     bundles,
        --     vim.split(
        --         vim.fn.glob(
        --             path.concat {
        --                 nvim_data_path,
        --                 "mason",
        --                 "packages",
        --                 "java-test",
        --                 "extension",
        --                 "server",
        --                 "*.jar",
        --             },
        --             1
        --         ),
        --         "\n"
        --     )
        -- )

        config["init_options"] = config["init_options"] or {}
        config["init_options"].bundles = bundles

        -- mute; having progress reports is enough
        if false then
            config.handlers = config.handlers or {}
            config.handlers["language/status"] = function() end
        end

        return config
    end,
}

return M.config()
