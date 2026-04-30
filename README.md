<div align="center">
  <img src="https://raw.githubusercontent.com/VrtxOmega/veritas-deep-space/main/icon.ico" width="100" alt="VERITAS DEEP SPACE" />
  <h1>VERITAS DEEP SPACE</h1>
  <p><strong>Autonomous Transit Photometry Discovery Engine — VERITAS-Validated Exoplanet Candidate Pipeline</strong></p>
</div>

<div align="center">

![Status](https://img.shields.io/badge/Status-ACTIVE-success?style=for-the-badge&labelColor=000000&color=d4af37)
![Version](https://img.shields.io/badge/Version-v3.0.0-informational?style=for-the-badge&labelColor=000000&color=d4af37)
![Stack](https://img.shields.io/badge/Stack-Python%20%2B%20React%20%2B%20Three.js-informational?style=for-the-badge&labelColor=000000)
![Oracle](https://img.shields.io/badge/Oracle-Ollama%20Cloud%20%7C%20DeepSeek--V4-informational?style=for-the-badge&labelColor=000000)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge&labelColor=000000)

<br/>
<br/>

<img src="assets/exoplanet_miner_dashboard.png" alt="VERITAS Deep Space Dashboard" width="800" />
<br/>
<sup><em>VERITAS Telemetry Dashboard — Real-time transit photometry monitoring with SIMBAD stellar classification, VERITAS Ω-3.0.0 claim sealing, and WebGL 3D orbital projection</em></sup>
<br/><br/>
<img src="assets/exoplanet_scan_results.png" alt="Bulk Scan Results" width="800" />
<br/>
<sup><em>Bulk Kepler Q1–Q17 lightcurve scan — 66 targets analysed, transit anomalies extracted, VERITAS claims sealed per candidate</em></sup>

</div>

---

VERITAS Deep Space is a sovereign autonomous transit photometry pipeline that downloads Kepler and TESS lightcurves from NASA MAST, detects periodic flux dips using Box Least Squares (BLS) periodogram analysis, evaluates each candidate through the VERITAS Ω-3.0.0 10-gate deterministic build pipeline with an Ollama Cloud-powered astrophysical reasoning Oracle, and cross-references discoveries against the SIMBAD astronomical database. Every candidate that survives the pipeline receives a cryptographically sealed VERITAS BuildClaim: PASS, MODEL_BOUND, or INCONCLUSIVE — with full provenance chains anchored to the Omega audit ledger.

---

## Ecosystem Context

VERITAS Deep Space is the scientific discovery node of the VERITAS Omega Universe. It applies the same deterministic falsification methodology that governs the ecosystem's software build pipeline to a domain where methodological rigour is non-negotiable: exoplanet transit detection.

The pipeline does not determine what is true. It determines what survives disciplined attempts to falsify it. Known eclipsing binaries, rotating variables, and subgiants are flagged via SIMBAD and reclassified as MODEL_BOUND. No narrative rescue. No deferred closure. No authority override.

Related nodes: [omega-brain-mcp](https://github.com/VrtxOmega/omega-brain-mcp) (governance substrate) · [veritas-vault](https://github.com/VrtxOmega/veritas-vault) (knowledge retention) · [Ollama-Omega](https://github.com/VrtxOmega/Ollama-Omega) (inference transport) · [Gravity-Omega](https://github.com/VrtxOmega/Gravity-Omega) (operator platform)

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                      INGESTION LAYER                                 │
│  Lightkurve API (NASA MAST) ──→ Bulk Survey Orchestrator            │
│  SIMBAD TAP Service ──────────→ Stellar Classification Enrichment    │
│  NASA Exoplanet Archive ──────→ Known Host Exclusion Filter          │
└──────────────────────────────┬──────────────────────────────────────┘
                               │ detrend → BLS → fit → evaluate
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                     EVALUATION LAYER                                 │
│  Transit Evaluator ──→ 4 Deterministic Hard Gates (pre-Oracle)      │
│  VERITAS Build ──────→ INTAKE → TYPE → EVIDENCE → MATH → SEAL       │
│  Ollama Cloud Oracle ─→ DeepSeek-V4 astrophysical reasoning          │
│  SIMBAD Enrichment ───→ Spectral type, variability flags, distance   │
└──────────────┬──────────────────────────┬───────────────────────────┘
               │                          │
               ▼                          ▼
┌──────────────────────────┐  ┌───────────────────────────────────┐
│     PERSISTENCE           │  │     OPERATOR INTERFACE             │
│  SQLite (candidates.db)   │  │  React + Vite Dashboard            │
│  SHA-256 payload hashes   │  │  VERITAS Gold-and-Obsidian Theme   │
│  Sealed VERITAS claims    │  │  Animated Transit Waveforms        │
│  Matplotlib transit plots │  │  WebGL 3D Orbital Projection       │
│                           │  │  SSE Live Streaming                │
│                           │  │  Search + Verdict Filtering         │
└──────────────────────────┘  └───────────────────────────────────┘
```

### Core Modules

| Module | File | Purpose |
|---|---|---|
| Flask Server | `server.py` | REST API + SSE streaming on port 5050; SQLite persistence with auto-migration |
| Bulk Surveyor | `bulk_orchestrator.py` | Multi-sector sky survey; target pool construction; scan orchestration |
| Transit Evaluator | `transit_evaluator.py` | 4 deterministic hard gates + Ollama Cloud Oracle (DeepSeek-V4) |
| VERITAS Builder | `veritas_build.py` | Constructs VERITAS Ω-3.0.0 BuildClaims from transit parameters |
| SIMBAD Lookup | `simbad_lookup.py` | ADQL TAP queries for stellar classification, parallax, and variability flags |
| Known Planets | `known_planets.py` | NASA Exoplanet Archive cross-reference with 24-hour cached exclusion list |
| Lightcurve Miner | `miner.py` | Lightkurve download, detrending, BLS + Lomb-Scargle periodogram analysis |
| Dashboard | `dashboard/` | Vite + React + Three.js frontend with WebGL 3D orbital visualization |

---

## First Light — KIC 9141881

On its initial bulk survey of 66 Kepler targets, VERITAS Deep Space identified **KIC 9141881** as a VERITAS **PASS** candidate. The BLS algorithm detected a periodic flux dip with an SNR of **1,876** at a period of **4.058 days** and a fractional depth of **0.53%**, consistent with a hot Jupiter transiting a G1.5IV-V subgiant at **1,293 parsecs**. SIMBAD returned 9 literature references, confirmed the host as a rotating variable (`Ro*`), and flagged known planets in the field.

The open question is whether the 4.06-day periodicity originates from a planetary transit or starspot modulation from the host's rotational variability. A secondary eclipse search at phase 0.5 would resolve this ambiguity. This candidate has not been submitted to any exoplanet catalog.

<div align="center">
  <img src="assets/KIC_9141881_phase.png" alt="KIC 9141881 Phase-Folded Lightcurve" width="700" />
  <br/>
  <sup><em>Phase-folded Kepler lightcurve — BLS-detected transit at P = 4.058 d, depth = 0.53%, SNR = 1,876</em></sup>
</div>

<br/>

| Parameter | Value | Source |
|---|---|---|
| **KIC ID** | 9141881 | Kepler Input Catalog |
| **SIMBAD ID** | 2MASS J19022863+4****75 | CDS SIMBAD |
| **Spectral Type** | G1.5IV-V (subgiant) | SIMBAD |
| **Object Type** | Rotating Variable (`Ro*`) | SIMBAD |
| **Distance** | 1,293 pc | Gaia DR3 |
| **Period** | 4.058 days | BLS detection |
| **Depth** | 0.53% (5,280 ppm) | BLS detection |
| **SNR** | 1,876 | BLS detection |
| **Duration** | 0.33 days (7.9 hr) | BLS detection |
| **Rp/Rs** | 0.073 | Transit model fit |
| **Literature Refs** | 9 | SIMBAD |
| **Flags** | `ROTATING_VARIABLE`, `SUBGIANT`, `KNOWN_PLANETS_IN_FIELD` | SIMBAD |
| **VERITAS Verdict** | **PASS** | Ω-3.0.0 sealed claim |
| **Novel** | Yes — not in confirmed exoplanet catalog | NASA Exoplanet Archive |

> **Status**: Secondary eclipse check pending. TESS Sector 14/40/41 data covering this field would resolve the transit vs. starspot ambiguity. Open an issue or PR if you run the test.

---

## Inference Architecture

VERITAS Deep Space v3.0.0 uses **Ollama Cloud** for Oracle inference — no local GPU required. The pipeline sends transit parameters to `deepseek-v4-flash` via the OpenAI-compatible API at `ollama.com/v1`.

### Deterministic Gate Sequence

Four hard gates execute **before** the LLM sees any data. These are mathematical, not probabilistic:

| Gate | Condition | Verdict |
|------|-----------|---------|
| Morphology | `flux_std / depth > 0.5` | MODEL_BOUND |
| Eclipsing Binary | `depth >= 0.05` | MODEL_BOUND |
| SNR Floor | `snr <= 5.0` | INCONCLUSIVE |
| Harmonic Contamination | BLS period within ±5% of stellar rotation harmonics | MODEL_BOUND |

Only candidates that survive all four gates are presented to the Oracle for astrophysical reasoning.

### Oracle Configuration

```
Environment variables:
  OLLAMA_API_KEY          — Ollama Cloud API key (required)
  VERITAS_ORACLE_MODEL    — Oracle model (default: deepseek-v4-flash)
```

---

## Quickstart

### Prerequisites

- **Python** 3.10+
- **Node.js** 20+
- **Ollama Cloud API key** (set as `OLLAMA_API_KEY` environment variable)

### Install and Run

```bash
# 1. Clone the repository
git clone https://github.com/VrtxOmega/veritas-deep-space.git
cd veritas-deep-space

# 2. Install Python dependencies
pip install flask flask-cors lightkurve astroquery matplotlib requests

# 3. Install frontend dependencies
cd dashboard
npm install
cd ..

# 4. Set your Ollama Cloud API key
export OLLAMA_API_KEY=sk_or-...
export VERITAS_ORACLE_MODEL=deepseek-v4-flash  # optional, this is the default

# 5. Launch backend (port 5050)
python server.py

# 6. Launch dashboard (port 5173) — separate terminal
cd dashboard
npm run dev
```

Or use the launcher script (Windows):

```bash
launch_miner.bat
```

---

## Data Model

VERITAS Deep Space uses **SQLite** as its exclusive persistence layer. Each candidate record contains:

| Field | Description |
|---|---|
| `target` | KIC designation (e.g., KIC 9141881) |
| `target_id` | Numeric KIC identifier |
| `verdict` | VERITAS terminal verdict: PASS, MODEL_BOUND, INCONCLUSIVE |
| `period_days` | Detected orbital period (days) |
| `depth` | Transit flux depth (fractional) |
| `snr` | Signal-to-noise ratio |
| `duration_days` | Transit event duration (days) |
| `rp_rs_ratio` | Planet-to-star radius ratio |
| `stellar_rotation_period_days` | Lomb-Scargle rotation period |
| `claim_id` | SHA-256 VERITAS claim identifier |
| `payload_hash` | SHA-256 payload integrity hash |
| `simbad_id` | SIMBAD primary identifier |
| `spectral_type` | Stellar spectral classification |
| `object_type` | SIMBAD object classification |
| `distance_pc` | Gaia distance in parsecs |
| `simbad_flags` | Enrichment flags (JSON array) |
| `ai_reasoning` | Oracle reasoning text |

---

## Security & Sovereignty

- **Local-first architecture**: All analysis runs on the operator's machine.
- **Ollama Cloud Oracle**: Inference delegated to Ollama Cloud; no candidate data stored remotely.
- **SIMBAD queries**: Read-only TAP queries to CDS Strasbourg for stellar classification only.
- **NASA MAST**: Read-only Lightkurve downloads of public Kepler and TESS photometry.
- **No cloud telemetry**: No analytics, crash reporting, or update checks.

---

## Roadmap

| Milestone | Status |
|---|---|
| Kepler Q1–Q17 bulk lightcurve survey | Complete |
| VERITAS Ω-3.0.0 claim construction per candidate | Complete |
| SIMBAD stellar classification enrichment | Complete |
| Ollama Cloud Oracle (DeepSeek-V4) | Complete |
| React dashboard with WebGL 3D orbital projection | Complete |
| SSE live streaming + paginated results | Complete |
| TESS sector scanning | Planned |
| Multi-planet system detection (residual BLS) | Planned |
| Radial velocity cross-validation | Planned |
| Automated discovery paper generation | Planned |

---

## License

Released under the [MIT License](LICENSE).

---

<div align="center">
  <sub>Built by <a href="https://github.com/VrtxOmega">RJ Lopez</a> &nbsp;|&nbsp; VERITAS Omega Universe</sub>
</div>
