# Note 01 — Programming Fundamentals, Program Development & Algorithms

> **Covers outline Week 1** (Introduction to programming methodology) and the algorithm/flowchart part of Week 2.

---

## 1. The absolute basics

### Key definitions (learn these word-for-word)

| Term | Definition |
|---|---|
| **Computer** | An electronic device that accepts data, processes it according to instructions, and produces information. |
| **Data** | Raw, unprocessed facts (e.g., `45`, `"Ali"`, `3.14`). |
| **Information** | Processed data that is meaningful (e.g., "Average mark = 45%"). |
| **Program** | A finite set of sequenced instructions or commands given to a computer to carry out a particular task. |
| **Programming** | The art and process of writing a set of instructions in a programming language to control the activities of a computer. |
| **Programming language** | An artificial language with its own vocabulary (keywords) and grammar (syntax) used to write instructions for a computer. |
| **Syntax** | The set of grammatical rules of a language (spelling, punctuation, structure). |
| **Semantics** | The meaning of a statement — what it actually does. |
| **Source code** | The program as written by the programmer (e.g., `hello.c`). |
| **Object code** | The machine-language translation of the source code (e.g., `hello.o`). |
| **Executable** | The final linked program that the computer can run (e.g., `hello.exe`). |

**Analogy:** a program is a recipe; a programming language is the language the recipe is written in; the computer is the cook that follows it exactly — including mistakes.

---

## 2. Classification of programming languages

There are two major levels:

```
Programming languages
├── Low-level languages
│   ├── Machine language (binary: 0s and 1s)
│   └── Assembly language (mnemonics: MOV, ADD, JMP)
└── High-level languages
    ├── Compiled (C, C++, Pascal, Java*)
    └── Interpreted (Python, Ruby, JavaScript)
```

### 2.1 Machine language (first generation)

The native language of the CPU. Instructions are strings of 0s and 1s.

**Advantages**
- Executed directly — **no translator needed**.
- Fast and efficient use of the computer.

**Disadvantages**
- Very bulky and tedious to write.
- Difficult to read, learn and debug.
- Prone to errors that are hard to find.
- **Machine-dependent** — runs only on the computer it was written for.

### 2.2 Assembly language (second generation)

Uses **mnemonics** (short symbolic names) such as `MOV`, `ADD`, `SUB`, `JMP` instead of binary. A translator called an **assembler** converts it to machine code.

**Advantages**
- Easier than machine language; complex jobs are simpler to express.
- Memory-efficient and fast (less execution time).
- Hardware-oriented; useful for critical jobs (device drivers, embedded systems).
- Fewer instructions needed to get a result.

**Disadvantages**
- Still **machine-dependent**; the programmer must know the hardware.
- Cumbersome (though less than machine language).
- Expensive and time-consuming to develop.

### 2.3 High-level language (third generation and above)

Problem-oriented, English-like language. Examples: **FORTRAN, COBOL, BASIC, Pascal, C, C++, Java, Python**.

**Advantages**
- No knowledge of the particular computer is required.
- **Portable** — the same source program can run on different machines after recompiling.
- Easy to learn, write, read and maintain.
- Supports structured and modular programming.

**Disadvantages**
- Needs translation time (compile/interpret).
- Usually slower and less memory-efficient than low-level code.
- Cannot communicate directly with hardware (without special extensions).

**Features of high-level languages:** machine-independent, problem-oriented, readable, portable, and able to reflect program structure clearly.

### 2.4 Generations of languages (often a 2-mark question)

| Generation | Description | Example |
|---|---|---|
| 1GL | Machine code | Binary instructions |
| 2GL | Assembly | `MOV AX, 5` |
| 3GL | High-level, procedural | C, Pascal, FORTRAN |
| 4GL | Very high-level, problem-oriented | SQL, MATLAB |
| 5GL | AI / natural language | Prolog, Lisp (logic/AI) |

---

## 3. Translators and the tools around them

| Tool | What it does |
|---|---|
| **Assembler** | Translates assembly language → machine code |
| **Compiler** | Translates a whole high-level program into machine/object code at once |
| **Interpreter** | Translates and executes one statement at a time |
| **Linker** | Joins object code with library code to produce an executable |
| **Loader** | Loads the executable from secondary storage into RAM for execution |
| **Debugger** | Helps find and fix errors while the program runs |
| **Preprocessor** | Handles `#include`, `#define` and other `#` directives before compilation |

