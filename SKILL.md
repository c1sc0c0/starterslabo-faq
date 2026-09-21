---
name: starterslabo-faq
description: >-
  Reads the Starters Labo FAQ (public site and logged-in portal) and answers
  questions about LABO rules, Peppol, BTW, onkosten, facturatie, and coaches.
  In Claude's GUI, opens mijn.starterslabo.be and waits while the user types
  their password on the website — never in the chat. Use when the user
  mentions Starterslabo FAQ, werkingsbijdrage, or portal boekhouding.
---

# Starters Labo FAQ ingest + Q&A

Two jobs: **ingest** the logged-in FAQ, then **answer** from the local corpus.

Never bake credentials into this skill, never write them to disk, never print the password, never commit `.env`.

## Safe login (Claude Desktop / Cowork / Claude in Chrome)

This is the default for the Claude app. **Do not ask the user to type their password in the chat.**

1. Open `https://mijn.starterslabo.be/login.aspx` in the built-in browser or Claude in Chrome.
2. **Stop.** Tell the user: type email and password **in the Starterslabo form** (the fields on the website), then click **Inloggen**. You must not fill `#InputPassword` or any password field — Anthropic blocks that, and the password must never appear in the conversation.
3. Wait until the URL is no longer `login.aspx` (homepage / FAQ). If they say they are logged in, continue.
4. Open `https://mijn.starterslabo.be/Views/FAQ.aspx`.
5. For each `.card`, read collapsed `.card-body` with `textContent` (not only visible `innerText`) plus attachment names.
6. Also read `https://starterslabo.be/faq/` and `/faq/page/2/`.
7. Answer from that content. Quote the FAQ; do not invent rates.

If there is no browser panel (plain claude.ai chat with no Desktop app), say so: they need the **Claude desktop app** (Pro/Max) so a browser can open beside the chat. Do not fall back to “paste your password here.” Public FAQ questions can still be answered from starterslabo.be without login.

Optional: if **1Password for Claude** is connected, let 1Password fill the login after the user approves the prompt. You still must not read or ask for the password. If that is not available, wait while they type in the website form, or use **Import cookies** / an already-signed-in Claude in Chrome session.

## Credentials (Cursor / Claude Code crawler only)

Only if you are running `scripts/crawl_faq.py` on the user's computer. Prefer env vars over putting the password in the prompt. Never echo it.

Pass them only as environment variables for one crawl command:

```bash
STARTERSLABO_EMAIL='USER' STARTERSLABO_PASSWORD='PASS' python scripts/crawl_faq.py --output starterslabo-faq-corpus
```

Replace `USER` / `PASS` with the values the user just provided. Do not echo the command back with the real password.

## Ingest workflow

1. Resolve the script path (this skill’s `scripts/crawl_faq.py`).
2. Install deps if needed (`pip install -r scripts/requirements.txt` then `playwright install chromium`, or `uv run --with playwright --with pypdf --with python-docx --with openpyxl`).
3. Run the crawler with the user-supplied credentials. Default output: `starterslabo-faq-corpus/` in the workspace.
4. Confirm login succeeded (`Login OK`) and note the article count. If still on `login.aspx`, stop and tell the user the credentials failed.
5. After a successful crawl, answer from the new files — not from memory of an older corpus.

Refresh later by running the same command again.

### Fallback (no Playwright)

If the script cannot run, use a browser:

1. Open `https://mijn.starterslabo.be/login.aspx`
2. Fill `#InputUsername` / `#InputPassword`, click `#BtnSubmit`
3. Open **FAQ** → `https://mijn.starterslabo.be/Views/FAQ.aspx`
4. For each `.card`, read the collapsed `.card-body` (`textContent`, not only visible `innerText`) plus attachment names
5. Also fetch `https://starterslabo.be/faq/` and `/faq/page/2/`
6. Write `FAQ.md` and `public-faq.md` under `starterslabo-faq-corpus/`

## Answer workflow

When the user asks a Starters Labo / LABO / portal question:

1. If `starterslabo-faq-corpus/FAQ.md` is missing, ingest first.
2. Read `FAQ.md`. For PDF/DOCX detail, read the matching file in `extracted/`. For START! / LABO eligibility, read `public-faq.md`.
3. Quote the FAQ or handleiding. Do not invent rates or procedures. If the corpus is silent, say so and point to **Berichten** or the coach.

Corpus layout:

```
starterslabo-faq-corpus/
  FAQ.md              # portal articles
  public-faq.md       # starterslabo.be/faq
  manifest.json
  extracted/*.txt     # text from PDF/DOCX/XLSX bijlagen
  attachments/        # binaries (do not commit)
```

## Script

`scripts/crawl_faq.py` logs in, expands FAQ accordion cards, downloads bijlagen, extracts text, and writes the corpus. Flags: `--output`, `--headed`, `--skip-downloads`. `--email` / `--password` also work; prefer env vars so the password is not in argv.

## Install this skill

**Claude website/app:** user downloads [starterslabo-faq.zip](https://github.com/c1sc0c0/starterslabo-faq/releases/latest/download/starterslabo-faq.zip) and uploads it under Customize → Skills. See the README.

**Cursor / Claude Code:** clone this repo as the skill folder:

```bash
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.cursor/skills/starterslabo-faq
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.claude/skills/starterslabo-faq
```
