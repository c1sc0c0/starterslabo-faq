---
name: starterslabo-faq
description: >-
  Logs into mijn.starterslabo.be with a user-supplied username and password,
  crawls portal FAQ articles and attachments, and answers questions from that
  corpus (werkingsbijdrage, Peppol, onkosten, facturatie, coaches). Use when
  the user mentions Starters Labo FAQ, ingest FAQ, crawl FAQ, or asks how the
  LABO portal or traject rules work.
---

# Starters Labo FAQ ingest + Q&A

Two jobs: **ingest** the logged-in FAQ, then **answer** from the local corpus.

Never bake credentials into this skill, never write them to disk, never print the password, never commit `.env`.

## Credentials

If the user did not give a username and password in this conversation, ask for them. Do not read `.env` or any other saved secret file unless the user explicitly says to.

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

Clone into the skills folder:

```bash
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.cursor/skills/starterslabo-faq
git clone https://github.com/c1sc0c0/starterslabo-faq.git ~/.claude/skills/starterslabo-faq
```
