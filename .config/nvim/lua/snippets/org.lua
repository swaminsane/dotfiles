local ls  = require("luasnip")
local s   = ls.snippet
local i   = ls.insert_node
local t   = ls.text_node
local c   = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("org", {

  -- ════════════════════════════════════════════════════════════════════════
  -- HEADINGS
  -- ════════════════════════════════════════════════════════════════════════

  s("h1",  fmt("* {}", { i(1) })),
  s("h2",  fmt("** {}", { i(1) })),
  s("h3",  fmt("*** {}", { i(1) })),
  s("h4",  fmt("**** {}", { i(1) })),

  -- heading with TODO
  s("th1", fmt("* TODO {}", { i(1) })),
  s("th2", fmt("** TODO {}", { i(1) })),

  -- heading with tag
  s("ht", fmt("* {}  :{}: ", { i(1), i(2, "tag") })),

  -- ════════════════════════════════════════════════════════════════════════
  -- TODO & TASKS
  -- ════════════════════════════════════════════════════════════════════════

  s("todo",  fmt("* TODO {}", { i(1) })),
  s("done",  fmt("* DONE {}", { i(1) })),
  s("wait",  fmt("* WAITING {}", { i(1) })),
  s("canc",  fmt("* CANCELLED {}", { i(1) })),

  -- task with deadline
  s("tdl", fmt([[
* TODO {}
  DEADLINE: <{}>]], { i(1), i(2, "yyyy-mm-dd") })),

  -- task with scheduled
  s("tsc", fmt([[
* TODO {}
  SCHEDULED: <{}>]], { i(1), i(2, "yyyy-mm-dd") })),

  -- checkbox items
  s("cb",  t("- [ ] ")),
  s("cbd", t("- [X] ")),

  -- ════════════════════════════════════════════════════════════════════════
  -- TIMESTAMPS
  -- ════════════════════════════════════════════════════════════════════════

  s("ts",   fmt("<{}>", { i(1, "yyyy-mm-dd") })),
  s("tsi",  fmt("[{}]", { i(1, "yyyy-mm-dd") })),   -- inactive timestamp
  s("tsr",  fmt("<{}> -- <{}>", { i(1, "yyyy-mm-dd"), i(2, "yyyy-mm-dd") })),  -- range

  -- ════════════════════════════════════════════════════════════════════════
  -- PROPERTIES & METADATA
  -- ════════════════════════════════════════════════════════════════════════

  s("prop", fmt([[
:PROPERTIES:
:{}: {}
:END:]], { i(1, "KEY"), i(2, "value") })),

  s("filetags", fmt("#+FILETAGS: :{}: ", { i(1) })),

  -- file header
  s("hdr", fmt([[
#+TITLE: {}
#+AUTHOR: {}
#+DATE: {}
#+DESCRIPTION: {}
#+STARTUP: {}
]], {
    i(1, "Title"),
    i(2, "Author"),
    i(3, "yyyy-mm-dd"),
    i(4, ""),
    c(5, { t("overview"), t("showall"), t("content"), t("fold") }),
  })),

-- simple file header
  s("ta", fmt([[
#+TITLE: {}
#+AUTHOR: {}]], { i(1, "Title"), i(2, "Swami Vivekanand") })),

  -- ════════════════════════════════════════════════════════════════════════
  -- BLOCKS
  -- ════════════════════════════════════════════════════════════════════════

  -- source code block
  s("src", fmt([[
#+BEGIN_SRC {}
{}
#+END_SRC]], {
    c(1, { t("python"), t("bash"), t("lua"), t("c"), t("cpp"), t("javascript") }),
    i(2),
  })),

  -- example block
  s("ex", fmt([[
#+BEGIN_EXAMPLE
{}
#+END_EXAMPLE]], { i(1) })),

  -- quote block
  s("qt", fmt([[
#+BEGIN_QUOTE
{}
#+END_QUOTE]], { i(1) })),

  -- note block (with comment header)
  s("note", fmt([[
#+BEGIN_NOTE
{}
#+END_NOTE]], { i(1) })),

  -- verse block
  s("vs", fmt([[
#+BEGIN_VERSE
{}
#+END_VERSE]], { i(1) })),

  -- center block
  s("ctr", fmt([[
#+BEGIN_CENTER
{}
#+END_CENTER]], { i(1) })),

  -- comment block
  s("com", fmt([[
#+BEGIN_COMMENT
{}
#+END_COMMENT]], { i(1) })),

  -- ════════════════════════════════════════════════════════════════════════
  -- LINKS
  -- ════════════════════════════════════════════════════════════════════════

  s("lnk",  fmt("[[{}][{}]]", { i(1, "url"), i(2, "description") })),
  s("lnkf", fmt("[[file:{}][{}]]", { i(1, "path"), i(2, "description") })),
  s("lnkh", fmt("[[https://{}][{}]]", { i(1), i(2, "description") })),
  s("img",  fmt("[[file:{}]]", { i(1, "image.png") })),

  -- ════════════════════════════════════════════════════════════════════════
  -- LISTS & FORMATTING
  -- ════════════════════════════════════════════════════════════════════════

  s("li",   fmt("- {}", { i(1) })),
  s("oli",  fmt("1. {}", { i(1) })),
  s("dt",   fmt("- {} :: {}", { i(1, "term"), i(2, "definition") })),  -- definition list

  -- text formatting
  s("bf",   fmt("*{}*", { i(1) })),
  s("it",   fmt("/{}/", { i(1) })),
  s("ul",   fmt("_{}_", { i(1) })),
  s("tt",   fmt("~{}~", { i(1) })),
  s("vb",   fmt("={}=", { i(1) })),
  s("st",   fmt("+{}+", { i(1) })),   -- strikethrough

  -- ════════════════════════════════════════════════════════════════════════
  -- TABLES
  -- ════════════════════════════════════════════════════════════════════════

  s("tbl", fmt([[
| {} | {} | {} |
|---+---+---|
| {} | {} | {} |]], {
    i(1, "Col1"), i(2, "Col2"), i(3, "Col3"),
    i(4), i(5), i(6),
  })),

  -- ════════════════════════════════════════════════════════════════════════
  -- CAPTURE & NOTES
  -- ════════════════════════════════════════════════════════════════════════

  -- daily journal entry
  s("day", fmt([[
* {}
  :PROPERTIES:
  :DATE: {}
  :END:

{}]], { i(1, "Daily Note"), i(2, "yyyy-mm-dd"), i(3) })),

  -- meeting note
  s("meet", fmt([[
* MEETING {}
  :PROPERTIES:
  :DATE: {}
  :ATTENDEES: {}
  :END:

** Agenda
{}

** Notes
{}

** Action Items
- [ ] {}]], {
    i(1, "Meeting Title"),
    i(2, "yyyy-mm-dd"),
    i(3, "names"),
    i(4),
    i(5),
    i(6),
  })),

  -- idea/fleeting note
  s("idea", fmt([[
* IDEA {}
  :PROPERTIES:
  :CREATED: {}
  :END:
{}]], { i(1), i(2, "yyyy-mm-dd"), i(3) })),

  -- reference note
  s("ref", fmt([[
* {}
  :PROPERTIES:
  :SOURCE: {}
  :AUTHOR: {}
  :DATE: {}
  :END:

{}]], { i(1, "Title"), i(2, "url/book"), i(3), i(4, "yyyy-mm-dd"), i(5) })),

-- ════════════════════════════════════════════════════════════════════════
-- HTML EXPORT BLOCKS
-- ════════════════════════════════════════════════════════════════════════

-- generic html export block
s("html", fmt([[
#+BEGIN_EXPORT html
{}
#+END_EXPORT]], { i(1) })),

-- author + abstract header (your site pattern)
s("pghead", fmt([[
#+BEGIN_EXPORT html
<p class="author">{} <br> {}</p>
<div class="abstract">
  <h2>Abstract</h2>
  <p>{}</p>
</div>
#+END_EXPORT]], { i(1, "Your Name"), i(2, "Month yyyy"), i(3, "Description") })),

-- standalone abstract
s("abst", fmt([[
#+BEGIN_EXPORT html
<div class="abstract">
  <h2>Abstract</h2>
  <p>{}</p>
</div>
#+END_EXPORT]], { i(1) })),

-- author line only
s("auth", fmt([[
#+BEGIN_EXPORT html
<p class="author">{} <br> {}</p>
#+END_EXPORT]], { i(1, "Your Name"), i(2, "Month yyyy") })),

-- arbitrary html tag with class
s("htag", fmt([[
#+BEGIN_EXPORT html
<{} class="{}">
  {}
</{}>
#+END_EXPORT]], { i(1, "div"), i(2, "classname"), i(3), rep(1) })),


}, { key = "org" })
