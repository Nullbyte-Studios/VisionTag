package {{PACKAGE_NAME}}.commands;

import co.aikar.commands.PaperCommandManager;
import {{PACKAGE_NAME}}.{{MAIN_CLASS}};
import lombok.Getter;

public class Commands {
    @Getter private static PaperCommandManager manager = new PaperCommandManager({{MAIN_CLASS}}.get());
    public static void register() {
        manager.registerCommand(new MainCommand());
        manager.registerCommand(new StaffChatCommands());
    }
}
