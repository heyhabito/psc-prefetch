# Psc-prefetch

Psc-prefetch is a command-line tool used to add `sha256` hashes to a [Psc-package-set](https://github.com/purescript/package-sets).

## Usage
The cabal project contains the executale `psc-prefetch-app` which can be launched using `cabal new-run psc-prefetch-app` or directly as `psc-prefetch-app` after `cabal new-install`.
The executable takes 2 arguments, the file to parse and the output path.

With the following `packages.json`, `psc-prefetch-app packages.json packages-with-sha256.json` produces the shown output.

Input:
```
# packages.json

{
  "aff": {
    "dependencies": [
      "datetime",
      "effect",
      "exceptions",
      "functions",
      "parallel",
      "transformers",
      "unsafe-coerce"
    ],
    "repo": "https://github.com/slamdata/purescript-aff.git",
    "version": "v5.1.1"
  },
  ...
}
```

Output:
```
# packages-with-sha256.json

{
  "aff": {
    "dependencies": [
      "datetime",
      "effect",
      "exceptions",
      "functions",
      "parallel",
      "transformers",
      "unsafe-coerce"
    ],
    "version": "v5.1.0",
    "repo": "https://github.com/slamdata/purescript-aff.git",
    "sha256": "00s97s7awa8n7h2p6hkc8kpmlwfvigbbj1phvwx3a90whczfi99d"
  },
  ...
}

```

## Test
The project currently contains tests for the json codecs which can be run with `cabal new-test`
