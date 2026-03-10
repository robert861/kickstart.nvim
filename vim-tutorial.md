# Neovim Tutorial Reference

Saved from the built-in `:Tutor` command for quick reference.

---

## Chapter 1

### Lesson 0: Basics

- Press `<Esc>` then `u` to undo the latest change
- Press `<Enter>` on links to open help sections
- Press `K` on any word to find its documentation
- Close help windows with `:q` `<Enter>`

### Lesson 1.1: Moving the Cursor

```
      ↑
      k         h = left
 ← h    l →    j = down
      j         k = up
      ↓         l = right
```

### Lesson 1.2: Exiting Neovim

- `:q!` `<Enter>` — quit, DISCARDING changes
- `:wq` `<Enter>` — write and quit

### Lesson 1.3: Text Editing — Deletion

- `x` — delete the character under the cursor

### Lesson 1.4: Text Editing — Insertion

- `i` — insert text before the cursor (enters Insert mode)
- `<Esc>` — return to Normal mode

### Lesson 1.5: Text Editing — Appending

- `A` — append text at end of line (enters Insert mode)

### Lesson 1.6: Editing a File

- `:wq` — write (save) file and quit

### Lesson 1 Summary

1. Cursor movement: `h` (left), `j` (down), `k` (up), `l` (right)
2. Start Neovim: `nvim FILENAME`
3. Exit: `<Esc>` `:q!` `<Enter>` (discard) or `<Esc>` `:wq` `<Enter>` (save)
4. Delete character at cursor: `x`
5. Insert text: `i` (before cursor), `A` (end of line)

---

### Lesson 2.1: Deletion Commands

- `dw` — delete a word (from cursor to start of next word)

### Lesson 2.2: More Deletion Commands

- `d$` — delete to end of line

### Lesson 2.3: Operators and Motions

Format: `d motion`

- `d` = delete operator
- `w` = until start of next word (excluding first char)
- `e` = to end of current word (including last char)
- `$` = to end of line (including last char)
- `de` = delete from cursor to end of word

### Lesson 2.4: Using a Count for a Motion

- `2w` — move two words forward
- `3e` — move to end of third word forward
- `0` — move to start of line

### Lesson 2.5: Using a Count to Delete More

Format: `d number motion`

- `d2w` — delete two words

### Lesson 2.6: Operating on Lines

- `dd` — delete a whole line
- `2dd` — delete two lines

### Lesson 2.7: The Undo Command

- `u` — undo last command
- `U` — undo all changes on a line
- `Ctrl+r` — redo (undo the undo)

### Lesson 2 Summary

1. Delete to next word: `dw`
2. Delete to end of line: `d$`
3. Delete whole line: `dd`
4. Repeat motion with count: `2w`
5. Change command format: `operator [number] motion`
6. Move to start of line: `0`
7. Undo: `u` | Undo line: `U` | Redo: `Ctrl+r`

---

### Lesson 3.1: The Put Command

- `dd` — delete line (stores in register)
- `p` — put (paste) deleted text after cursor
- `P` — put before cursor

### Lesson 3.2: The Replace Command

- `rx` — replace character at cursor with `x`

### Lesson 3.3: The Change Operator

- `ce` — change from cursor to end of word (deletes and enters Insert mode)
- `c` works like `d` but leaves you in Insert mode

### Lesson 3.4: More Changes Using c

Format: `c [number] motion`

- `c$` — change to end of line

### Lesson 3 Summary

1. Put deleted text: `p` (after cursor)
2. Replace character: `r` then the replacement char
3. Change operator: `ce` (to end of word), `c$` (to end of line)
4. Format: `c [number] motion`

---

### Lesson 4.1: Cursor Location and File Status

- `Ctrl+g` — show location in file and file status
- `G` — move to end of file
- `gg` — move to start of file
- `{number}G` — move to that line number

### Lesson 4.2: The Search Command

- `/phrase` — search forward for phrase
- `?phrase` — search backward for phrase
- `n` — find next occurrence (same direction)
- `N` — find next occurrence (opposite direction)
- `Ctrl+o` — go back to older position
- `Ctrl+i` — go forward to newer position

### Lesson 4.3: Matching Parentheses Search

- `%` — jump to matching `(`, `)`, `[`, `]`, `{`, or `}`

### Lesson 4.4: The Substitute Command

- `:s/old/new` — substitute first occurrence on line
- `:s/old/new/g` — substitute all on line
- `:#,#s/old/new/g` — substitute all between line numbers
- `:%s/old/new/g` — substitute all in file
- `:%s/old/new/gc` — substitute all in file with confirmation

### Lesson 4 Summary

1. File position: `Ctrl+g` | End: `G` | Start: `gg` | Line N: `NG`
2. Search forward: `/phrase` | Backward: `?phrase`
3. Next/prev match: `n` / `N`
4. Navigate history: `Ctrl+o` (back) / `Ctrl+i` (forward)
5. Match brackets: `%`
6. Substitute: `:s/old/new/g` (line), `:%s/old/new/g` (file), add `c` for confirmation

---

### Lesson 5.1: Execute an External Command

- `:!command` — execute any external shell command (e.g., `:!ls`, `:!dir`)

### Lesson 5.2: Writing Files