### Compiler vs interpreter (a classic exam table)

| Compiler | Interpreter |
|---|---|
| Translates the **entire program** at once | Translates **one statement at a time** |
| Produces intermediate object code | Produces **no** intermediate object code |
| Slower to analyse/compile, but the program then runs faster | Faster to start, but overall execution is slower |
| Needs more memory (object code + linker) | More memory-efficient |
| Reports errors only after scanning the whole program | Stops at the first error, so debugging is easier |
| Examples: C, C++ | Examples: Python, Ruby, JavaScript |

> Java is a hybrid: it compiles to **bytecode**, which is then interpreted/JIT-compiled by the Java Virtual Machine (JVM).

---

## 4. Characteristics of a good program

Learn at least six; the examiner may ask for any number.

| Characteristic | Meaning |
|---|---|
| **Correctness** | Produces the right output for all valid inputs. |
| **Reliability** | Can be depended on to do what it is supposed to do; handles errors gracefully. |
| **Portability / transferability** | Runs on different computers with little or no change. |
| **Efficiency** | Uses as little processor time and memory as possible. |
| **Clarity / simplicity** | Easy to understand; not unnecessarily complicated. |
| **Readability** | Well-named variables, indentation, comments — other programmers can follow it. |
| **Maintainability / flexibility** | Easy to modify, correct and extend without breaking other parts. |
| **Robustness** | Anticipates bad input and runtime problems instead of crashing. |
| **Usability** | Output is clear and the program is comfortable to use. |
| **Cost-effectiveness** | The benefit outweighs the development and running cost. |
| **Timeliness** | Delivered within the agreed time and budget. |
| **Storage saving** | Not unnecessarily long or memory-hungry. |

**Memory sentence:** *A good program is correct, reliable, portable, efficient, simple, readable, maintainable and robust.*

---

## 5. Phases of program development

This is almost guaranteed to appear. Learn the **order**.

```
1. Problem definition / analysis
2. Selection or development of an algorithm
3. Designing the program (flowchart / pseudocode / IPO / HIPO)
4. Coding
5. Compilation
6. Testing, running and debugging
7. Documentation
8. Maintenance
```

### 5.1 Problem definition / analysis

Understand the problem before writing any code:

- What **input** data is needed? What type, form and volume?
- What **processing** is required?
- What **output** is expected?
- What are the constraints, error conditions and interfaces with other systems?

> If you skip this stage, you may build the wrong program perfectly.

### 5.2 Algorithm

An **algorithm** is a finite, ordered set of unambiguous steps for solving a problem. It is written in plain language before coding.

**Features of an algorithm**
1. **Input** — zero or more quantities are supplied.
2. **Output** — at least one quantity is produced.
3. **Definiteness** — every step is clear and unambiguous.
4. **Finiteness** — it terminates after a finite number of steps.
5. **Effectiveness** — every step is basic enough to be carried out.

Additional good qualities: simple, clear, handles unexpected situations, leads to a unique solution.

### 5.3 Designing the program

Tools:

- **Pseudocode** — English-like structured description of the logic.
- **Flowchart** — pictorial/diagrammatic representation.
- **IPO chart** — Input, Processing, Output.
- **HIPO chart** — Hierarchical Input, Processing and Output.
- **Decision table** — tabular representation of rules.
- **Data flow diagram (DFD)** — shows how data moves through a system.

### 5.4 Coding

Translate the design into a programming language. Good coding habits:

- Meaningful variable names.
- Simple, clear expressions.
- Modular design.
- Comments and consistent indentation.
- Avoid unnecessary jumps (`goto`).

### 5.5 Compilation

The source code is translated into object code and linked with libraries to form an executable. Errors found here are **syntax errors**.

### 5.6 Testing, running and debugging

- **Debugging** = finding and fixing errors.
- **Testing** = running the program with carefully chosen data to check it works.
- Test **normal**, **boundary** (minimum/maximum) and **invalid/abnormal** data.
- A program that is error-free on test data can then be used with real data.

