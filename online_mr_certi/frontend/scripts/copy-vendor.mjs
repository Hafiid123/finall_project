import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, "..");
const wwwroot = path.resolve(root, "..", "wwwroot");
const nm = path.resolve(root, "node_modules");

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function copyFile(src, dest) {
  ensureDir(path.dirname(dest));
  fs.copyFileSync(src, dest);
}

function copyDir(srcDir, destDir) {
  if (!fs.existsSync(srcDir)) {
    throw new Error(`Missing source directory: ${srcDir}`);
  }
  ensureDir(destDir);
  for (const entry of fs.readdirSync(srcDir, { withFileTypes: true })) {
    const src = path.join(srcDir, entry.name);
    const dest = path.join(destDir, entry.name);
    if (entry.isDirectory()) {
      copyDir(src, dest);
    } else {
      copyFile(src, dest);
    }
  }
}

function copyFontPackage(pkgName, weights, destFolder) {
  const pkgDir = path.join(nm, "@fontsource", pkgName);
  const filesDir = path.join(pkgDir, "files");
  const outDir = path.join(wwwroot, "fonts", destFolder);
  ensureDir(outDir);

  for (const weight of weights) {
    const cssPath = path.join(pkgDir, `${weight}.css`);
    if (!fs.existsSync(cssPath)) {
      throw new Error(`Font CSS not found: ${cssPath}`);
    }
    const css = fs.readFileSync(cssPath, "utf8");
    const rewritten = css.replace(/url\(\.\/files\//g, "url(");
    fs.writeFileSync(path.join(outDir, `${weight}.css`), rewritten);
    for (const line of css.matchAll(/url\(\.\/files\/([^)]+)\)/g)) {
      copyFile(path.join(filesDir, line[1]), path.join(outDir, line[1]));
    }
  }
}

// Font Awesome 6.4.2
copyDir(
  path.join(nm, "@fortawesome", "fontawesome-free", "css"),
  path.join(wwwroot, "lib", "font-awesome", "css")
);
copyDir(
  path.join(nm, "@fortawesome", "fontawesome-free", "webfonts"),
  path.join(wwwroot, "lib", "font-awesome", "webfonts")
);

// Chart.js 4.x (UMD build for script tag)
copyFile(
  path.join(nm, "chart.js", "dist", "chart.umd.min.js"),
  path.join(wwwroot, "lib", "chart.js", "chart.umd.min.js")
);

// Select2
copyFile(
  path.join(nm, "select2", "dist", "css", "select2.min.css"),
  path.join(wwwroot, "lib", "select2", "css", "select2.min.css")
);
copyFile(
  path.join(nm, "select2", "dist", "js", "select2.full.min.js"),
  path.join(wwwroot, "lib", "select2", "js", "select2.full.min.js")
);

// Select2 Bootstrap 4 theme (from AdminLTE vendor copy — stable local file)
copyFile(
  path.resolve(wwwroot, "AdminLTE", "plugins", "select2-bootstrap4-theme", "select2-bootstrap4.min.css"),
  path.join(wwwroot, "lib", "select2", "css", "select2-bootstrap4.min.css")
);

// Web fonts
copyFontPackage("dm-sans", ["300", "400", "500", "600"], "dm-sans");
copyFontPackage("playfair-display", ["400", "700"], "playfair-display");
copyFontPackage("source-sans-pro", ["300", "400", "400-italic", "700"], "source-sans-pro");

const fontsCss = `@import url("../fonts/dm-sans/300.css");
@import url("../fonts/dm-sans/400.css");
@import url("../fonts/dm-sans/500.css");
@import url("../fonts/dm-sans/600.css");
@import url("../fonts/playfair-display/400.css");
@import url("../fonts/playfair-display/700.css");
@import url("../fonts/source-sans-pro/300.css");
@import url("../fonts/source-sans-pro/400.css");
@import url("../fonts/source-sans-pro/400-italic.css");
@import url("../fonts/source-sans-pro/700.css");
`;

fs.writeFileSync(path.join(wwwroot, "css", "fonts.css"), fontsCss);

console.log("Vendor assets copied to wwwroot.");
