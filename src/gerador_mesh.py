"""Exporta presets visuais do modelo SCAD usando o executavel OpenSCAD."""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
SCAD_FILE = PROJECT_ROOT / "src" / "pelve_parametrica.scad"
OUTPUT_DIR = PROJECT_ROOT / "models" / "stl"
PRESETS = {
    "pequeno": {"pelvic_width": 150, "pelvic_depth": 110, "pelvic_height": 95},
    "medio": {"pelvic_width": 170, "pelvic_depth": 125, "pelvic_height": 105},
    "grande": {"pelvic_width": 190, "pelvic_depth": 140, "pelvic_height": 115},
}


def resolve_openscad(executable: str) -> str | None:
    candidate = Path(executable)
    if candidate.is_file():
        return str(candidate)
    return shutil.which(executable)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Exporta presets demonstrativos em STL."
    )
    parser.add_argument(
        "--openscad", default="openscad", help="Comando ou caminho do OpenSCAD"
    )
    parser.add_argument("--preset", choices=["todos", *PRESETS], default="todos")
    parser.add_argument("--output-dir", type=Path, default=OUTPUT_DIR)
    args = parser.parse_args()

    executable = resolve_openscad(args.openscad)
    if executable is None:
        print(
            "OpenSCAD nao encontrado. Instale-o ou passe --openscad com o caminho do executavel.",
            file=sys.stderr,
        )
        return 2

    selected = (
        PRESETS.items()
        if args.preset == "todos"
        else [(args.preset, PRESETS[args.preset])]
    )
    args.output_dir.mkdir(parents=True, exist_ok=True)

    for name, dimensions in selected:
        output_file = args.output_dir / f"pelve_demo_{name}.stl"
        command = [executable, "-o", str(output_file)]
        command.extend(f"-D{name}={value}" for name, value in dimensions.items())
        command.append(str(SCAD_FILE))
        result = subprocess.run(command, check=False)
        if result.returncode != 0:
            print(f"Falha ao exportar o preset {name}.", file=sys.stderr)
            return result.returncode
        print(f"Exportado: {output_file}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
