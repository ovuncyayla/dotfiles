local function discover_jdks()
  local jdks_dir = vim.fn.expand("~/.jdks")
  local runtimes = {}
  if vim.fn.isdirectory(jdks_dir) == 0 then
    return runtimes
  end

  for _, entry in ipairs(vim.fn.readdir(jdks_dir)) do
    local path = jdks_dir .. "/" .. entry
    if vim.fn.isdirectory(path) == 1 and vim.fn.filereadable(path .. "/bin/java") == 1 then
      local release = path .. "/release"
      local major
      if vim.fn.filereadable(release) == 1 then
        for _, line in ipairs(vim.fn.readfile(release)) do
          local v = line:match('^JAVA_VERSION="([^"]+)"')
          if v then
            major = v:match("^1%.(%d+)") or v:match("^(%d+)")
            break
          end
        end
      end
      if not major then
        major = entry:match("(%d+)")
      end
      if major then
        table.insert(runtimes, {
          name = "JavaSE-" .. major,
          path = path,
          _major = tonumber(major),
        })
      end
    end
  end

  table.sort(runtimes, function(a, b)
    return a._major > b._major
  end)
  if runtimes[1] then
    runtimes[1].default = true
  end
  for _, r in ipairs(runtimes) do
    r._major = nil
  end
  return runtimes
end

-- jdtls 1.54.0 officially supports JDK 17/21. JDK 24+ tightens
-- "restricted method" access for native code, which breaks Equinox's
-- JNIBridge during OSGi bundle resolution. Pick the highest LTS in the
-- supported range for the launcher; project-level runtimes are independent.
local function jdtls_launcher_java(runtimes)
  local preferred = { 21, 17 }
  for _, want in ipairs(preferred) do
    for _, r in ipairs(runtimes) do
      if tonumber(r.name:match("(%d+)$")) == want then
        return r.path .. "/bin/java"
      end
    end
  end
  for _, r in ipairs(runtimes) do
    local v = tonumber(r.name:match("(%d+)$"))
    if v and v >= 17 and v <= 23 then
      return r.path .. "/bin/java"
    end
  end
  return runtimes[1] and (runtimes[1].path .. "/bin/java") or "java"
end

local java_keys = {
  { "<leader>jm", "<cmd>JavaRunnerRunMain<cr>", desc = "Run main", ft = "java" },
  { "<leader>jM", "<cmd>JavaRunnerStopMain<cr>", desc = "Stop main", ft = "java" },
  { "<leader>jl", "<cmd>JavaRunnerToggleLogs<cr>", desc = "Toggle runner logs", ft = "java" },
  { "<leader>jp", "<cmd>JavaProfile<cr>", desc = "Profiles (Spring Boot)", ft = "java" },

  { "<leader>jb", "<cmd>JavaBuildBuildWorkspace<cr>", desc = "Build workspace", ft = "java" },
  { "<leader>jB", "<cmd>JavaBuildCleanWorkspace<cr>", desc = "Clean workspace", ft = "java" },

  { "<leader>jtt", "<cmd>JavaTestRunCurrentClass<cr>", desc = "Test class", ft = "java" },
  { "<leader>jtm", "<cmd>JavaTestRunCurrentMethod<cr>", desc = "Test method", ft = "java" },
  { "<leader>jta", "<cmd>JavaTestRunAllTests<cr>", desc = "Test all", ft = "java" },
  { "<leader>jtv", "<cmd>JavaTestViewLastReport<cr>", desc = "View last test report", ft = "java" },

  { "<leader>jdc", "<cmd>JavaDapConfig<cr>", desc = "Reconfigure DAP", ft = "java" },
  { "<leader>jdt", "<cmd>JavaTestDebugCurrentClass<cr>", desc = "Debug test class", ft = "java" },
  { "<leader>jdm", "<cmd>JavaTestDebugCurrentMethod<cr>", desc = "Debug test method", ft = "java" },
  { "<leader>jda", "<cmd>JavaTestDebugAllTests<cr>", desc = "Debug all tests", ft = "java" },

  { "<leader>jss", "<cmd>JavaSettingsChangeRuntime<cr>", desc = "Change JDK runtime", ft = "java" },

  { "<leader>jrm", "<cmd>JavaRefactorExtractMethod<cr>", desc = "Extract method", mode = { "n", "x" }, ft = "java" },
  { "<leader>jrv", "<cmd>JavaRefactorExtractVariable<cr>", desc = "Extract variable", mode = { "n", "x" }, ft = "java" },
  { "<leader>jrV", "<cmd>JavaRefactorExtractVariableAllOccurrence<cr>", desc = "Extract variable (all occurrences)", mode = { "n", "x" }, ft = "java" },
  { "<leader>jrc", "<cmd>JavaRefactorExtractConstant<cr>", desc = "Extract constant", mode = { "n", "x" }, ft = "java" },
  { "<leader>jrf", "<cmd>JavaRefactorExtractField<cr>", desc = "Extract field", mode = { "n", "x" }, ft = "java" },
}

return {
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    keys = java_keys,
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "JavaHello/spring-boot.nvim",
      {
        "mason-org/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    opts = {
      jdk = {
        auto_install = false,
      },
      spring_boot_tools = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("java").setup(opts)

      local runtimes = discover_jdks()
      local java_bin = jdtls_launcher_java(runtimes)

      local root_markers = {
        "settings.gradle",
        "settings.gradle.kts",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts",
        "mvnw",
        "gradlew",
        ".git",
      }

      vim.lsp.config("jdtls", {
        cmd_env = {
          JAVA_HOME = vim.fn.fnamemodify(java_bin, ":h:h"),
        },
        root_markers = root_markers,
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local found = vim.fs.root(fname, root_markers)
          on_dir(found or vim.fn.getcwd())
        end,
        settings = {
          java = {
            configuration = {
              runtimes = runtimes,
            },
          },
        },
      })

      local prev = vim.lsp.config["jdtls"] or {}
      if type(prev.cmd) == "table" and prev.cmd[1] == "java" then
        local new_cmd = vim.deepcopy(prev.cmd)
        new_cmd[1] = java_bin
        vim.lsp.config("jdtls", { cmd = new_cmd })
      end

      vim.lsp.enable("jdtls")
    end,
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>j", group = "java", icon = { icon = "󰬷 ", color = "orange" } },
        { "<leader>jd", group = "debug" },
        { "<leader>jt", group = "test" },
        { "<leader>jr", group = "refactor" },
        { "<leader>js", group = "settings" },
      },
    },
  },
}
