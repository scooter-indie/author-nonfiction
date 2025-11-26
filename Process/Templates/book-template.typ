// Book Template for PDF Export
// Framework: AI-Assisted Nonfiction Authoring Framework v0.13.12
// Purpose: Professional book layout for Typst PDF generation
//
// Usage: typst compile book.typ book.pdf
// With custom fonts: typst compile --font-path "Manuscript/Style/fonts" book.typ book.pdf

// ============================================================================
// DOCUMENT METADATA
// ============================================================================
// These are set by the content file that imports this template
// Example: #show: book.with(title: "My Book", author: "Author Name")

#let book(
  title: "Untitled",
  author: "Unknown Author",
  date: none,
  paper-size: "us-letter",
  font-body: "Linux Libertine",
  font-size: 11pt,
  margin-inside: 1.25in,
  margin-outside: 1in,
  margin-top: 1in,
  margin-bottom: 1in,
  body,
) = {

  // ==========================================================================
  // PAGE SETUP
  // ==========================================================================
  set document(
    title: title,
    author: author,
  )

  set page(
    paper: paper-size,
    margin: (
      top: margin-top,
      bottom: margin-bottom,
      inside: margin-inside,   // Larger for binding
      outside: margin-outside,
    ),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 2 {
        // Header on pages after title and TOC
        set text(size: 9pt, style: "italic")
        if calc.odd(page-num) {
          align(right, title)
        } else {
          align(left, author)
        }
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        align(center, text(size: 10pt, str(page-num)))
      }
    },
  )

  // ==========================================================================
  // TYPOGRAPHY
  // ==========================================================================
  set text(
    font: font-body,
    size: font-size,
    lang: "en",
  )

  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 1.5em,
  )

  // Remove first-line-indent after headings
  show heading: it => {
    it
    par(text(size: 0pt, ""))
  }

  // ==========================================================================
  // HEADING STYLES
  // ==========================================================================

  // Chapter headings (H1)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    set text(size: 24pt, weight: "bold")
    block(it.body)
    v(1em)
  }

  // Section headings (H2)
  show heading.where(level: 2): it => {
    v(1.5em)
    set text(size: 16pt, weight: "bold")
    block(it.body)
    v(0.75em)
  }

  // Subsection headings (H3)
  show heading.where(level: 3): it => {
    v(1em)
    set text(size: 13pt, weight: "bold")
    block(it.body)
    v(0.5em)
  }

  // Minor headings (H4)
  show heading.where(level: 4): it => {
    v(0.75em)
    set text(size: 11pt, weight: "bold", style: "italic")
    block(it.body)
    v(0.5em)
  }

  // ==========================================================================
  // BLOCK QUOTES
  // ==========================================================================
  set quote(block: true)
  show quote: it => {
    set par(first-line-indent: 0em)
    block(
      width: 100%,
      inset: (left: 2em, right: 1em, top: 0.5em, bottom: 0.5em),
      stroke: (left: 2pt + luma(200)),
      it.body
    )
  }

  // ==========================================================================
  // CODE BLOCKS
  // ==========================================================================
  show raw.where(block: true): it => {
    set text(size: 9pt)
    block(
      width: 100%,
      fill: luma(245),
      inset: 1em,
      radius: 4pt,
      it
    )
  }

  show raw.where(block: false): it => {
    box(
      fill: luma(240),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      it
    )
  }

  // ==========================================================================
  // LINKS
  // ==========================================================================
  show link: it => {
    set text(fill: rgb("#0066cc"))
    underline(it)
  }

  // ==========================================================================
  // BODY CONTENT
  // ==========================================================================
  body
}

// ============================================================================
// TITLE PAGE FUNCTION
// ============================================================================
#let title-page(title, author, date: none, subtitle: none) = {
  set page(header: none, footer: none)

  v(30%)
  align(center)[
    #text(size: 32pt, weight: "bold", title)

    #if subtitle != none {
      v(1em)
      text(size: 16pt, style: "italic", subtitle)
    }

    #v(3em)

    #text(size: 18pt, author)

    #if date != none {
      v(4em)
      text(size: 12pt, date)
    }
  ]
  pagebreak()
}

// ============================================================================
// EPIGRAPH FUNCTION (Chapter Quotes)
// ============================================================================
#let epigraph(quote, attribution: none) = {
  set par(first-line-indent: 0em)
  v(1em)
  align(right)[
    #block(
      width: 75%,
      inset: (left: 0em, right: 0em),
      [
        #set text(style: "italic")
        #quote
        #if attribution != none {
          v(0.5em)
          align(right, text(style: "normal", size: 10pt, [— #attribution]))
        }
      ]
    )
  ]
  v(2em)
}

// ============================================================================
// COPYRIGHT PAGE FUNCTION
// ============================================================================
#let copyright-page(
  title: none,
  author: none,
  year: none,
  publisher: none,
  isbn: none,
  edition: "First Edition",
) = {
  set page(header: none, footer: none)
  set text(size: 9pt)
  set par(first-line-indent: 0em, justify: false)

  v(1fr)

  if title != none {
    text(weight: "bold", title)
    linebreak()
  }

  v(1em)

  if year != none and author != none {
    [Copyright © #year #author. All rights reserved.]
    linebreak()
    linebreak()
  }

  [No part of this publication may be reproduced, distributed, or transmitted
  in any form or by any means, including photocopying, recording, or other
  electronic or mechanical methods, without the prior written permission of
  the publisher, except in the case of brief quotations embodied in critical
  reviews and certain other noncommercial uses permitted by copyright law.]

  v(2em)

  if publisher != none {
    [Published by #publisher]
    linebreak()
    linebreak()
  }

  if isbn != none {
    [ISBN: #isbn]
    linebreak()
  }

  if edition != none {
    linebreak()
    edition
  }

  v(2em)

  pagebreak()
}

// ============================================================================
// DEDICATION PAGE FUNCTION
// ============================================================================
#let dedication-page(content) = {
  set page(header: none, footer: none)

  v(30%)
  align(center)[
    #set text(style: "italic")
    #content
  ]
  pagebreak()
}

// ============================================================================
// PART DIVIDER FUNCTION
// ============================================================================
#let part(title, number: none) = {
  pagebreak()
  set page(header: none, footer: none)

  v(40%)
  align(center)[
    #if number != none {
      text(size: 14pt, weight: "bold", [Part #number])
      v(1em)
    }
    #text(size: 28pt, weight: "bold", title)
  ]
  pagebreak()
}