### 5.7 Documentation

Written records describing the program:

- Purpose and what it does.
- Input data: amount, type, source.
- Output: what is produced and who uses it.
- The logic/algorithm followed.
- Author, date, version and modification history.
- How to install, run and maintain it.

### 5.8 Maintenance

Everything after delivery:

- Correct errors found in use.
- Adapt to new hardware/software.
- Improve or add features.
- Remove redundant code.
- Update documentation.

**Maintenance is usually the most expensive phase over the life of a program.**

---

## 6. Algorithms in practice

### 6.1 Pseudocode rules

There is no single standard, but be consistent. Common keywords:

```
START / BEGIN
READ / INPUT
SET / ASSIGN
CALCULATE
IF ... THEN ... ELSE ... ENDIF
WHILE ... DO ... ENDWHILE
FOR ... TO ... DO ... ENDFOR
PRINT / DISPLAY / WRITE
STOP / END
```

### Example 1 — add two numbers

```
START
READ a, b
sum = a + b
PRINT sum
STOP
```

### Example 2 — average of four marks

```
START
READ m1, m2, m3, m4
average = (m1 + m2 + m3 + m4) / 4
IF average < 50 THEN
    PRINT "Fail"
ELSE
    PRINT "Pass"
ENDIF
STOP
```

### Example 3 — largest of three numbers

```
START
READ a, b, c
IF a > b THEN
    big = a
ELSE
    big = b
ENDIF
IF big > c THEN
    largest = big
ELSE
    largest = c
ENDIF
PRINT largest
STOP
```

### Example 4 — area of a room

```
START
READ length, width
area = length × width
PRINT area
STOP
```

### Example 5 — sum of the first N natural numbers

```
START
READ n
sum = 0
FOR i = 1 TO n DO
    sum = sum + i
ENDFOR
PRINT sum
STOP
```

---

## 7. Flowcharts

A **flowchart** is a diagrammatic representation of an algorithm. It shows the flow of control using standard symbols connected by arrows.

### 7.1 Standard symbols

| Symbol | Name | Meaning |
|---|---|---|
| Oval / rounded rectangle | Terminator | Start or stop |
| Parallelogram | Input/Output | Read input or display output |
| Rectangle | Process | Calculation or assignment |
| Diamond | Decision | A condition with Yes/No (True/False) branches |
| Circle | Connector | Joins parts of the flowchart (especially across pages) |
| Arrow | Flow line | Direction of execution |
| Cylinder | Data store | File/database storage (mostly in system flowcharts) |
| Document | Document | Printed report/output |

You can draw these by hand in the exam; label them clearly.

### 7.2 Example — average of four numbers

```
        ┌─────────┐
        │  START  │
        └────┬────┘
             ▼
   ┌────────────────────┐
   │ READ A, B, C, D    │
   └─────────┬──────────┘
             ▼
   ┌────────────────────┐
   │ P = (A+B+C+D)/4    │
   └─────────┬──────────┘
             ▼
   ┌────────────────────┐
   │ PRINT P            │
   └─────────┬──────────┘
             ▼
        ┌─────────┐
        │  STOP   │
        └─────────┘
```

### 7.3 Example — average only if A is not zero

```
        ┌─────────┐
        │  START  │
        └────┬────┘
             ▼
   ┌────────────────────┐
   │ READ A, B, C, D    │
   └─────────┬──────────┘
             ▼
        ◇─────────◇
       ╱  A == 0?  ╲
      ╱ Yes         ╲ No
     ▼               ▼
┌─────────┐   ┌────────────────────┐
│  STOP   │   │ P = (A+B+C+D)/4    │
└─────────┘   └─────────┬──────────┘
                        ▼
                ┌────────────────────┐
                │ PRINT P            │
                └─────────┬──────────┘
                        ▼
                   ┌─────────┐
                   │  STOP   │
                   └─────────┘
```

### 7.4 Uses of flowcharts

- Show the entire system as a whole.
- Examine all possible logical outcomes.
- Communicate the logic to others.
- Provide insight into alternative solutions.
- See what happens when variable values change.

### 7.5 Advantages

