package {{PACKAGE_NAME}}.commands;

import co.aikar.commands.BaseCommand;
import co.aikar.commands.annotation.*;
import {{PACKAGE_NAME}}.{{MAIN_CLASS}};
import {{PACKAGE_NAME}}.util.config.Config;
import {{PACKAGE_NAME}}.util.MessageUtil;
import {{PACKAGE_NAME}}.util.config.MessagesConfig;
import io.papermc.paper.plugin.configuration.PluginMeta;
import org.bukkit.command.CommandSender;
import org.bukkit.configuration.InvalidConfigurationException;

import java.io.IOException;

@CommandAlias("{{COMMAND_ALIAS}}")
@Description("The main command of {{PLUGIN_NAME}}")
public class MainCommand extends BaseCommand {
    @Default
    public void onDefault(CommandSender sender) {
        PluginMeta meta = {{MAIN_CLASS}}.get().getPluginMeta();
        sender.sendMessage(MessageUtil.transformPrefix("&2This server is using " + meta.getDisplayName()));
    }
    @Subcommand("reload|rl")
    @CommandAlias("{{COMMAND_ALIAS}}reload")
    @Description("Reload the plugin.")
    @CommandPermission("{{PERMISSION_PREFIX}}.reload")
    public void onReload(CommandSender sender) {
        Config.load();
        MessagesConfig.load();
        sender.sendMessage(MessageUtil.transformPrefix("&aReloaded configuration."));
    }
}
