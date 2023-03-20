<?php

function changeErrorVariable(string $initialDir): void
{
    $directories = scandir($initialDir);
    unset($directories[0]);
    unset($directories[1]);
    foreach ($directories as $dir) {
        if (is_dir(getFullDir(initialDir: $initialDir, currentDir: $dir))) {
            changeErrorVariable(getFullDir(initialDir: $initialDir, currentDir: $dir));
        }
        if ($dir == "php.ini") {
            $fullPath = getFullDir(
                initialDir: $initialDir,
                currentDir: $dir
            );
            copy($fullPath, "$fullPath.".time().".original.backup");
            copy($fullPath, "$fullPath.bac");
            $fileReadHandle = fopen($fullPath, "r");
            $fileWriteHandle = fopen($fullPath . ".bac", "w");
            $fileSize = filesize($fullPath);
            if ($fileSize > 0) {
                while (!feof($fileReadHandle)) {
                    $line = fgets($fileReadHandle);
                    if (str_contains($line, "display_errors = Off")) {
                        $line = str_replace(
                            "display_errors = Off",
                            "display_errors = On",
                            $line
                        );
                    }
                    if (str_contains($line, "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT")) {
                        $line = str_replace(
                            "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT",
                            "error_reporting = E_ALL",
                            $line
                        );
                    }
                    fwrite($fileWriteHandle, $line);
                }
            }
            fclose($fileWriteHandle);
            fclose($fileReadHandle);
            rename("$fullPath.bac", $fullPath);
        }
    }
}

function getFullDir(string $initialDir, string $currentDir): string
{
    return $initialDir . DIRECTORY_SEPARATOR . $currentDir;
}

$dir = $_SERVER["argv"][1] ?? "/etc/php";

changeErrorVariable(initialDir: $dir);
echo "Successfully changed values to display_errors = On and error_reporting = E_ALL \n";