- **Communication** — visual aid for explaining logic.
- **Documentation** — records the logic; helps when staff leave or forget.
- **Analysis** — clarifies the overall picture.
- **Consistency** — standard symbols show relationships between parts.
- **Modification** — changes are easier to plan.

### 7.6 Disadvantages

- **Complex logic** makes the flowchart cluttered and unclear.
- **Alterations** may require completely redrawing it.
- **Reproduction** is difficult because symbols are hard to type.
- Time-consuming to draw for large programs.

---

## 8. Other design tools

### 8.1 Decision table

A tabular way of representing logic when several conditions combine.

Example: discount based on age and membership.

| Conditions / Actions | Rule 1 | Rule 2 | Rule 3 | Rule 4 |
|---|---|---|---|---|
| Age > 60 | Y | Y | N | N |
| Member | Y | N | Y | N |
| **Action: 20% discount** | ✓ | | | |
| **Action: 10% discount** | | ✓ | ✓ | |
| **Action: no discount** | | | | ✓ |

**Advantages:** clarity, compactness, coverage (all cases considered), maintainability.
**Use in programming:** translate columns into `if-else` chains, `switch` statements or rule-based systems.

### 8.2 Data flow diagram (DFD)

Shows **how data moves** through a system. It has no control flow, no loops and no decisions.

**Components**
1. **External entity** — source or destination of data (e.g., customer).
2. **Process** — transforms input data into output (e.g., "calculate total").
3. **Data store** — where data is kept (e.g., file/database).
4. **Data flow** — the arrow showing data moving between the above.

**Types**
- **Logical DFD** — focuses on processes and data flow, ignoring technology.
- **Physical DFD** — shows how the system is actually implemented (technology, storage, transmission).

**Characteristics:** graphical, good for analysis, abstraction, hierarchy (Level 0 context diagram → Level 1 → Level 2), easy to understand, modular.

### 8.3 IPO chart

| Input | Processing | Output |
|---|---|---|
| `length`, `width` | `area = length * width` | `area` |

Use this before writing any program — it forces you to think clearly.

---

## 9. Errors in programs

| Error type | When it occurs | Detected by | Example |
|---|---|---|---|
| **Syntax error** | Before the program runs | Compiler | Missing semicolon, missing `)`, misspelled keyword, undeclared variable |
| **Runtime error** | While the program runs | The running program / OS | Division by zero, array index out of bounds, file not found |
| **Logical error** | Program runs but gives wrong output | Testing / comparing with expected output | Using `>` instead of `>=`, wrong formula, `5/2` instead of `5.0/2` |

**Notes:**
- Syntax errors are also called **compile-time errors**.
- A runtime error may crash the program or produce `inf`/garbage.
- Logical errors are the hardest to find because the compiler reports nothing.

### Debugging tips

- Read the error message from the **first** line; fix one error at a time and recompile.
- Print intermediate values with `printf`.
- Check loop bounds and array indices.
- Dry-run with a small input.
- Check that variables are initialised.

---

## 10. Structured programming

**Structured programming** means building a program from a small set of clear control structures, using top-down design and modules.

The three control structures (learn these):

1. **Sequence** — statements execute one after another.
2. **Selection** — a condition chooses between alternatives (`if`, `switch`).
3. **Repetition / iteration** — a block repeats (`while`, `do-while`, `for`).

**Principles**
- Top-down design: break the problem into smaller sub-problems.
- Modularity: one function/module per task.
- Single entry, single exit for each block.
- Avoid `goto` (it makes control flow hard to follow).
- Use meaningful names, indentation and comments.

**Advantages:** easier to read, test, debug and maintain; reusable modules; fewer errors.

---

## 11. Types of problems a computer can solve

Computers are good at problems that can be broken into precise, repetitive, logical steps:

- **Numerical/scientific:** solving equations, statistics, simulations.
- **Data processing:** payroll, inventory, student records.
- **Business:** accounting, billing, booking systems.
- **Information retrieval:** search, databases.
- **Control systems:** traffic lights, robots, embedded devices.
- **Communication:** email, messaging, networking.
- **Graphics and gaming.**
- **Artificial intelligence / machine learning** (with the right algorithms).

Computers are **not** good at problems that cannot be specified precisely, require human judgement, creativity, or common-sense understanding.

