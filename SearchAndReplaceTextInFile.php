<?php

function SearchAndReplace(
    string $directoryPath,
    string $fileName,
    string $searchText,
    string $replaceText
): void {
    $directories = scandir($directoryPath);
    unset($directories[0]);
    unset($directories[1]);
    foreach ($directories as $dir) {
        if (is_dir(getFullDir(directoryPath: $directoryPath, currentDir: $dir))) {
            SearchAndReplace(
                getFullDir(directoryPath: $directoryPath, currentDir: $dir),
                $fileName,
                $searchText,
                $replaceText
            );
        }
        if ($dir == $fileName) {
            $fullPath = getFullDir(
                directoryPath: $directoryPath,
                currentDir: $dir
            );
            echo "Processing on file $fullPath". PHP_EOL;
            echo "\n";
            copy($fullPath, "$fullPath." . time() . ".original.backup");
            copy($fullPath, "$fullPath.bac");
            $fileReadHandle = fopen($fullPath, "r");
            $fileWriteHandle = fopen($fullPath . ".bac", "w");
            $fileSize = filesize($fullPath);
            if ($fileSize > 0) {
                while (!feof($fileReadHandle)) {
                    $line = fgets($fileReadHandle);
                    if (str_contains($line, $searchText)) {
                        $line = str_replace(
                            $searchText,
                            $replaceText,
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

function getFullDir(string $directoryPath, string $currentDir): string
{
    return $directoryPath . DIRECTORY_SEPARATOR . $currentDir;
}

$inputStream = fopen("php://stdin", "r");

function getFromInputStream($inputStream): string
{
    return trim(fgets($inputStream));
}

echo <<<"PRINT"
Please enter only directory path for file which you want to edit (case sensitive) :-

PRINT;

$directoryPath = getFromInputStream($inputStream);

echo <<<"PRINT"
Please enter file name that you want to edit (case sensitive) :-

PRINT;

$fileName = getFromInputStream($inputStream);

echo <<<"PRINT"
Please enter text that you want to search (case sensitive) :-

PRINT;

$searchText = getFromInputStream($inputStream);

echo <<<"PRINT"
Please enter text that you want to replace (case sensitive) :-

PRINT;

$replaceText = getFromInputStream($inputStream);

SearchAndReplace(
    directoryPath: $directoryPath,
    fileName: $fileName,
    searchText: $searchText,
    replaceText: $replaceText
);
fclose($inputStream);
echo "Successfully changed values from $searchText to value $replaceText \n";
exit(0);
