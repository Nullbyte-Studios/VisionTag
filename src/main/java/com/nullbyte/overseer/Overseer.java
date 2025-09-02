package {{PACKAGE_NAME}};

import {{PACKAGE_NAME}}.commands.Commands;
import {{PACKAGE_NAME}}.listeners.Listeners;
import {{PACKAGE_NAME}}.util.config.Config;
import {{PACKAGE_NAME}}.util.config.DataConfig;
import {{PACKAGE_NAME}}.util.config.MessagesConfig;
import org.bukkit.plugin.java.JavaPlugin;

import java.io.IOException;

public final class {{MAIN_CLASS}} extends JavaPlugin {
    private static {{MAIN_CLASS}} instance;
    public static {{MAIN_CLASS}} get() {
        return instance;
    }
    public static void info(String msg) {
        instance.getLogger().info(msg);
    }

    @Override
    public void onEnable() {
        instance = this;
        loadConfig();
        loadModules();
        info("{{PLUGIN_NAME}} has started successfully.");
    }

    @Override
    public void onDisable() {
        try {
            DataConfig.save();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        info("{{PLUGIN_NAME}} has been disabled.");
    }
    private void loadModules() {
        Commands.register();
        Listeners.register();
    }
    private void loadConfig() {
        DataConfig.load();
        MessagesConfig.load();
        Config.load();
    }
}
