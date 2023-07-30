# Backing Up VSCode Extensions

Make sure you have the most current version of Visual Studio Code. If you install via a company portal, you might not have the most current version.

# Prerequisites

The `code` command in your shell of choice.

## Unix

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

## Windows (PowerShell)

```powershell
code --list-extensions | % { "code --install-extension $_" }
```

## Installation Script

Copy and paste the echo output to another machine as a script then run it.

```bash
touch extensions.sh
chmod u+x extensions.sh
nano extensions.sh # copy paste the output from the previous step
./extensions.sh
```

Sample output:

```bash
#!/usr/bin/bash
code --install-extension Angular.ng-template
code --install-extension DSKWRK.vscode-generate-getter-setter
code --install-extension EditorConfig.EditorConfig
code --install-extension HookyQR.beautify
```



# References

- [Stack Overflow: How can you export the Visual Studio Code extension list?](https://stackoverflow.com/questions/35773299/how-can-you-export-the-visual-studio-code-extension-list)
