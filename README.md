- [Neovim 配置笔记](#neovim-配置笔记)
  - [配置文件存储目录](#配置文件存储目录)
  - [init.vim & init.lua](#initvim--initlua)
  - [记录配置过程](#记录配置过程)
    - [基本设置](#基本设置)
    - [配置packer.vim](#配置packervim)
    - [添加其它的三方库](#添加其它的三方库)
    - [添加Language Protocol Sever (LSP)](#添加language-protocol-sever-lsp)
      - [下载并编译 cquery](#下载并编译-cquery)
      - [下载 LanguageClient.exe](#下载-languageclientexe)

# Neovim 配置笔记

## 配置文件存储目录

neovim从哪里读取配置文件？linux上我没有查询，但是在windows上，可以明确告诉大家，配置文件是存在`~/AppData/Local/nvim`里的，同时更新数据是存在`~/AppData/Local/nvim-data`里的，所以我们可以使用`junction`，先在其它磁盘上创建两个文件夹`config`和`data`，再在`~/AppData/Local`里创建硬链接`nvim`和`nvim-data`，这样就方便我们自己管理配置文件了。

## init.vim & init.lua

neovim支持完全使用lua配置，但是可能由于历史原因，有些离不开init.vim，所以很多教程还是基于init.vim的，实际上没有init.vim文件的话，neovim也会直接去加载init.lua。

## 记录配置过程

### 基本设置

为什么我们要从基本设置开始呢，因为它涉及的东西非常少，我们先通过它搞明白`init.vim`是怎么调用lua脚本的。

首先我们在`init.vim`里，添加
`lua require('settings')`
，于是在程序启动的时候，nvim就会从config/lua/里查找。
我们在`config`目录下创建`lua`目录，再在这个目录里添加一个名为`settings.lua`的文件，其实文件名是什么都不重要，只要跟`init.vim`里一致就可以了。  

那么我们在`settings.lua`里写什么呢，实际上跟`VimL`是一致的，不过我们需要在`lua`里转换成跟`VimL`一致的写法:

1. 原生命令转换

`vim.cmd("set notimeout")`等价于在 .vim文件里写 `set notimeout`，更进一步，
```lua
vim.cmd([[
    set notimeout
    set encoding=utf-8
]])
```
等价于`VimL`中
```VimL
set notimeout
set encoding=utf-8
```

2. 全局变量转换

`vim.g.mapleader = ","`  等价于 VimL `let g:mapleader=','`

3. 表配置转换的

`vim.o.encoding="utf-8"` -> `set encoding=utf-8`

> o 即 option

|Lua|Vim|释义|
|-|-|-|
|o|option| * |
|wo|window option| * |
|bo|buffer option| * |

lua配置示例：

```lua
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jk移动时光标下上方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "80"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
```

当前目标结构为：

```cmd
D:\SOFTWARE\NEOVIM\CONFIG
│   init.vim
│
├───lua
│   │   settings.lua
│   │
│   └───plugins_config
```

futher more:

https://www.notonlycode.org/neovim-lua-config/

### 配置packer.vim

vim和nvim在发展的过程中出现了非常多的包管理工具，早期 的vundle和后来的vim-plug都是典型的代表，但是从nvim后期开始，推荐使用packer.lua作为包管理工具，于是我们也跟着学习和使用它，确实是比较方便。

打开`packer.vim`的主页，
`https://github.com/wbthomason/packer.nvim`

文档里有这么一段，我们使用Windows Terminal的话  
```ps
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```
就可以了，然后开始配置init.vim和lua脚本。

我们在`lua`目录里添加名为`plugins.lua`，内容为

```lua
-- 启用 packer.vim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    function()
        -- 使用packer.vim管理它自己
        use 'wbthomason/packer.nvim'
    end
)
```

于是我们可以在这个`function`里添加其它的三方库了

### 添加其它的三方库

比如说，我们要为nvim添加文件夹树的功能，我们选用
`https://github.com/kyazdani42/nvim-tree.lua`
我们去它的`github`主页看看文档。
```lua
use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
}
```
即，我们在原基础上改为
```lua
-- 启用 packer.vim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    function()
        -- 使用packer.vim管理它自己
        use 'wbthomason/packer.nvim'
        -- 添加nvim-tree三方库
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
            config = function() require'nvim-tree'.setup {} end
        }
    end
)
```
这样就可以了！

我们打开nvim，在命令模式下输入`PackerSync`，它就会自动安装这些插件了，然后我们在命令模式下输入：`NvimTreeToggle`就可以启用和关闭文件夹树窗口了。

那从git上下载下来的源代码在哪呢？其实是在我们的nvim-data文件夹里，准确说是`nvim-data/site/pack/packer/start`目录里。

### 添加Language Protocol Sever (LSP)

lsp有两端，client/server，那我们在`neovim`端配置的实际是`client`端，`client`端可选的也不少，这里我们选`LanguageClient-nvim`，我们在`plugins.lua`里添加这个插件及期依赖的插件：
```lua
use 'Shougo/deoplete.nvim'
use 'Shougo/neosnippet.vim'
use 'Shougo/neosnippet-snippets' 
use 'autozimu/LanguageClient-neovim'
```

在`plugins_config`文件夹里添加这些插件对应的设置，这是我们写的设置而已，命名其实不太重要，只是为了更清晰我才将它们分开配置的。

langclient-nvim.lua

```lua
local config_path = '~/AppData/Local/nvim/config'

vim.g.LanguageClient_serverCommands = {
    "cpp" : [
        config_path..'/bin/cquery', -- cquery 程序
        '--log-file='config_path..'/log/cquery.log', -- log文件
        '--init={\"cacheDirectory\":\"'..config_path..'/cache/cquery', -- 缓存位置
    ]
}
```

depolete.lua
```lua
vim.g.deoplete.enable_at_startup = true
```
#### 下载并编译 cquery

编译之前我们应该从llvm官方下载clang for windows编译器，然后我们使用cmake/clang去编译这个库：

```ps
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
```

下载之来之后先不要急着编译，我们先修改一处配置，这样才能使用我们自己下载的编译器去配置，在cmakelists.txt里找着这一处
```
option(SYSTEM_CLANG "Use system installation of Clang instead of \
       downloading Clang" OFF)
```
OFF 改为 ON
然后编译`cquery`（可能有编译错误，没关系，自己改下源码就行了，非常简单的错误）。

在`confg`目录下创建一个文件夹，名为`bin`，将编译后的`cquery`放入此文件夹。

#### 下载 LanguageClient.exe

打开LanguageClient-neovim源码目录，这个我们已经使用`PackerSync`下载下来了，我们找到它，里面有个`install.ps1`，我们在powershell里执行
`powershell -executionpolicy bypass -File install.ps1`。
等待它下载完成（推荐科学上网下载，因为太慢了！）。

相关链接：
https://github.com/autozimu/LanguageClient-neovim/blob/next/INSTALL.md