---

## 12. Worked exam answer: "Explain the phases of program development" (10 marks)

> 1. **Problem definition/analysis** — identify inputs, processing, outputs and constraints. *(1)*
> 2. **Algorithm development** — write a finite, unambiguous step-by-step solution. *(1)*
> 3. **Program design** — represent the algorithm using pseudocode, flowcharts, IPO/HIPO charts. *(1)*
> 4. **Coding** — translate the design into a programming language, following good style. *(1)*
> 5. **Compilation** — translate source code to object code and link with libraries. *(1)*
> 6. **Testing and debugging** — run with normal, boundary and invalid data; find and fix syntax, runtime and logical errors. *(1)*
> 7. **Documentation** — record the purpose, inputs, outputs, logic and maintenance instructions. *(1)*
> 8. **Maintenance** — correct, adapt and improve the program after delivery. *(1)*
>
> Plus 2 marks for explaining why the order matters (each phase feeds the next; skipping analysis or testing leads to unreliable programs).

---

## 13. Common exam traps

1. **Algorithm vs program:** an algorithm is language-independent; a program is written in a specific language.
2. **Compiler vs interpreter:** do not say "compiler is faster" without saying *what* is faster (compiled code runs faster; compilation itself takes longer).
3. **Syntax vs logical error:** a program with a logical error **does compile**.
4. **Flowchart decision symbol** must have one input and **two outputs** (Yes/No).
5. **Maintenance is a phase**, even though it happens after delivery.
6. **DFD has no decisions or loops** — that is a flowchart.
7. **Machine language needs no translator**, but assembly does (an assembler).
8. **Portability** belongs to high-level languages, not machine language.

---

## 14. Self-test (answers below)

1. Define a program and a programming language.
2. State four differences between a compiler and an interpreter.
3. List six characteristics of a good program.
4. List the eight phases of program development in order.
5. What are the five features of an algorithm?
6. Name five ways of representing an algorithm.
7. Draw the flowchart symbols for start/stop, input/output, process and decision.
8. Differentiate between a syntax error, a runtime error and a logical error.
9. Explain why maintenance is expensive.
10. Write pseudocode and draw a flowchart to find the largest of three numbers.
11. What is the difference between an algorithm and pseudocode?
12. State three advantages and two disadvantages of flowcharts.
13. What are the three control structures of structured programming?
14. What is a DFD? Name its four components.
15. Classify programming languages and give one example of each level.

### Answers

1. A program is a finite set of sequenced instructions given to a computer to perform a task. A programming language is an artificial language with vocabulary and grammar used to write those instructions.
2. Compiler translates the whole program at once / interpreter one statement at a time; compiler produces object code / interpreter does not; compiled code runs faster / interpreted code runs slower; compiler reports errors after the whole scan / interpreter stops at the first error.
3. Any six: correctness, reliability, portability, efficiency, simplicity, readability, maintainability, robustness, usability, cost-effectiveness.
4. Problem definition → algorithm → design → coding → compilation → testing/debugging → documentation → maintenance.
5. Input, output, definiteness, finiteness, effectiveness.
6. English-like steps, pseudocode, flowchart, decision table, DFD (also IPO/HIPO).
7. Oval = start/stop; parallelogram = input/output; rectangle = process; diamond = decision.
8. Syntax: grammar violation, found by compiler, program will not compile. Runtime: occurs during execution (e.g., divide by zero). Logical: compiles and runs but gives wrong output.
9. Because it covers the whole life of the program: fixing errors, adapting to new hardware, adding features and updating documentation, often for years.
10. See §6 Example 3 and §7.3.
11. An algorithm is the logical solution; pseudocode is one *way of writing* that algorithm in structured English.
12. Advantages: communication, documentation, analysis, consistency. Disadvantages: complex logic becomes cluttered; alterations require redrawing; hard to reproduce.
13. Sequence, selection, repetition.
14. A diagram showing how data flows through a system. Components: external entity, process, data store, data flow.
15. Low-level: machine (binary) and assembly (mnemonics); high-level: C, Pascal, Python, etc.; fourth-generation: SQL; fifth-generation: Prolog.

---

**Next:** `02_c_basics_and_compilation.md`
