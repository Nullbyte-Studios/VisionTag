package {{PACKAGE_NAME}}.listeners;

import {{PACKAGE_NAME}}.{{MAIN_CLASS}};
import org.bukkit.Bukkit;

import java.util.List;

public class Listeners {
    public static void register() {
        List.of(
                new ChatEvent(),
                new JoinListener()
        ).forEach(e -> Bukkit.getServer().getPluginManager().registerEvents(e, {{MAIN_CLASS}}.get()));
    }
}
