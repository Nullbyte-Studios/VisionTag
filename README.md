# Minecraft Plugin Template

A comprehensive template for creating Minecraft Bukkit/Spigot/Paper plugins with modern Java features and best practices.

## 🚀 Features

- **Modern Java 21** support with advanced features
- **Paper API** integration for enhanced performance
- **ACF (Annotation Command Framework)** for easy command handling
- **Staff Chat System** with toggle functionality
- **Admin Chat System** with separate permissions
- **Configuration Management** with YAML files
- **Message System** with customizable prefixes
- **Event Listeners** for chat and join events
- **Maven** build system with proper shading
- **Lombok** for cleaner code

## 📋 Prerequisites

Before using this template, ensure you have:

- **Java 21** or higher installed
- **Maven** for building the plugin
- **Git** (optional, for version control)
- A **Minecraft Server** running Paper/Spigot/Bukkit 1.21+

## 🛠️ Quick Setup

### Option 1: Automated Setup (Recommended)

1. **Download or clone this template**

   ```bash
   git clone <repository-url>
   cd PluginTemplate
   ```

2. **Run the setup script**

   ```powershell
   .\setup-plugin.ps1
   ```

3. **Follow the prompts** to enter your plugin details:
   - Plugin name (e.g., "MyAwesome Plugin")
   - Author name
   - Base package (e.g., "com.yourname")
   - Initial version (default: 1.0.0)

4. **Build your plugin**

   ```bash
   mvn clean package
   ```

### Option 2: Manual Setup

If you prefer to set up manually or the script doesn't work:

1. **Replace all placeholders** in the following files:
   - All `.java` files in `src/main/java/`
   - `pom.xml`
   - `src/main/resources/plugin.yml`

   **Placeholders to replace:**
   - `{{PLUGIN_NAME}}` - Your plugin's display name
   - `{{PACKAGE_NAME}}` - Your package name (e.g., com.yourname.pluginname)
   - `{{MAIN_CLASS}}` - Your main class name
   - `{{COMMAND_ALIAS}}` - Your main command alias
   - `{{PERMISSION_PREFIX}}` - Your permission prefix
   - `{{MAVEN_GROUP_ID}}` - Maven group ID
   - `{{MAVEN_ARTIFACT_ID}}` - Maven artifact ID
   - `{{VERSION}}` - Plugin version
   - `{{AUTHOR_NAME}}` - Your name

2. **Move Java files** to match your package structure

3. **Rename the main class file** to match your plugin name

## 📁 Project Structure

```
PluginTemplate/
├── src/main/java/com/nullbyte/overseer/
│   ├── Overseer.java                    # Main plugin class
│   ├── commands/
│   │   ├── Commands.java                # Command manager
│   │   ├── MainCommand.java             # Main plugin command
│   │   └── StaffChatCommands.java       # Staff/Admin chat commands
│   ├── listeners/
│   │   ├── Listeners.java               # Event listener manager
│   │   ├── ChatEvent.java               # Chat event handler
│   │   └── JoinListener.java            # Player join handler
│   └── util/
│       ├── LegacyConverter.java         # Legacy color code support
│       ├── MessageUtil.java             # Message formatting utilities
│       ├── Util.java                    # General utilities
│       └── config/
│           ├── Config.java              # Main configuration
│           ├── ConfigUtils.java         # Config helper methods
│           ├── DataConfig.java          # Player data storage
│           └── MessagesConfig.java      # Message configuration
├── src/main/resources/
│   ├── plugin.yml                       # Plugin descriptor
│   ├── config.yml                       # Main configuration file
│   ├── messages.yml                     # Customizable messages
│   └── data.yml                         # Runtime data storage
├── pom.xml                              # Maven build configuration
├── setup-plugin.ps1                    # Automated setup script
├── README.md                            # This file
└── LICENSE                              # MIT License
```

## ⚙️ Configuration

### config.yml

Main plugin configuration with settings for:

- Staff chat system (prefix, handle, sounds)
- Admin chat system (prefix, handle, sounds)
- Feature toggles
- Sound settings

### messages.yml

Customizable messages for:

- Chat system notifications
- Command responses
- Error messages
- Status messages

### data.yml

Runtime data storage for:

- Player chat mode states
- Mute preferences
- Persistent settings

## 🎯 Commands & Permissions

### Commands

| Command | Aliases | Description | Permission |
|---------|---------|-------------|------------|
| `/pluginname` | `/alias` | Main plugin command | `pluginname.use` |
| `/pluginname reload` | `/aliasreload` | Reload configuration | `pluginname.reload` |
| `/staffchat [message]` | `/sc` | Toggle or send staff chat | `pluginname.staff` |
| `/adminchat [message]` | `/ac` | Toggle or send admin chat | `pluginname.admin` |
| `/mutestaffchat` | `/mutesc` | Mute staff chat | `pluginname.staff` |
| `/muteadminchat` | `/muteac` | Mute admin chat | `pluginname.admin` |

### Permissions

- `pluginname.use` - Basic plugin usage
- `pluginname.reload` - Reload plugin configuration
- `pluginname.staff` - Access to staff chat features
- `pluginname.admin` - Access to admin chat features

## 🔧 Development

### Building the Plugin

```bash
mvn clean package
```

The compiled plugin will be in the `target/` directory.

### IDE Setup

1. Import as a Maven project
2. Ensure Java 21 is configured
3. Maven will automatically download dependencies

### Dependencies

- **Paper API** - Server API
- **ACF (Aikar's Command Framework)** - Command handling
- **Lombok** - Code generation (development only)

## 🎨 Customization

### Adding New Commands

1. Create a new class extending `BaseCommand`
2. Add command annotations (`@CommandAlias`, `@Subcommand`, etc.)
3. Register in `Commands.java`

### Adding New Listeners

1. Create a class implementing `Listener`
2. Add `@EventHandler` methods
3. Register in `Listeners.java`

### Adding New Configuration Options

1. Add to appropriate config class
2. Update default YAML files
3. Use in your code via config getters

## 📦 Features Included

### Staff Chat System

- Toggle on/off per player
- Handle-based activation (e.g., "#message")
- Sound notifications
- Mute functionality
- Custom formatting

### Admin Chat System

- Separate from staff chat
- Higher permission level
- Independent toggle and mute
- Custom formatting

### Configuration Management

- Hot-reload support
- YAML-based configuration
- Message customization
- Data persistence

### Modern Java Features

- Records and sealed classes ready
- Pattern matching support
- Text blocks for SQL/JSON
- Modern collection methods

## 🛡️ Best Practices

This template follows modern Java and Minecraft plugin development best practices:

- **Dependency Injection** ready structure
- **Event-driven** architecture
- **Configuration-first** approach
- **Permission-based** security
- **Null-safe** code patterns
- **Resource cleanup** on disable
- **Async-safe** event handling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter issues:

1. Check the [Issues](../../issues) page
2. Verify your Java and Maven versions
3. Ensure you're using Paper/Spigot 1.21+
4. Check server logs for error messages

## 🙏 Acknowledgments

- **PaperMC** for the excellent server software
- **Aikar** for the ACF command framework
- **Lombok** team for code generation tools
- The **Minecraft** plugin development community

---

**Happy plugin development!** 🚀

For more advanced features and examples, check out the included source code and comments.
