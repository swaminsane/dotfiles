local ls  = require("luasnip")
local s   = ls.snippet
local sn  = ls.snippet_node
local i   = ls.insert_node
local t   = ls.text_node
local d   = ls.dynamic_node
local c   = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- ── Helpers ────────────────────────────────────────────────────────────────

-- auto-expanding snippet (triggers without needing Tab)
local function as(trigger, nodes)
  return s({ trig = trigger, snippetType = "autosnippet" }, nodes)
end

ls.add_snippets("tex", {

  -- ════════════════════════════════════════════════════════════════════════
  -- DOCUMENT STRUCTURE
  -- ════════════════════════════════════════════════════════════════════════
s("doc", fmt([[
\documentclass[{}]{{{}}}
\usepackage[utf8]{{inputenc}}
\usepackage{{amsmath, amssymb}}

\title{{{}}}
\author{{{}}}
\date{{\today}}

\begin{{document}}
\maketitle

{}

\end{{document}}
]], {
  i(1, "12pt"),
  c(2, { t("article"), t("report"), t("book") }),
  i(3, "Title"),
  i(4, "Author"),
  i(5),
})),
  -- generic begin/end  (works for any env)
  s("beg", fmt([[
\begin{{{}}}
  {}
\end{{{}}}]], { i(1), i(2), rep(1) })),

  s("sec",   fmt("\\section{{{}}}", { i(1) })),
  s("ssec",  fmt("\\subsection{{{}}}", { i(1) })),
  s("sssec", fmt("\\subsubsection{{{}}}", { i(1) })),
  s("par",   fmt("\\paragraph{{{}}}", { i(1) })),

  s("abs", fmt([[
\begin{{abstract}}
  {}
\end{{abstract}}]], { i(1) })),

  -- ════════════════════════════════════════════════════════════════════════
  -- MATH  (most are autosnippets so they fire inline while typing)
  -- ════════════════════════════════════════════════════════════════════════

  -- inline math
  as("mk", fmt("${}$", { i(1) })),

  -- display math
s("dm", fmt("\\[\n  {}\n\\]", { i(1) })),

  -- equation
  s("eq", fmt([[
\begin{{equation}}
  {}
\end{{equation}}]], { i(1) })),

  s("eq*", fmt([[
\begin{{equation*}}
  {}
\end{{equation*}}]], { i(1) })),

  -- align
  s("ali", fmt([[
\begin{{align}}
  {} &= {} \\\\
  {}
\end{{align}}]], { i(1), i(2), i(3) })),

  s("ali*", fmt([[
\begin{{align*}}
  {} &= {} \\\\
  {}
\end{{align*}}]], { i(1), i(2), i(3) })),

  -- cases
  s("cas", fmt([[
\begin{{cases}}
  {} & \text{{if }} {} \\\\
  {} & \text{{otherwise}}
\end{{cases}}]], { i(1), i(2), i(3) })),

  -- matrix  (pick type with <C-l> / <C-h>)
  s("mat", fmt([[
\begin{{{}}}
  {}
\end{{{}}}]], {
    c(1, { t("pmatrix"), t("bmatrix"), t("vmatrix"), t("matrix") }),
    i(2),
    rep(1),
  })),

  -- fractions & binomials
  as("//",    fmt("\\frac{{{}}}{{{}}}", { i(1), i(2) })),
  as("binom", fmt("\\binom{{{}}}{{{}}}", { i(1), i(2) })),

  -- operators
  as("sum",  fmt("\\sum_{{{}}}^{{{}}}", { i(1, "i=0"), i(2, "\\infty") })),
  as("prod", fmt("\\prod_{{{}}}^{{{}}}", { i(1, "i=1"), i(2, "n") })),
  as("int",  fmt("\\int_{{{}}}^{{{}}} {} \\, d{}", { i(1), i(2), i(3), i(4, "x") })),
  as("iint", fmt("\\iint_{{{}}} {} \\, d{}\\,d{}", { i(1), i(2), i(3, "x"), i(4, "y") })),
  as("lim",  fmt("\\lim_{{{}\\to {}}} {}", { i(1, "n"), i(2, "\\infty"), i(3) })),

  -- decorators
  as("vec",  fmt("\\mathbf{{{}}}", { i(1) })),
  as("hat",  fmt("\\hat{{{}}}", { i(1) })),
  as("bar",  fmt("\\bar{{{}}}", { i(1) })),
  as("tld",  fmt("\\tilde{{{}}}", { i(1) })),
  as("dot_", fmt("\\dot{{{}}}", { i(1) })),
  as("ddot", fmt("\\ddot{{{}}}", { i(1) })),

  -- number sets & logic (autosnippet)
  as("RR",    t("\\mathbb{R}")),
  as("NN",    t("\\mathbb{N}")),
  as("ZZ",    t("\\mathbb{Z}")),
  as("QQ",    t("\\mathbb{Q}")),
  as("CC",    t("\\mathbb{C}")),
  as("FF",    t("\\mathbb{F}")),
  as("=>",    t("\\implies")),
  as("<=>",   t("\\iff")),
  as("!=",    t("\\neq")),
  as("<=",    t("\\leq")),
  as(">=",    t("\\geq")),
  as("~=",    t("\\approx")),
  as("in_",   t("\\in")),
  as("notin", t("\\notin")),
  as("...",   t("\\ldots")),
  as("xx",    t("\\times")),
  as("**",    t("\\cdot")),
  as("00",    t("\\emptyset")),
  as("inf",   t("\\infty")),
  as("nab",   t("\\nabla")),
  as("pa",    fmt("\\partial {}", { i(1) })),

  -- auto subscript:  a1 → a_{1}
  as({ trig = "(%a)(%d)", regTrig = true },
    d(1, function(_, snip)
      return sn(nil, { t(snip.captures[1] .. "_{"), i(1, snip.captures[2]), t("}") })
    end)
  ),

  -- theorem environments
  s("thm", fmt([[
\begin{{theorem}}[{}]
  {}
\end{{theorem}}]], { i(1, "name"), i(2) })),

  s("lem", fmt([[
\begin{{lemma}}[{}]
  {}
\end{{lemma}}]], { i(1, "name"), i(2) })),

  s("prf", fmt([[
\begin{{proof}}
  {}
\end{{proof}}]], { i(1) })),

  s("def", fmt([[
\begin{{definition}}[{}]
  {}
\end{{definition}}]], { i(1), i(2) })),

  s("cor", fmt([[
\begin{{corollary}}[{}]
  {}
\end{{corollary}}]], { i(1), i(2) })),

  s("rem", fmt([[
\begin{{remark}}
  {}
\end{{remark}}]], { i(1) })),

  -- ════════════════════════════════════════════════════════════════════════
  -- TEXT FORMATTING
  -- ════════════════════════════════════════════════════════════════════════

  s("bf",   fmt("\\textbf{{{}}}", { i(1) })),
  s("it",   fmt("\\textit{{{}}}", { i(1) })),
  s("tt",   fmt("\\texttt{{{}}}", { i(1) })),
  s("ul",   fmt("\\underline{{{}}}", { i(1) })),
  s("em",   fmt("\\emph{{{}}}", { i(1) })),
  s("sc",   fmt("\\textsc{{{}}}", { i(1) })),
  s("col",  fmt("\\textcolor{{{}}}{{{}}}", { i(1, "red"), i(2) })),
  s("url",  fmt("\\url{{{}}}", { i(1) })),
  s("href", fmt("\\href{{{}}}{{{}}}",  { i(1), i(2) })),
  s("fn",   fmt("\\footnote{{{}}}", { i(1) })),

  -- ════════════════════════════════════════════════════════════════════════
  -- LISTS
  -- ════════════════════════════════════════════════════════════════════════

  s("itm", fmt([[
\begin{{itemize}}
  \item {}
\end{{itemize}}]], { i(1) })),

  s("enum", fmt([[
\begin{{enumerate}}
  \item {}
\end{{enumerate}}]], { i(1) })),

  s("desc", fmt([[
\begin{{description}}
  \item[{}] {}
\end{{description}}]], { i(1), i(2) })),

  s("item", t("\\item ")),

  -- ════════════════════════════════════════════════════════════════════════
  -- FIGURES & TABLES
  -- ════════════════════════════════════════════════════════════════════════

  s("fig", fmt([[
\begin{{figure}}[{}]
  \centering
  \includegraphics[width={}]{{{}}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}]], {
    c(1, { t("htbp"), t("h!"), t("t"), t("b") }),
    i(2, "0.8\\linewidth"),
    i(3, "filename"),
    i(4, "Caption"),
    i(5),
  })),

  s("subfig", fmt([[
\begin{{figure}}[{}]
  \centering
  \begin{{subfigure}}{{{}}}
    \includegraphics[width=\linewidth]{{{}}}
    \caption{{{}}}
  \end{{subfigure}}
  \hfill
  \begin{{subfigure}}{{{}}}
    \includegraphics[width=\linewidth]{{{}}}
    \caption{{{}}}
  \end{{subfigure}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}]], {
    c(1, { t("htbp"), t("h!") }),
    i(2, "0.45\\linewidth"), i(3), i(4, "Left"),
    i(5, "0.45\\linewidth"), i(6), i(7, "Right"),
    i(8, "Overall caption"),
    i(9),
  })),

  -- table with booktabs
  s("tab", fmt([[
\begin{{table}}[{}]
  \centering
  \caption{{{}}}
  \label{{tab:{}}}
  \begin{{tabular}}{{{}}}
    \toprule
    {} \\
    \midrule
    {} \\
    \bottomrule
  \end{{tabular}}
\end{{table}}]], {
    c(1, { t("htbp"), t("h!") }),
    i(2, "Caption"),
    i(3),
    i(4, "l c c"),
    i(5, "Col1 & Col2 & Col3"),
    i(6, "data & data & data"),
  })),

  -- ════════════════════════════════════════════════════════════════════════
  -- BIBLIOGRAPHY
  -- ════════════════════════════════════════════════════════════════════════

  s("bib", fmt([[
\usepackage[backend=biber, style={}]{{biblatex}}
\addbibresource{{{}.bib}}]], {
    c(1, { t("authoryear"), t("numeric"), t("apa"), t("ieee") }),
    i(2, "refs"),
  })),

  s("cite",     fmt("\\cite{{{}}}", { i(1) })),
  s("pcite",    fmt("\\parencite{{{}}}", { i(1) })),
  s("tcite",    fmt("\\textcite{{{}}}", { i(1) })),
  s("fcite",    fmt("\\footcite{{{}}}", { i(1) })),
  s("printbib", t("\\printbibliography")),

  -- ════════════════════════════════════════════════════════════════════════
  -- CODE LISTINGS
  -- ════════════════════════════════════════════════════════════════════════

  s("lst", fmt([[
\begin{{lstlisting}}[language={}, caption={{{}}}]
{}
\end{{lstlisting}}]], {
    c(1, { t("Python"), t("C"), t("C++"), t("bash"), t("lua") }),
    i(2, "caption"),
    i(3),
  })),

  s("verb", fmt("\\verb|{}|", { i(1) })),

  -- ════════════════════════════════════════════════════════════════════════
  -- BEAMER (slides)
  -- ════════════════════════════════════════════════════════════════════════

  s("frame", fmt([[
\begin{{frame}}{{{}}}
  {}
\end{{frame}}]], { i(1, "Title"), i(2) })),

  s("block", fmt([[
\begin{{block}}{{{}}}
  {}
\end{{block}}]], { i(1, "Title"), i(2) })),

  s("col2", fmt([[
\begin{{columns}}
  \begin{{column}}{{0.5\textwidth}}
    {}
  \end{{column}}
  \begin{{column}}{{0.5\textwidth}}
    {}
  \end{{column}}
\end{{columns}}]], { i(1), i(2) })),

}, { key = "tex" })