- `:w FILENAME` — save current file with name FILENAME

### Lesson 5.3: Selecting Text to Write

- `v` — start Visual selection
- `:'<,'>w FILENAME` — save selected text to file

### Lesson 5.4: Retrieving and Merging Files

- `:r FILENAME` — read file and insert below cursor
- `:r !command` — read output of command and insert below cursor

### Lesson 5 Summary

1. Execute external command: `:!command`
2. Write file: `:w FILENAME`
3. Save selection: `v` (select) then `:w FILENAME`
4. Read/insert file: `:r FILENAME`
5. Read command output: `:r !command`

---

### Lesson 6.1: The Open Command

- `o` — open line BELOW cursor (enters Insert mode)
- `O` — open line ABOVE cursor (enters Insert mode)

### Lesson 6.2: The Append Command

- `a` — insert text AFTER cursor
- `i` — insert text BEFORE cursor
- `A` — insert text at end of line

### Lesson 6.3: Another Way to Replace

- `R` — enter Replace mode (overwrites characters until `<Esc>`)

### Lesson 6.4: Copy and Paste Text

- `y` — yank (copy) selected text (in Visual mode)
- `yw` — yank one word
- `p` — put (paste) after cursor
- `P` — put before cursor

### Lesson 6.5: Set Option

- `:set ic` — ignore case in search
- `:set noic` — disable ignore case
- `:set invic` — toggle ignore case
- `:set hls` — highlight search matches
- `:set is` — incremental search
- `:nohlsearch` — remove current highlighting
- `/phrase\c` — ignore case for one search

### Lesson 6 Summary

1. Open line below/above: `o` / `O`
2. Insert/append: `a` (after cursor), `A` (end of line), `i` (before cursor)
3. Move to end of word: `e`
4. Yank (copy): `y` | Put (paste): `p`
5. Replace mode: `R`
6. Set options: `:set ic`, `:set hls`, `:set is`
7. Toggle options: prepend `no` (off) or `inv` (toggle)

---

### Lesson 7.1: Getting Help

- `:help` or `<F1>` — open help
- `:help TOPIC` — help on specific topic
- `Ctrl+w Ctrl+w` — jump between windows
- `:q` — close help window

### Lesson 7.2: Completion

- `Ctrl+d` — show possible completions in command mode
- `<Tab>` — use completion menu / cycle forward
- `Shift+Tab` — cycle backward

### Lesson 7.3: Configuring Nvim

- `:exe 'edit' stdpath('config')..'/init.lua'` — edit config
- `:e $MYVIMRC` — quick open your config file

### Lesson 7 Summary

1. Help: `:help` or `<F1>`
2. Help on topic: `:help TOPIC`
3. Switch windows: `Ctrl+w Ctrl+w`
4. Command completion: `Ctrl+d` (list), `<Tab>` (cycle)
5. Edit config: `:e $MYVIMRC`

---

## Chapter 2: Registers and Marks

### Lesson 2.1.1: Named Registers

- `"ayiw` — yank inner word into register `a`
- `"byiw` — yank inner word into register `b`
- `ciw Ctrl+r a` — change inner word with contents of register `a`
- `"sdiw` — delete inner word into register `s`
- 26 named registers available: `a`-`z`

### Lesson 2.1.2: The Expression Register

- `Ctrl+r =` then expression `<Enter>` — insert result of calculation in Insert mode
- `Ctrl+r = system('date')` `<Enter>` — insert output of system command
- `:pu= system('date')` or `:r!date` — alternative ways

### Lesson 2.1.3: Numbered Registers

- `yy` — yank a whole line
- `dd` — delete a whole line (goes into numbered registers 1-9)
- `:reg` — inspect all registers
- `"7p` — paste from register 7
- Whole line deletions cascade through registers 1-9 (newest in 1)

### Lesson 2.1.4: Marks

- `ma` — set mark `a` at current position
- `'a` — jump to line containing mark `a`
- Technique for moving code blocks: `ma` (mark start), `$%` (go to end of block), `"ad'a` (delete block into register `a`), then `"ap` (paste it)
- Marks and registers do NOT share a namespace

### Chapter 2 Summary

1. Store/retrieve text with 26 named registers (`a`-`z`)
2. Yank inner word: `yiw` | Change inner word: `ciw`
3. Insert from register in Insert mode: `Ctrl+r a`
4. Insert calculation: `Ctrl+r =` expression `<Enter>`
5. Insert system call: `Ctrl+r = system('command')` `<Enter>`
6. Inspect registers: `:reg`
7. Numbered registers 1-9 hold recent whole-line deletions
8. Set marks: `m[a-z]` | Jump to mark line: `'[a-z]`

---

## Resources

- [Learn Vim Progressively](https://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)
- [Learning Vim in 2014](https://benmccormick.org/learning-vim-in-2014/)
- [Vimcasts](http://vimcasts.org/)
- [Vim Video-Tutorials by Derek Wyatt](http://derekwyatt.org/vim/tutorials/)
- [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)
- [7 Habits of Effective Text Editing](https://www.moolenaar.net/habits.html)
- [vim-galore](https://github.com/mhinz/vim-galore)
- Book: *Practical Vim* by Drew Neil
- Book: *Modern Vim* by Drew Neil (includes Neovim-specific content)
