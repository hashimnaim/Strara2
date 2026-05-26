# Strara2
Strara2 is a lightweight module loader and requries modules at light-speed.
It is strictly typed and easy to use for both server-sides and client-sides.

Built for scalability, Strara automatically collects and requires ModuleScripts from folders and tags, making it easy to organize and initialize your game systems.

## ✨ Features
- 📦 Automatically loads ModuleScripts from a folder
- 🌲 Supports nested modules
- 🏷️ Tag-based module loading using CollectionService
- ⚡ Simple and fast requiring system
- 🖥️ Server/Client logging support

## 🚀 Usage

```lua
-- Require the strara module on your script.
local Strara = require(path.to.Strara);

-- Loads strara
Strara.load(path);
```
