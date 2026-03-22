#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const prompts = require('prompts');
const { green, cyan, red, bold } = require('kleur');

async function main() {
  console.log(bold(cyan('\n--- LMU Typst Template Installer ---\n')));

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
      name: 'subtitle',
      message: 'Untertitel (optional):',
    },
    {
      type: 'text',
      name: 'faculty',
      message: 'Fakultät:',
      initial: 'Fakultät für Physik'
    },
    {
      type: 'text',
      name: 'institute',
      message: 'Institut/Lehrstuhl:',
      initial: 'Lehrstuhl für Quantenoptik'
    },
    {
      type: 'text',
      name: 'advisor',
      message: 'Betreuer:',
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
  
  if (!fs.existsSync(targetPath)) {
    fs.mkdirSync(targetPath, { recursive: true });
  }

  const templateDir = path.join(__dirname, '..', 'template');
  
  // Create .vscode directory if needed
  const vscodeDir = path.join(targetPath, '.vscode');
  if (!fs.existsSync(vscodeDir)) {
    fs.mkdirSync(vscodeDir, { recursive: true });
  }

  // Files to copy
  const filesToCopy = [
    { src: 'lib.typ', dest: 'lib.typ' },
    { src: '.vscode/extensions.json', dest: '.vscode/extensions.json' },
    { src: '.vscode/settings.json', dest: '.vscode/settings.json' }
  ];

  for (const file of filesToCopy) {
    const srcPath = path.join(templateDir, file.src);
    const destPath = path.join(targetPath, file.dest);
    
    // Create directory for file if it doesn't exist
    const destDir = path.dirname(destPath);
    if (!fs.existsSync(destDir)) {
      fs.mkdirSync(destDir, { recursive: true });
    }

    if (fs.existsSync(srcPath)) {
      fs.copyFileSync(srcPath, destPath);
    } else {
      console.warn(red(`Warning: Could not find ${file.src} in template directory.`));
    }
  }

  // Read and replace main.typ
  let mainContent = fs.readFileSync(path.join(templateDir, 'main.typ'), 'utf8');
  
  mainContent = mainContent
    .replace('{{TITLE}}', response.title)
    .replace('{{SUBTITLE}}', response.subtitle || '')
    .replace('{{AUTHOR}}', response.author)
    .replace('{{FACULTY}}', response.faculty)
    .replace('{{INSTITUTE}}', response.institute)
    .replace('{{ADVISOR}}', response.advisor || '');

  fs.writeFileSync(path.join(targetPath, 'main.typ'), mainContent);

  console.log(green(`\n✔ Template erfolgreich in "${response.outDir}" erstellt!`));
  console.log(`\nNächste Schritte:`);
  console.log(cyan(`  cd ${response.outDir}`));
  console.log(cyan(`  typst watch main.typ\n`));
}

main().catch(err => {
  console.error(red('Fehler: ' + err.message));
});
