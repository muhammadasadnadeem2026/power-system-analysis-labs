# Power System Analysis: Load Flow and Short-Circuit Studies

> MATLAB and Simulink work behind classic power-system studies: building the bus admittance matrix, solving load
> flow, and simulating three-phase faults.

## What is inside

| File | What it does |
|---|---|
| `matlab/y_bus_from_line_data.m` | Builds Y-bus from line data (from bus, to bus, R, X) |
| `matlab/y_bus_interactive.m` | Builds Y-bus from admittances you type in |
| `matlab/gauss_seidel_load_flow.m` | Gauss–Seidel load flow on a 3-bus system |
| `matlab/newton_raphson_load_flow.m` | Newton–Raphson load flow with the Jacobian matrix |
| `simulink/three_phase_short_circuit.slx` | Three-phase short-circuit model |
| `simulink/lab_0*_model.slx` | Lab models |
| `diagrams/*.vsdx` | Circuit and single-line diagrams (Visio) |

## Skills shown

- Per-unit system and network modelling
- Load-flow methods: Gauss–Seidel and Newton–Raphson
- Symmetrical fault analysis and its link to breaker and fuse selection
- Power-factor correction and capacitor sizing (in PowerWorld, alongside these scripts)

## Run

Open a `.m` file in MATLAB and press **Run**. Open `.slx` models in Simulink (Simscape Electrical).

## Licence

Copyright © 2025 Muhammad Asad Nadeem. All rights reserved.
The code is shared for viewing as part of my engineering portfolio. Please contact me before reusing it.
