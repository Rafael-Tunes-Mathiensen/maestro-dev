[CmdletBinding()]
param([switch]$Verificar, [string]$DiretorioCodex)

$ErrorActionPreference = 'Stop'
$packageRoot = [System.IO.Path]::GetFullPath($PSScriptRoot)
$codexTarget = if ($DiretorioCodex) { [System.IO.Path]::GetFullPath($DiretorioCodex) } elseif ($env:CODEX_HOME) { [System.IO.Path]::GetFullPath($env:CODEX_HOME) } else { Join-Path $env:USERPROFILE '.codex' }
$skillTarget = Join-Path $codexTarget 'skills\fluxo-desenvolvimento'
$agentsTarget = Join-Path $codexTarget 'agents'
$sourceSkill = Join-Path $packageRoot 'skill'
$utf8 = [System.Text.UTF8Encoding]::new($false)
$entries = [System.Collections.Generic.List[object]]::new()

# O marcador fica dentro de uma string básica TOML. Escape inclusive aspas e
# caracteres de controle; espaços e apóstrofos são preservados normalmente.
$tomlSkillRoot = $skillTarget.Replace('\', '/').Replace('"', '\"')
foreach ($character in @([char[]](0..31)) + [char]127) {
    $tomlSkillRoot = $tomlSkillRoot.Replace([string]$character, ('\u{0:X4}' -f [int]$character))
}

if (-not (Test-Path -LiteralPath $sourceSkill -PathType Container)) {
    throw "Diretório da skill ausente no pacote: $sourceSkill"
}

# Constrói e confere todos os destinos antes de escrever. Não modifica config.toml.
foreach ($source in Get-ChildItem -LiteralPath $sourceSkill -File -Recurse) {
    $relative = $source.FullName.Substring($sourceSkill.Length).TrimStart('\', '/')
    $entries.Add(@{ Source = $source.FullName; Target = Join-Path $skillTarget $relative; Content = $null })
}
foreach ($role in @('designer', 'programador', 'revisor', 'qa')) {
    $source = Join-Path $packageRoot "agentes\fluxo-$role.toml"
    $content = [System.IO.File]::ReadAllText($source, $utf8)
    if (-not $content.Contains('__SKILL_ROOT__')) {
        throw "Perfil sem marcador de instalação: $source"
    }
    $content = $content.Replace('__SKILL_ROOT__', $tomlSkillRoot)
    $entries.Add(@{ Source = $source; Target = Join-Path $agentsTarget "fluxo-$role.toml"; Content = $content })
}

foreach ($entry in $entries) {
    $destination = [System.IO.Path]::GetFullPath($entry.Target)
    if (-not $destination.StartsWith($codexTarget.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Destino fora do diretório Codex: $destination"
    }
    # Não seguir redirecionamentos de diretórios durante uma instalação pessoal.
    $ancestor = Split-Path -Parent $destination
    while ($ancestor) {
        if (Test-Path -LiteralPath $ancestor) {
            $ancestorItem = Get-Item -LiteralPath $ancestor -Force
            if (-not $ancestorItem.PSIsContainer) {
                throw "Ancestral do destino não é um diretório: $ancestor"
            }
            if ($ancestorItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
                throw "Diretório redirecionado requer inspeção manual: $ancestor"
            }
        }
        $ancestor = Split-Path -Parent $ancestor
    }
    $expected = if ($null -ne $entry.Content) { $utf8.GetBytes($entry.Content) } else { [System.IO.File]::ReadAllBytes($entry.Source) }
    $entry.Bytes = $expected
    if (Test-Path -LiteralPath $destination) {
        $existing = Get-Item -LiteralPath $destination -Force
        if ($existing.PSIsContainer -or ($existing.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) { throw "Destino não é um arquivo regular: $destination" }
        if ([Convert]::ToBase64String([System.IO.File]::ReadAllBytes($destination)) -cne [Convert]::ToBase64String($expected)) {
            throw "Arquivo diferente já existe; nada foi sobrescrito: $destination"
        }
    } elseif ($Verificar) {
        throw "Arquivo ainda não instalado: $destination"
    }
}

if (-not $Verificar) {
    foreach ($entry in $entries) {
        if (-not (Test-Path -LiteralPath $entry.Target)) {
            [System.IO.Directory]::CreateDirectory((Split-Path -Parent $entry.Target)) | Out-Null
            # CreateNew impede sobrescrever arquivo criado entre a conferência e a escrita.
            $stream = [System.IO.File]::Open($entry.Target, [System.IO.FileMode]::CreateNew, [System.IO.FileAccess]::Write)
            try { $stream.Write($entry.Bytes, 0, $entry.Bytes.Length) } finally { $stream.Dispose() }
        }
    }
}
Write-Output "Arquivos conferidos: $($entries.Count)"
Write-Output "Skill: $skillTarget"
Write-Output "Perfis: $agentsTarget (fluxo-designer, fluxo-programador, fluxo-revisor, fluxo-qa)"
Write-Output 'Configuração global, modelos, permissões e automações não foram alterados.'
