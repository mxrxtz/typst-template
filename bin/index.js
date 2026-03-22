#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const prompts = require('prompts');
const { green, cyan, red, bold, yellow } = require('kleur');

async function main() {
  console.log(bold(cyan('\n--- LMU Typst Template Installer (v1.0.2) ---\n')));

  const response = await prompts([
    {
      type: 'text',
      name: 'author',
      message: 'Dein Name:',
      initial: 'Max Mustermann'
    },
    {
      type: 'text',
      name: 'title',
      message: 'Titel der Arbeit:',
      initial: 'Physikalisches Fortgeschrittenenpraktikum'
    },
    {
      type: 'text',
      name: 'outDir',
      message: 'Zielverzeichnis:',
      initial: 'mein-versuch'
    }
  ]);

  if (!response.outDir) {
    console.log(red('Abgebrochen.'));
    return;
  }

  const targetPath = path.resolve(process.cwd(), response.outDir);
  const templateDir = path.join(__dirname, '..', 'template');
  
  console.log(cyan(`\nErstelle Projekt in: ${targetPath}`));

  // Recursive copy helper
  function copyRecursive(src, dest) {
    const stats = fs.statSync(src);
    const isDirectory = stats.isDirectory();
    
    if (isDirectory) {
      if (!fs.existsSync(dest)) {
        fs.mkdirSync(dest, { recursive: true });
      }
      fs.readdirSync(src).forEach(childItemName => {
        copyRecursive(
          path.join(src, childItemName),
          path.join(dest, childItemName)
        );
      });
    } else {
      fs.copyFileSync(src, dest);
      console.log(`  ${green('✔')} Kopiert: ${path.relative(templateDir, src)}`);
    }
  }

  try {
    // 1. Copy everything from template folder
    copyRecursive(templateDir, targetPath);

    // 2. Process main.typ (replace placeholders)
    const mainPath = path.join(targetPath, 'main.typ');
    let mainContent = fs.readFileSync(mainPath, 'utf8');
    
    mainContent = mainContent
      .replace('{{TITLE}}', response.title || 'Titel')
      .replace('{{AUTHOR}}', response.author || 'Dein Name');

    fs.writeFileSync(mainPath, mainContent);

    console.log(green(`\n🚀 Projekt erfolgreich in "${response.outDir}" erstellt!`));
    console.log(cyan(`\nÖffne den Ordner nun in VS Code:`));
    console.log(bold(`  code ${response.outDir}`));
    console.log(`\nStelle sicher, dass die "Tinymist" Erweiterung installiert ist.\n`);
  } catch (err) {
    console.error(red('Fehler beim Kopieren: ' + err.message));
  }
}

main().catch(err => {
  console.error(red('Fataler Fehler: ' + err.message));
});
