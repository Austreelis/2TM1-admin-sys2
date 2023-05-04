# This wiki

This wiki is powered by [mdBook](https://rust-lang.github.io/mdBook/), an
open-source static site generator from Markdown by the
[Rust project](https://www.rust-lang.org/).

## Depployments

This wiki is rebuilt and deployed on each push to the `main` branch of the
github repository. It can be read on github pages
[here](https://austreelis.github.io/2tm1-admin-sys2).

It is also deployed on woodytoys' intranet, through the
[documentation website service](../deployment/intra/wiki.md), and is accessible
at `wiki.woodytoys.home`.

## Adding a page

1. **Creating the page's file:**
  Create the directories of all the required parent sections, if necessary. For
  instance, to add a new page about foxes in a new subsections "animals" of the
  new section "creatures", recursively create the directory `creatures/animals`
  under the `src` directory at the root of this book (which is where the
  `book.toml` is). Then create an appropriately named markdown file, e.g.
  `fox.md`, in the directory (e.g. `creatures/animals/fox.md`).
2. **Adding an entry in the summary:**
  Add a properly indented line to the file `src/SUMMARY.md`, which renders the
  side menu. Also add any missing parent section or subsection, with a link
  to a `README.md` in the (sub)section's directory, even if it doesn't exist.
  It should be enough to just insert it in the current main list of
  sections and pages, but should you want to you are not limited to it.
  See mdBook's [`SUMMARY.md`'s documentation][summary-doc] for the different
  ways to format this menu.

You're now ready to write your page !

## Writing a page

The syntax of mdBooks adhere to the [CommonMark](https://commonmark.org/)
standard, with some book-oriented extensions and rust-specific integrations
(the latter being irrelevant for us):

### Text and Paragraphs

Text is rendered relatively predictably: 

```markdown
Here is a line of text.

This is a new line.
```

Will look like you might expect:

Here is a line of text.

This is a new line.

### Headings

Headings use the `#` marker and should be on a line by themselves. More `#` mean smaller headings:

```markdown
#### A heading 

Some text.

##### A smaller heading 

More text.
```

#### A heading 

Some text.

##### A smaller heading 

More text.

### Lists

Lists can be unordered or ordered. Ordered lists will order automatically:

```markdown
* milk
* eggs
* butter

1. carrots
1. celery
1. radishes
```

* milk
* eggs
* butter

1. carrots
1. celery
1. radishes

### Links

Linking to a URL or local file is easy:

```markdown
Use [mdBook](https://github.com/rust-lang/mdBook). 

Read about [mdBook](mdBook.md).

A bare url: <https://www.rust-lang.org>.
```

Use [mdBook](https://github.com/rust-lang/mdBook). 

Read about [mdBook](mdBook.md).

A bare url: <https://www.rust-lang.org>.

----

Relative links that end with `.md` will be converted to the `.html` extension.
It is recommended to use `.md` links when possible.
This is useful when viewing the Markdown file outside of mdBook, for example on GitHub or GitLab which render Markdown automatically.

Links to `README.md` will be converted to `index.html`.
This is done since some services like GitHub render README files automatically, but web servers typically expect the root file to be called `index.html`.

You can link to individual headings with `#` fragments.
For example, `mdbook.md#text-and-paragraphs` would link to the [Text and Paragraphs](#text-and-paragraphs) section above.
The ID is created by transforming the heading such as converting to lowercase and replacing spaces with dashes.
You can click on any heading and look at the URL in your browser to see what the fragment looks like.

### Images

Including images is simply a matter of including a link to them, much like in the _Links_ section above. The following markdown
includes the Rust logo SVG image found in the `images` directory at the same level as this file:

```markdown
![The Rust Logo](images/rust-logo-blk.svg)
```

Produces the following HTML when built with mdBook:

```html
<p><img src="images/rust-logo-blk.svg" alt="The Rust Logo" /></p>
```

Which, of course displays the image like so:

![The Rust Logo](images/rust-logo-blk.svg)

### Extensions

mdBook has several extensions beyond the standard CommonMark specification.

#### Strikethrough

Text may be rendered with a horizontal line through the center by wrapping the
text with two tilde characters on each side:

```text
An example of ~~strikethrough text~~.
```

This example will render as:

> An example of ~~strikethrough text~~.

This follows the [GitHub Strikethrough extension][strikethrough].

#### Footnotes

A footnote generates a small numbered link in the text which when clicked
takes the reader to the footnote text at the bottom of the item. The footnote
label is written similarly to a link reference with a caret at the front. The
footnote text is written like a link reference definition, with the text
following the label. Example:

```text
This is an example of a footnote[^note].

[^note]: This text is the contents of the footnote, which will be rendered
    towards the bottom.
```

This example will render as:

> This is an example of a footnote[^note].
>
> [^note]: This text is the contents of the footnote, which will be rendered
>     towards the bottom.

The footnotes are automatically numbered based on the order the footnotes are
written.

#### Tables

Tables can be written using pipes and dashes to draw the rows and columns of
the table. These will be translated to HTML table matching the shape. Example:

```text
| Header1 | Header2 |
|---------|---------|
| abc     | def     |
```

This example will render similarly to this:

| Header1 | Header2 |
|---------|---------|
| abc     | def     |

See the specification for the [GitHub Tables extension][tables] for more
details on the exact syntax supported.

#### Task lists

Task lists can be used as a checklist of items that have been completed.
Example:

```md
- [x] Complete task
- [ ] Incomplete task
```

This will render as:

> - [x] Complete task
> - [ ] Incomplete task

See the specification for the [task list extension] for more details.

#### Smart punctuation

Some ASCII punctuation sequences will be automatically turned into fancy Unicode
characters:

| ASCII sequence | Unicode |
|----------------|---------|
| `--`           | –       |
| `---`          | —       |
| `...`          | …       |
| `"`            | “ or ”, depending on context |
| `'`            | ‘ or ’, depending on context |

So, no need to manually enter those Unicode characters!

#### MathJax Support

mdBook has support for math equations through
[MathJax](https://www.mathjax.org/).

> **Note:** The usual delimiters MathJax uses are not yet supported. You can't
currently use `$$ ... $$` as delimiters and the `\[ ... \]` delimiters need an
extra backslash to work. Hopefully this limitation will be lifted soon.

>**Note:** When you use double backslashes in MathJax blocks (for example in
> commands such as `\begin{cases} \frac 1 2 \\ \frac 3 4 \end{cases}`) you need
> to add _two extra_ backslashes (e.g., `\begin{cases} \frac 1 2 \\\\ \frac 3 4
> \end{cases}`).

> **Note:** As MathJax renders equations black on transparent, they tend to not
> be easy to read with dark themes.


##### Inline equations
Inline equations are delimited by `\\(` and `\\)`. So for example, to render the
following inline equation \\( \int x dx = \frac{x^2}{2} + C \\) you would write
the following:
```
\\( \int x dx = \frac{x^2}{2} + C \\)
```

##### Block equations
Block equations are delimited by `\\[` and `\\]`. To render the following
equation

\\[ \mu = \frac{1}{N} \sum_{i=0} x_i \\]


you would write:

```bash
\\[ \mu = \frac{1}{N} \sum_{i=0} x_i \\]
```

[strikethrough]: https://github.github.com/gfm/#strikethrough-extension-
[tables]: https://github.github.com/gfm/#tables-extension-
[task list extension]: https://github.github.com/gfm/#task-list-items-extension-
[summary-doc]: https://rust-lang.github.io/mdBook/format/index.html

