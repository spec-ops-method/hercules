# COBOL Modernization with Hercules & SpecOps

![Hercules](hercules.gif)

## Project Objective

This project uses the **Hercules mainframe emulator** to run and analyze a legacy COBOL application in an authentic IBM mainframe environment. The goal is to deeply understand the application's behavior, business logic, and data processing—then use that knowledge to modernize it to a contemporary software stack.

We will follow the **[SpecOps methodology](https://spec-ops.ai)** for this modernization effort.

---

## Why This Approach?

Traditional modernization attempts to directly transpile legacy code (e.g., COBOL → Java). This often fails because:

- It misses institutional knowledge embedded in the system
- Domain experts can't verify code translations
- Business logic gets lost in translation
- The resulting code inherits legacy patterns without understanding them

**SpecOps takes a different approach**: The specification is more valuable than the code.

---

## The SpecOps Methodology

> *"Because the knowledge is what matters. Everything else is implementation details."*

### Core Principle

Use AI to compile institutional knowledge into comprehensive, human-verified software specifications that become the **authoritative source of truth** for system behavior—before writing any modern code.

### Six Phases

| Phase | Description |
|-------|-------------|
| 1. **Discovery & Assessment** | Understand the legacy COBOL system using Hercules emulation |
| 2. **Specification Generation** | Use AI to create plain-language specifications from the COBOL code |
| 3. **Specification Verification** | Domain experts review and validate the specifications |
| 4. **Modern Implementation** | Generate new code from verified specifications |
| 5. **Testing & Validation** | Verify the modern implementation matches the specification |
| 6. **Deployment & Knowledge Transfer** | Move to production and preserve institutional knowledge |

---

## Project Setup

### Environment

- **Emulator**: Hercules System/370, ESA/390, z/Architecture Emulator
- **Operating System**: MVS 3.8J (public domain)
- **Language**: COBOL (running in authentic mainframe environment)
- **Host Platform**: macOS

### Installation

```bash
# Install Hercules via Homebrew
brew install hercules
```

### Obtaining MVS 3.8J

To run COBOL programs, we need an operating system. **MVS 3.8J** is the public domain IBM mainframe OS commonly used with Hercules.

**Recommended: TK5 Turnkey System**

The easiest option is the **Turnkey 5 (TK5)** distribution maintained by Rob Prins:
- **Download**: https://www.prince-webdesign.nl/tk5
- Pre-configured, ready-to-run MVS 3.8J system
- Includes COBOL compiler, utilities, and sample programs
- Works on Windows, Linux, and macOS
- Optimized for modern Hercules (SDL Hyperion)

**Alternative: Build from scratch**

For deeper learning, you can build MVS from IBM's distribution tapes:
- Jay Moseley's tutorial: https://www.jaymoseley.com/hercules/installMVS/iMVSintroV8.htm
- Takes several hours but provides excellent system internals knowledge

---

## Project Structure

```
hercules/
├── README.md                 # This file
├── conf/                     # Hercules configuration files
│   └── hercules.cnf          # Base configuration template
├── dasd/                     # Virtual disk images (DASD)
├── source/                   # COBOL source code
├── specs/                    # Generated specifications (SpecOps Phase 2-3)
├── modern/                   # Modern implementation (SpecOps Phase 4)
└── docs/                     # Additional documentation
```

---

## Workflow

### Phase 1: Discovery & Assessment (Current Phase)

1. ✅ Set up Hercules emulator
2. ✅ Create basic configuration template
3. ✅ Download and install TK5 turnkey MVS system
4. ✅ Start MVS and connect via 3270 terminal
5. ✅ Login to TSO and navigate ISPF
6. ⬜ Load COBOL demonstration application
7. ⬜ Run and observe application behavior
8. ⬜ Document inputs, outputs, and processing logic

### Quick Start

```bash
# From the hercules project directory:
./start_mvs.sh

# Then connect with a tn3270 client to localhost:3270
# Web console available at http://localhost:8038
```

### TSO Login Credentials

| Userid | Password |
|--------|----------|
| HERC01 | CUL8TR |
| HERC02 | CUL8TR |
| HERC03 | CUL8TR |
| HERC04 | CUL8TR |
| IBMUSER | SYS1 |

> **Note**: Passwords are case-sensitive. Enter in UPPERCASE.

### Connecting via 3270 Terminal

**Option 1: Terminal-based c3270 (Recommended for macOS)**
```bash
# Install x3270 package
brew install x3270

# Connect to MVS
/opt/homebrew/opt/x3270/bin/c3270 localhost:3270
```

**Option 2: Web Console**
- Open http://localhost:8038 in your browser for Hercules operator console

### ISPF Navigation

Once logged into TSO, ISPF starts automatically. Key navigation:

| Option | Description |
|--------|-------------|
| 0 | ISPF Settings |
| 1 | Browse |
| 2 | Edit |
| 3 | Utilities (3.4 = Dataset List) |
| 4 | Foreground |
| 5 | Background Language Processors |
| M | More Options |
| X | Exit ISPF |

**Finding datasets:**
1. From ISPF, enter `3.4`
2. At "Dsname Level", enter `SYS2` to browse system datasets
3. Use `B` to browse or `E` to edit a dataset

### Step-by-Step Login Guide

1. **Start MVS**: Run `./start_mvs.sh` from the project directory
2. **Wait for boot**: Takes ~30 seconds. You'll see console messages scrolling
3. **Connect**: Open a new terminal and run:
   ```bash
   /opt/homebrew/opt/x3270/bin/c3270 localhost:3270
   ```
4. **At the TK5 logo screen**: Press **Enter**
5. **At the TSO logon**: Type `HERC01` and press **Enter**
6. **Password prompt**: Type `CUL8TR` and press **Enter**
7. **Welcome message**: Press **Enter** to continue
8. **ISPF Menu**: You're now in ISPF - use the menu options above

### Shutting Down

To cleanly shut down MVS:
1. Exit ISPF by typing `X` and pressing **Enter**
2. At TSO READY prompt, type `LOGOFF`
3. In the Hercules console (or via web console at http://localhost:8038):
   - Type `/S SHUTALL` to initiate shutdown
   - Wait for "QUIESCE" messages
   - Type `QUIT` to exit Hercules

Or simply terminate the process: `pkill -f hercules`

### Phase 2: Specification Generation

- Analyze COBOL source code with AI assistance
- Generate plain-language specifications describing:
  - Business rules and logic
  - Data structures and relationships
  - Input/output formats
  - Error handling and edge cases

### Phase 3: Specification Verification

- Review specifications with domain experts
- Validate against observed system behavior in Hercules
- Iterate until specifications are complete and accurate

### Phase 4-6: Implementation & Beyond

- Use verified specifications to guide modern implementation
- Target stack: TBD (Python, Node.js, Go, etc.)
- Validate modern system produces identical results

---

## Key SpecOps Principles We'll Follow

1. **The Specification is the Source of Truth** - All changes flow through the spec first
2. **Knowledge Preservation Precedes Translation** - Understand before rebuilding
3. **Domain Experts Are the Arbiters** - Humans verify specifications, not code
4. **AI Assists, Humans Verify** - AI handles analysis; humans provide judgment
5. **Specifications Should Be Accessible** - Readable by non-technical stakeholders

---

## Resources

- [SpecOps Website](https://spec-ops.ai)
- [SpecOps GitHub Repository](https://github.com/mheadd/spec-ops)
- [GitHub spec-kit](https://github.com/github/spec-kit) - Foundational toolkit for specification-driven development
- [Hercules Emulator](http://www.hercules-390.org/)
- [Hercules Configuration Guide](http://www.hercules-390.org/hercconf.html)

---

## License

TBD
